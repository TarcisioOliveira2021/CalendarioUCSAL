using Microsoft.AspNetCore.Mvc;

namespace Calendario.Controllers
{
    public class EventoController : Controller
    {
        [HttpPost ("/cadastrar-evento")]
        public IActionResult Post()
        {
            return Ok();
        }
    }
}
