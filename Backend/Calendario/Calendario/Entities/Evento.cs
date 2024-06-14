using Calendario.Entities.Enums;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Calendario.Entities
{
    public class Evento
    {
        [Key]
        public long Id { get; set; }

        [Required(ErrorMessage = "O campo nome é obrigatório !")]
        public string Nome { get; set; }

        [Required(ErrorMessage = "O campo recorrencia é obrigatório !")]
        public TipoRecorrencia Recorrencia { get; set; }

        public string? HoraInicial { get; set; }

        public string? HoraFinal { get; set; }

        public bool EhDiaInteiro { get; set; }

        [Required(ErrorMessage = "O campo Data é obrigatório !")]
        public DateTime Data { get; set; }

        public List<EventoRecorrente>? EventoRecorrentes { get; set; }
    }
}
