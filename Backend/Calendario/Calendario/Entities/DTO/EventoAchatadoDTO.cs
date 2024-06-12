namespace Calendario.Entities.DTO
{
    public class EventoAchatadoDTO
    {
        public long Id { get; set; }
        public string Nome { get; set; }
        public bool EhDiaInteiro { get; set; }
        public string? HoraInicial { get; set; }
        public string? HoraFinal { get; set; }
        public DateTime Data { get; set; }
        public string TipoRecorrencia { get; set; }
        public bool IsEventoRecorrente { get; set; } 
        public long? IdPai { get; set; } 
    }
}
