using Calendario.Entities;
using Calendario.Entities.DTO;
using Calendario.Infraestructure.Context;
using Calendario.Infraestructure.Interface;
using Calendario.Infraestructure.UnitOfWork.Interface;
using Calendario.Services.Interface;
using Microsoft.EntityFrameworkCore;

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
            ValidarDiaInteiro(evento);
            ValidarRecorrencia(evento);

            unidadeDeTrabalho.SaveChanges();
        }
        private void DefinirDataFinalSemestre()
        {
            fimDoSemestre = dataAtual.Month <= 6 ? fimDoSemestre = new DateTime(DateTime.Now.Year, 06, 25) : fimDoSemestre = new DateTime(DateTime.Now.Year, 11, 25);
        }

        private void ValidarDiaInteiro(Evento evento)
        {
            if (!evento.EhDiaInteiro && (evento.HoraInicial == null || evento.HoraFinal == null))
                throw new Exception("Evento sem informações de hora inicial e hora final.");

            if (evento.EhDiaInteiro && (evento.HoraInicial.HasValue || evento.HoraFinal.HasValue))
                throw new Exception("Evento dia de dia inteiro não deve ter hora inicial nem hora Final.");
        }

        private void ValidarRecorrencia(Evento evento)
        {
            switch (evento.Recorrencia)
            {
                case Entities.Enums.TipoRecorrencia.DIARIAMENTE:
                    SalvarEventoDiariamente(evento, dataAtual);
                    break;

                case Entities.Enums.TipoRecorrencia.SEMANALMENTE:
                    SalvarEventoSemanalmente(evento, dataAtual);
                    break;

                case Entities.Enums.TipoRecorrencia.MENSALMENTE:
                    SalvaEventoMensalmente(evento, dataAtual);
                    break;

                case Entities.Enums.TipoRecorrencia.NENHUMA:
                    SalvarEventoSemRecorrencia(evento);
                    break;
            }
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

        public List<EventoDTO> ObterTodos()
        {
            return eventoRepository.ObterTodos();
        }

        public void DeletarEvento(string idRoute, string dataRoute)
        {
            var id = long.Parse(idRoute);
            var data = DateTime.Parse(dataRoute);

            Evento? eventoEncontrado = eventoRepository.ObterTodosEntidade().Where(evento => evento.Id == id && evento.Data.Date.Equals(data.Date)).FirstOrDefault();
            EventoRecorrente? eventoRecorrenteEncontrado = eventoRepository.ObterTodosEntidade().SelectMany(evt => evt.EventoRecorrentes).Where(err => err.Id == id && err.Data.Date.Equals(data.Date)).FirstOrDefault();

            if (eventoEncontrado == null && eventoRecorrenteEncontrado == null)
                throw new Exception("Elemento não encontrado");

            if (eventoEncontrado != null)
                eventoRepository.DeletarEvento(eventoEncontrado);

            if (eventoRecorrenteEncontrado != null)
                eventoRecorrenteRepository.DeletarEvento(eventoRecorrenteEncontrado);

            unidadeDeTrabalho.SaveChanges();
        }
    }
}
