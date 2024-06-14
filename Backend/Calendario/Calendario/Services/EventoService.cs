using Calendario.Entities;
using Calendario.Entities.DTO;
using Calendario.Infraestructure.Context;
using Calendario.Infraestructure.Interface;
using Calendario.Infraestructure.UnitOfWork.Interface;
using Calendario.Services.Interface;
using Microsoft.EntityFrameworkCore;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Calendario.Services
{
    public class EventoService : IEventoService
    {
        private DateTime fimDoSemestre;
        private DateTime dataAtual = DateTime.Now.Date;
        private readonly IEventoRepository eventoRepository;
        private readonly IEventoRecorrenteRepository eventoRecorrenteRepository;
        private readonly IUnitOfWork unidadeDeTrabalho;

        public EventoService(IEventoRepository _eventoRepository, IEventoRecorrenteRepository _eventoRecorrenteRepository, IUnitOfWork _unidadeDeTrabalho)
        {
            this.eventoRepository = _eventoRepository;
            this.eventoRecorrenteRepository = _eventoRecorrenteRepository;
            this.unidadeDeTrabalho = _unidadeDeTrabalho;
        }

        public void SalvarEvento(Evento evento)
        {
            DefinirDataFinalSemestre();
            Validacoes(evento);

            unidadeDeTrabalho.SaveChanges();
        }

        private void Validacoes(Evento evento)
        {
            ValidarDiaInteiro(evento);
            ValidarRecorrencia(evento);
        }

        private void DefinirDataFinalSemestre()
        {
            fimDoSemestre = dataAtual.Month < 6 ? fimDoSemestre = new DateTime(DateTime.Now.Year, 06, 25) : fimDoSemestre = new DateTime(DateTime.Now.Year, 11, 25);
        }

        private void ValidarDiaInteiro(Evento evento)
        {
            if (!evento.EhDiaInteiro && (string.IsNullOrEmpty(evento.HoraInicial) || string.IsNullOrEmpty(evento.HoraFinal)))
                throw new Exception("Evento sem informações de hora inicial e hora final.");

            if (evento.EhDiaInteiro && (!string.IsNullOrEmpty(evento.HoraInicial) || !string.IsNullOrEmpty(evento.HoraFinal)))
                throw new Exception("Evento dia de dia inteiro não deve ter hora inicial nem hora Final.");
        }

        private void ValidarRecorrencia(Evento evento)
        {
            switch (evento.Recorrencia)
            {
                case Entities.Enums.TipoRecorrencia.DIARIAMENTE:
                    SalvarEventoDiariamente(evento, evento.Data.Date);
                    break;

                case Entities.Enums.TipoRecorrencia.SEMANALMENTE:
                    SalvarEventoSemanalmente(evento, evento.Data.Date);
                    break;

                case Entities.Enums.TipoRecorrencia.MENSALMENTE:
                    SalvaEventoMensalmente(evento, evento.Data.Date);
                    break;

                case Entities.Enums.TipoRecorrencia.ANUALMENTE:
                    SalvarEventoAnualmente(evento, evento.Data.Date);
                    break;

                default:
                    SalvarEventoSemRecorrencia(evento);
                    break;
            }
        }

        private void SalvarEventoAnualmente(Evento evento, DateTime dataAtual)
        {
            if (evento.Data.Date == dataAtual)
                dataAtual = dataAtual.AddYears(1);

            if (dataAtual.Year > 2027)
                return;

            EventoRecorrente eventoRecorrente = new EventoRecorrente(evento);
            eventoRecorrente.Data = dataAtual;

            eventoRecorrenteRepository.Salvar(eventoRecorrente);
            SalvarEventoAnualmente(evento, dataAtual.AddYears(1));
        }

        private void SalvarEventoSemanalmente(Evento evento, DateTime dataAtual)
        {
            if (evento.Data.Date == dataAtual)
                dataAtual = dataAtual.AddDays(7);

            if (dataAtual > fimDoSemestre)
                return;

            EventoRecorrente eventoRecorrente = new EventoRecorrente(evento);
            eventoRecorrente.Data = dataAtual;

            eventoRecorrenteRepository.Salvar(eventoRecorrente);
            SalvarEventoSemanalmente(evento, dataAtual.AddDays(7));
        }

        private void SalvaEventoMensalmente(Evento evento, DateTime dataAtual)
        {
            if (evento.Data.Date == dataAtual)
                dataAtual = dataAtual.AddMonths(1);

            if (dataAtual > fimDoSemestre)
                return;

            EventoRecorrente eventoRecorrente = new EventoRecorrente(evento);
            eventoRecorrente.Data = dataAtual;

            eventoRecorrenteRepository.Salvar(eventoRecorrente);
            SalvaEventoMensalmente(evento, dataAtual.AddMonths(1));
        }

        private void SalvarEventoSemRecorrencia(Evento evento)
        {
            eventoRepository.Salvar(evento);
        }

        private void SalvarEventoDiariamente(Evento evento, DateTime dataAtual)
        {
            if (evento.Data.Date == dataAtual)
                dataAtual = dataAtual.AddDays(1);

            if (dataAtual > fimDoSemestre)
                return;

            EventoRecorrente eventoRecorrente = new EventoRecorrente(evento);
            eventoRecorrente.Data = dataAtual;
            eventoRecorrenteRepository.Salvar(eventoRecorrente);

            SalvarEventoDiariamente(evento, dataAtual.AddDays(1));
        }

        public List<EventoAchatadoDTO> ObterTodosAchatado()
        {

            var eventos = eventoRepository.ObterTodosEventosComRecorrencia();
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
                    TipoRecorrencia = evento.Recorrencia.ToString(),
                    IsEventoRecorrente = false,
                    IdPai = null
                };

                eventosAchatados.Add(eventoAchatado);

                if (evento.EventoRecorrentes != null)
                {
                    foreach (var eventoRecorrente in evento.EventoRecorrentes)
                    {
                        var eventoRecorrenteAchatado = new EventoAchatadoDTO
                        {
                            Id = eventoRecorrente.Id,
                            Nome = evento.Nome,
                            EhDiaInteiro = evento.EhDiaInteiro,
                            HoraInicial = eventoRecorrente.HoraInicial,
                            HoraFinal = eventoRecorrente.HoraFinal,
                            Data = eventoRecorrente.Data,
                            TipoRecorrencia = evento.Recorrencia.ToString(),
                            IsEventoRecorrente = true,
                            IdPai = evento.Id
                        };

                        eventosAchatados.Add(eventoRecorrenteAchatado);
                    }
                }
            }

            return eventosAchatados;
        }
        public void DeletarEvento(string idRoute, string dataRoute)
        {
            DeletarEventoRecursivo(long.Parse(idRoute), DateTime.Parse(dataRoute));
        }

        private void DeletarEventoRecursivo(long id, DateTime data)
        {
            Evento? eventoEncontrado = eventoRepository.ObterTodosEventosComRecorrencia().FirstOrDefault(evento => evento.Id == id && evento.Data.Date.Equals(data.Date));
            if (eventoEncontrado == null)
            {

                EventoRecorrente? eventoRecorrenteEncontrado = eventoRepository.ObterTodosEventosComRecorrencia()
                    .SelectMany(evt => evt.EventoRecorrentes)
                    .FirstOrDefault(err => err.Id == id && err.Data.Date.Equals(data.Date));

                if (eventoRecorrenteEncontrado == null)
                    throw new Exception("Evento ou evento recorrente não encontrado");

                eventoRecorrenteRepository.DeletarEvento(eventoRecorrenteEncontrado);
            }
            else
            {
                foreach (var eventoRecorrente in eventoEncontrado.EventoRecorrentes.ToList())
                {
                    DeletarEventoRecursivo(eventoRecorrente.Id, eventoRecorrente.Data);
                }

                eventoRepository.DeletarEvento(eventoEncontrado);
            }

            unidadeDeTrabalho.SaveChanges();
        }

        public List<EventoDTO> ObterTodosEventos()
        {
            return eventoRepository.ObterTodosEventos()
                     .Select(evento => new EventoDTO
                     {
                         Id = evento.Id,
                         Nome = evento.Nome,
                         HoraInicial = evento.HoraInicial,
                         HoraFinal = evento.HoraFinal,
                         EhDiaInteiro = evento.EhDiaInteiro,
                         Data = evento.Data,
                         TipoRecorrencia = evento.Recorrencia.ToString()
                     }).ToList();
        }
    }
}
