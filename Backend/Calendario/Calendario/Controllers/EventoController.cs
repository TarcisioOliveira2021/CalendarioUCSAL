using Calendario.Models;
using Microsoft.AspNetCore.Mvc;

namespace Calendario.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EventoController : Controller
    {
        [HttpPost ("/CadastrarEvento")]
        public IActionResult Post([FromBody] EventoViewModel evento)
        {

            return Ok();
        }
    }
}
