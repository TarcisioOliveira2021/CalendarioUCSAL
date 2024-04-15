using Calendario.Entities;
using Calendario.Infraestructure;
using Calendario.Services.Interface;

namespace Calendario.Services
{
    public class EventoService(AppDbContext context) : IEventoService
    {
        private readonly AppDbContext _context = context;


        public void SalvarEvento(Evento evento)
        {
            //A recursividade vai acontecer quando o evento tiver recorrência, pq precisa salvar mais de uma vez esse evento.
            try
            {
                

            }catch (Exception)
            {
                throw;
            }



            _context.Eventos.Add(evento);
            _context.SaveChanges();
        }
    }
}
