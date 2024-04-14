namespace Calendario.Models
{
    public class EventoViewModel
    {
        public string Nome { get; set; }

        public DateTime Data { get; set; }

        public string Recorrencia { get; set; }

        public bool EhDiaInteiro { get; set; }

        public DateTime Inicio { get; set; }

        public DateTime Fim { get; set; }
    }
}
