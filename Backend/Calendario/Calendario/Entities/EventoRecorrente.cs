using Calendario.Entities.Enums;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Calendario.Entities
{
    public class EventoRecorrente
    {
        [Key]
        public long Id { get; }

        public long IdPai { get; }
        public Evento Evento { get; set; }

        public DateTime? HoraInicial { get; set; }

        public DateTime? HoraFinal { get; set; }

        public DateTime Data { get; set; }



        public EventoRecorrente()
        {
            
        }

        public EventoRecorrente(Evento evento)
        {
            this.HoraInicial = evento.HoraInicial;
            this.HoraFinal = evento.HoraFinal;
            this.Data = evento.Data;
            this.IdPai = evento.Id;
            this.Evento = evento;
        }
    }
}
