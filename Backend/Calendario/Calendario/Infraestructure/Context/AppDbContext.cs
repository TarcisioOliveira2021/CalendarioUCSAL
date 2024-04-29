using Calendario.Entities;
using Microsoft.EntityFrameworkCore;

namespace Calendario.Infraestructure.Context
{
    public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
    {
        public DbSet<Evento> Eventos { get; set; }
        public DbSet<EventoRecorrente> EventoRecorrentes { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Evento>()
                .HasKey(e => e.Id);
            modelBuilder.Entity<Evento>()
                .HasIndex(e => e.Id)
                .IsUnique();
            modelBuilder.Entity<Evento>()
                .HasMany(e => e.EventoRecorrentes)
                .WithOne(er => er.Evento)
                .HasForeignKey(er => er.IdPai)
                .IsRequired(false);

            modelBuilder.Entity<EventoRecorrente>()
                .HasKey(er => er.Id);
            modelBuilder.Entity<EventoRecorrente>()
                .HasIndex(er => er.Id)
                .IsUnique();
        }
    }
}
