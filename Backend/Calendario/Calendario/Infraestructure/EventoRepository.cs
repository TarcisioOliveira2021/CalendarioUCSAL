﻿using Calendario.Entities;
using Calendario.Entities.DTO;
using Calendario.Infraestructure.Context;
using Calendario.Infraestructure.Interface;
using Microsoft.EntityFrameworkCore;

namespace Calendario.Infraestructure
{
    public class EventoRepository(AppDbContext context) : IEventoRepository
    {
        private readonly AppDbContext _context = context;

        public List<EventoDTO> ObterTodos()
        {
            return _context.Eventos
                 .Include(e => e.EventoRecorrentes)
                 .Select(evento => new EventoDTO
                 {
                     Id = evento.Id,
                     Nome = evento.Nome,
                     HoraInicial = evento.HoraInicial,
                     HoraFinal = evento.HoraFinal,
                     EhDiaInteiro = evento.EhDiaInteiro,
                     Data = evento.Data,
                     EventosRecorrentes = evento.EventoRecorrentes.ToList()
                 }).ToList();
        }

        public void Salvar(Evento evento)
        {
            _context.Eventos.Add(evento);
        }
    }
}
