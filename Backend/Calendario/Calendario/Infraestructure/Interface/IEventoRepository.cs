using Calendario.Entities;
using Calendario.Entities.DTO;

namespace Calendario.Infraestructure.Interface
{
    public interface IEventoRepository
    {
        void Salvar(Evento evento);

        List<Evento> ObterTodosEventos();

        List<Evento> ObterTodosEventosComRecorrencia();

        void DeletarEvento(Evento evento);
    }
}
