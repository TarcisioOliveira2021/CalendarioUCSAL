namespace Calendario.Entities.DTO
{
    public struct EventoRecorrenteDTO
    {
        public long Id { get; set; }

        public long IdPai { get; set; }

        public string? HoraInicial { get; set; }

        public string? HoraFinal { get; set; }

        public DateTime Data { get; set; }
    }
}
