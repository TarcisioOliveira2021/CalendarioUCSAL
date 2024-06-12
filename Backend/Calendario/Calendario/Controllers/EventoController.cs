using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Calendario.Entities;
using Calendario.Infraestructure;
using Calendario.Entities.Enums;
using Calendario.Services.Interface;
using Calendario.Entities.DTO;

namespace Calendario.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventoController : ControllerBase
    {
        private readonly IEventoService _service;

        public EventoController(IEventoService service)
        {
            _service = service;
        }


        [HttpPost]
        public IActionResult PostEvento(Evento evento)
        {
            try
            {
                _service.SalvarEvento(evento);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }

        [HttpGet]
        public ActionResult<List<EventoDTO>> GetEventos()
        {
            return _service.ObterTodos();
        }

        [HttpGet("eventos-achatados")]
        public ActionResult<List<EventoAchatadoDTO>> GetEventoAchatados()
        {
            var eventos = _service.ObterTodos();
            var eventosAchatados = new List<EventoAchatadoDTO>();

            foreach (var evento in eventos)
            {
                var eventoAchatado = new EventoAchatadoDTO
                {
                    Id = evento.Id,
                    Nome = evento.Nome,
                    EhDiaInteiro = evento.EhDiaInteiro,
                    HoraInicial = evento.HoraInicial,
                    HoraFinal = evento.HoraFinal,
                    Data = evento.Data,
                    TipoRecorrencia = evento.TipoRecorrencia,
                    IsEventoRecorrente = false,
                    IdPai = null
                };

                eventosAchatados.Add(eventoAchatado);

                if (evento.EventosRecorrentes != null)
                {
                    foreach (var eventoRecorrente in evento.EventosRecorrentes)
                    {
                        var eventoRecorrenteAchatado = new EventoAchatadoDTO
                        {
                            Id = eventoRecorrente.Id,
                            Nome = evento.Nome,
                            EhDiaInteiro = evento.EhDiaInteiro,
                            HoraInicial = eventoRecorrente.HoraInicial,
                            HoraFinal = eventoRecorrente.HoraFinal,
                            Data = eventoRecorrente.Data,
                            TipoRecorrencia = evento.TipoRecorrencia,
                            IsEventoRecorrente = true,
                            IdPai = evento.Id
                        };

                        eventosAchatados.Add(eventoRecorrenteAchatado);
                    }
                }
            }

            return eventosAchatados;
        }


        [HttpDelete("{id}&{data}")]
        public IActionResult DeletarEvento([FromRoute] string id, [FromRoute] string data)
        {
            try
            {
                _service.DeletarEvento(id, data);
            }
            catch (Exception ex)
            {
                if(ex.Message == "Evento não encontrado")
                    return NotFound(ex.Message);

                return BadRequest(ex.Message);
            }

            return Ok();
        }
    }
}
