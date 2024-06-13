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
        public ActionResult<List<EventoAchatadoDTO>> GetEventoAchatados()
        {
            return _service.ObterTodosAchatado(); 
        }

        [HttpGet("eventos-pai")]
        public ActionResult<List<EventoDTO>> GetEventosPai()
        {
            return _service.ObterTodosEventos();
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
