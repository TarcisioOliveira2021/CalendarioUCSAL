using Calendario.Entities;
using Calendario.Entities.DTO;

namespace Calendario.Infraestructure.Interface
{
    public interface IEventoRepository
    {
        void Salvar(Evento evento);

        List<EventoDTO> ObterTodos();
    }
}
