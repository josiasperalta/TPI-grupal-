using ABMInquilinos.app.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DAO
{
    public class CiudadDAO
    {
        // LISTAR CIUDADES
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();

        public List<Ciudad> ListarCiudades()
        {
            List<Ciudad> lst = new List<Ciudad>();
            try
            {
                string consulta = "SELECT c.id_ciudad, c.descripcion 'ciudad', p.id_provincia ,p.descripcion 'provincia' FROM CIUDADES C JOIN PROVINCIAS P ON C.ID_PROVINCIA = P.ID_PROVINCIA";
                datos.SetearConsulta(consulta);
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    Ciudad ciudad = new Ciudad();
                    ciudad.IdCiudad = (int)datos.Reader["id_ciudad"];
                    ciudad.Descripcion = (string)datos.Reader["ciudad"];

                    Provincia provincia = new Provincia();
                    provincia.IdProvincia = (int)datos.Reader["id_provincia"];
                    provincia.Descripcion = (string)datos.Reader["provincia"];

                    ciudad.Provincia = provincia;

                    lst.Add(ciudad);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error al cargar Ciudades");
            }
            datos.CerrarConexion();
            return lst;
        }
    }
}
