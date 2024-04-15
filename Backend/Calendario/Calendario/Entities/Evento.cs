using Calendario.Entities.Enums;

namespace Calendario.Entities
{
    public class Evento
    {
        public int Id { get; set; }

        public string Nome { get; set; }

        public DateTime Data { get; set; }

        public TipoRecorrencia Recorrencia { get; set; }

        public bool EhDiaInteiro { get; set; }

        public DateTime Inicio { get; set; }

        public DateTime Fim { get; set; }
    }
}
