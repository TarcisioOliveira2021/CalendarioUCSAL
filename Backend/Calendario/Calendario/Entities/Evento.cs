using Calendario.Entities.Enums;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Calendario.Entities
{
    public class Evento
    {
        [Key]
        public long Id { get; set; }

        public string Nome { get; set; }

        public TipoRecorrencia Recorrencia { get; set; }

        public DateTime? HoraInicial { get; set; }

        public DateTime? HoraFinal { get; set; }

        public bool EhDiaInteiro { get; set; }

        public DateTime Data { get; set; }

        public List<EventoRecorrente>? EventoRecorrentes { get; set; }
    }
}
