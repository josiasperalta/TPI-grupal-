namespace ABMInquilinos.app.Dominio
{
    public class Provincia
    {
        public int IdProvincia { get; set; }
        public string Descripcion { get; set; }
        public override string ToString()
        {
            return Descripcion;
        }
    }
}