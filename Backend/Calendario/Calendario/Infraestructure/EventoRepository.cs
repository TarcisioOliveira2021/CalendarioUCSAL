using Calendario.Entities;
using Calendario.Entities.DTO;
using Calendario.Infraestructure.Context;
using Calendario.Infraestructure.Interface;
using Microsoft.EntityFrameworkCore;

namespace Calendario.Infraestructure
{
    public class EventoRepository(AppDbContext context) : IEventoRepository
    {
        private readonly AppDbContext _context = context;

        public void DeletarEvento(Evento evento)
        {
            _context.Eventos.Remove(evento);
        }

        public List<Evento> ObterTodosEventos()
        {
            return _context.Eventos.ToList();
        }

        public List<Evento> ObterTodosEventosComRecorrencia()
        {
            return _context.Eventos.Include(e=> e.EventoRecorrentes).ToList();
        }

        public void Salvar(Evento evento)
        {
            _context.Eventos.Add(evento);
        }
    }
}
