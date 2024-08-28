using ABMInquilinos.app.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ABMInquilinos.app.AccesoADatos.DbContext;
namespace ABMInquilinos.app.AccesoADatos.DAO
{

    public class ProvinciaDAO
    {
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();

        // LISTAR PROVINCIAS
        public List<Provincia> ListarProvincias()
        {
            List<Provincia> lst = new List<Provincia>();
            try
            {
                datos.SetearConsulta("SELECT id_provincia,descripcion FROM PROVINCIAS");
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    Provincia provincia = new Provincia();
                    provincia.IdProvincia = (int)datos.Reader["id_provincia"];
                    provincia.Descripcion = (string)datos.Reader["descripcion"];

                    lst.Add(provincia);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error al cargar Provincias");
            }
            datos.CerrarConexion();
            return lst;
        }

    }
}
