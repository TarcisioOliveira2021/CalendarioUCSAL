using Calendario.Entities;
using Calendario.Entities.DTO;

namespace Calendario.Services.Interface
{
    public interface IEventoService
    {
        void SalvarEvento(Evento evento);
        void DeletarEvento(string id, string data);
        List<EventoDTO> ObterTodos();
    }
}
