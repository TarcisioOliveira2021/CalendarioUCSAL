using Calendario.Entities;
using Calendario.Entities.DTO;

namespace Calendario.Services.Interface
{
    public interface IEventoService
    {
        void SalvarEvento(Evento evento);
        void DeletarEvento(long id);
        List<EventoDTO> ObterTodos();
    }
}
