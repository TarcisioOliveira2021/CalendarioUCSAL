namespace Calendario.Models
{
    public class EventoViewModel
    {
        public required string Nome { get; set; }

        public required DateTime Data { get; set; }

        public required string Recorrencia { get; set; }

        public required bool EhDiaInteiro { get; set; }

        public required DateTime Inicio { get; set; }

        public required DateTime Fim { get; set; }
    }
}
