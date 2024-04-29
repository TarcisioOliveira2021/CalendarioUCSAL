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
        public ActionResult<List<EventoDTO>> GetEvento()
        {
            return _service.ObterTodos();
        }


        [HttpDelete("{id},{data}")]
        public IActionResult DeletarEvento()
        {
            try
            {
                
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }
        //public async Task<IActionResult> DeleteEvento(int id)
        //{
        //    var evento = await _context.Eventos.FindAsync(id);
        //    if (evento == null)
        //    {
        //        return NotFound();
        //    }

        //    _context.Eventos.Remove(evento);
        //    await _context.SaveChangesAsync();

        //    return NoContent();
        //}
    }
}
