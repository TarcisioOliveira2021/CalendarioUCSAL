﻿using Calendario.Entities;
using Calendario.Infraestructure.Context;
using Calendario.Infraestructure.Interface;

namespace Calendario.Infraestructure
{
    public class EventoRecorrenteRepository(AppDbContext context) : IEventoRecorrenteRepository
    {
        private readonly AppDbContext _context = context;

        public void DeletarEvento(EventoRecorrente eventoRecorrenteEncontrado)
        {
            _context.EventoRecorrentes.Remove(eventoRecorrenteEncontrado);
        }

        public void Salvar(EventoRecorrente evento)
        {
            _context.EventoRecorrentes.Add(evento);
        }
    }
}
