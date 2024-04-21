using Calendario.Entities;
using Calendario.Entities.DTO;

namespace Calendario.Services.Interface
{
    public interface IEventoService
    {
        void VerificarRecorrenciaEvento(Evento evento);
        List<EventoDTO> ObterTodos();
    }
}
