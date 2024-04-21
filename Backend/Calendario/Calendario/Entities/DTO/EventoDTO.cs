namespace Calendario.Entities.DTO
{
    public class EventoDTO
    {
        public long Id {  get; set; }
        public string Nome { get; set; }
        public bool EhDiaInteiro { get; set; }
        public DateTime? HoraInicial { get; set; }
        public DateTime? HoraFinal { get; set; }
        public DateTime Data { get; set; }
        public List<EventoRecorrente>? EventosRecorrentes { get; set; }
    }
}
