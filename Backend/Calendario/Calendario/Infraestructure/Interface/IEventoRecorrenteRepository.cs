using Calendario.Entities;

namespace Calendario.Infraestructure.Interface
{
    public interface IEventoRecorrenteRepository
    {
        void Salvar(EventoRecorrente evento);
    }
}
