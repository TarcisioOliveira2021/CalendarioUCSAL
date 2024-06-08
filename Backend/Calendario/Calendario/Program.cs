using Calendario.Infraestructure;
using Calendario.Infraestructure.Context;
using Calendario.Infraestructure.Interface;
using Calendario.Infraestructure.UnitOfWork;
using Calendario.Infraestructure.UnitOfWork.Interface;
using Calendario.Services;
using Calendario.Services.Interface;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddControllers().AddJsonOptions(opt => opt.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter()));
builder.Services.AddDbContext<AppDbContext>(
    x => x.UseInMemoryDatabase("CalendarioDB")
);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        builder => builder
            .AllowAnyOrigin()
            .AllowAnyHeader()
            .AllowAnyMethod());
});

builder.Services.AddTransient<IEventoService, EventoService>();
builder.Services.AddTransient<IEventoRecorrenteRepository, EventoRecorrenteRepository>();
builder.Services.AddTransient<IEventoRepository, EventoRepository>();
builder.Services.AddTransient<IUnitOfWork, UnitOfWork>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();



var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();

    dbContext.Eventos.Add(
        new Calendario.Entities.Evento
        {
            Nome = "26ª Semana de Mobilização Científica - SEMOC",
            Data = DateTime.Parse("23/10/2024"),
            HoraInicial = "10:00",
            HoraFinal = "12:00",
            EhDiaInteiro = false,
            Recorrencia = Calendario.Entities.Enums.TipoRecorrencia.DIARIAMENTE,
            EventoRecorrentes = new List<Calendario.Entities.EventoRecorrente>()
            {
                new Calendario.Entities.EventoRecorrente
                {
                    HoraInicial = "10:00",
                    HoraFinal = "12:00",
                    Data = DateTime.Parse("24/10/2024")
                },
                new Calendario.Entities.EventoRecorrente
                {
                    HoraInicial = "10:00",
                    HoraFinal = "12:00",
                    Data = DateTime.Parse("25/10/2024")
                },
                new Calendario.Entities.EventoRecorrente
                {
                    HoraInicial = "10:00",
                    HoraFinal = "12:00",
                    Data = DateTime.Parse("26/10/2024")
                },
                new Calendario.Entities.EventoRecorrente
                {
                    HoraInicial = "10:00",
                    HoraFinal = "12:00",
                    Data = DateTime.Parse("27/10/2024")
                }
            }
        }
    );


    dbContext.SaveChanges();
}

app.UseCors("AllowAll");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
