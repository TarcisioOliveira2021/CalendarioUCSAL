namespace Calendario.Entities.DTO
{
    public struct EventoRecorrenteDTO
    {
        public long Id { get; set; }

        public long IdPai { get; set; }

        public DateTime? HoraInicial { get; set; }

        public DateTime? HoraFinal { get; set; }

        public DateTime Data { get; set; }
    }
}
