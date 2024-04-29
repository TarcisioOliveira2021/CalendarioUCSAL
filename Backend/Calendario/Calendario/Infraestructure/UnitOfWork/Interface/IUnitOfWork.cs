namespace Calendario.Infraestructure.UnitOfWork.Interface
{
    public interface IUnitOfWork
    {
        void SaveChanges();
        void Dispose();
    }
}
