using Calendario.Entities;
using Microsoft.EntityFrameworkCore;

namespace Calendario.Infraestructure
{
    public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
    {
        public DbSet<Evento> Eventos { get; set; }
    }
}
