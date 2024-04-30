namespace Calendario.Entities.DTO
{
    public struct EventoDTO
    {
        public long Id {  get; set; }
        public string Nome { get; set; }
        public bool EhDiaInteiro { get; set; }
        public DateTime? HoraInicial { get; set; }
        public DateTime? HoraFinal { get; set; }
        public DateTime Data { get; set; }
        public List<EventoRecorrenteDTO>? EventosRecorrentes { get; set; }
    }
}
