using Calendario.Entities;
using Calendario.Entities.DTO;
using Calendario.Infraestructure;
using Calendario.Services.Interface;
using Microsoft.EntityFrameworkCore;

namespace Calendario.Services
{
    public class EventoService(AppDbContext context) : IEventoService
    {
        private readonly AppDbContext _context = context;
        private readonly DateTime fimDoAno = new DateTime(DateTime.Now.Year, 12, 23);
        private readonly DateTime segunda = new DateTime(DateTime.Now.Year, 04, 22);

        public void VerificarRecorrenciaEvento(Evento evento)
        {
            try
            {
                DateTime dataAtual = DateTime.Now.Date;

                switch (evento.Recorrencia)
                {
                    case Entities.Enums.TipoRecorrencia.DIARIAMENTE:
                        SalvarEventoDiariamente(evento, dataAtual);
                        break;

                    case Entities.Enums.TipoRecorrencia.SEMANALMENTE:
                        break;

                    case Entities.Enums.TipoRecorrencia.ANUALMENTE:
                        break;

                    case Entities.Enums.TipoRecorrencia.NENHUMA:
                        SalvarEventoSemRecorrencia(evento);
                        break;
                }

                _context.SaveChanges();
            }
            catch (Exception)
            {
                throw;
            }
        }

        private void SalvarEventoSemRecorrencia(Evento evento)
        {
            _context.Eventos.Add(evento);
        }

        private void SalvarEventoDiariamente(Evento evento, DateTime dataAtual)
        {
            if (dataAtual > segunda)
                return;

            EventoRecorrente eventoRecorrente = new EventoRecorrente(evento);
            eventoRecorrente.Data = dataAtual;

            _context.EventoRecorrentes.Add(eventoRecorrente);
            SalvarEventoDiariamente(evento, dataAtual.AddDays(1));
        }

        public List<EventoDTO> ObterTodos()
        {
            var eventosDTO = _context.Eventos
                .Include(e => e.EventoRecorrentes)
                .Select(evento => new EventoDTO
                {
                    Id = evento.Id,
                    Nome = evento.Nome,
                    HoraInicial = evento.EventoRecorrentes.Any() ? evento.EventoRecorrentes.FirstOrDefault().HoraInicial : null,
                    HoraFinal = evento.EventoRecorrentes.Any() ? evento.EventoRecorrentes.FirstOrDefault().HoraFinal : null,
                    EhDiaInteiro = evento.EhDiaInteiro,
                    Data = evento.EventoRecorrentes.Any() ? evento.EventoRecorrentes.FirstOrDefault().Data : evento.Data,
                    EventosRecorrentes = evento.EventoRecorrentes.ToList()
                })
                .ToList();

            return eventosDTO;
        }


    }
}
