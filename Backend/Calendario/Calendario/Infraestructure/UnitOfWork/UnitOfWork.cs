using Calendario.Infraestructure.Context;
using Calendario.Infraestructure.UnitOfWork.Interface;

namespace Calendario.Infraestructure.UnitOfWork
{
    public class UnitOfWork(AppDbContext context) : IUnitOfWork
    {
        private readonly AppDbContext _context = context;

        public void SaveChanges()
        {
            _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
