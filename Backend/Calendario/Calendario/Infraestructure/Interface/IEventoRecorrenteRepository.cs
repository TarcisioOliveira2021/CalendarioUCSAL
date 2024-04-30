using Calendario.Entities;

namespace Calendario.Infraestructure.Interface
{
    public interface IEventoRecorrenteRepository
    {
        void DeletarEvento(EventoRecorrente eventoRecorrenteEncontrado);
        void Salvar(EventoRecorrente evento);
    }
}
