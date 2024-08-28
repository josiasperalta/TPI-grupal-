using ABMInquilinos.app.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DAO
{
    public class BarrioDAO
    {
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();

        // LISTAR BARRIOS
        // UN METODO QUE TRAIGA A TODOS LOS BARRIOS TIENE QUE SER PUBLIC LIST<Barrio> ListarBarrios()
        public List<Barrio> ListarBarrios()
        {
            List<Barrio> lst = new List<Barrio>();
            try
            {
                datos.SetearConsulta(@"SELECT B.id_barrio,B.descripcion 'barrio', C.id_ciudad,C.descripcion 'ciudad',P.id_provincia, P.descripcion 'provincia'  
                              FROM BARRIOS B 
                              JOIN ciudades C ON C.id_ciudad = B.id_ciudad 
                              JOIN provincias P ON C.id_provincia = P.id_provincia");
                datos.EjecutarLectura();


                while (datos.Reader.Read())
                {
                    Barrio barrio = new Barrio();
                    barrio.IdBarrio = (int)datos.Reader["id_barrio"];
                    barrio.Descripcion = (string)datos.Reader["barrio"];

                    Ciudad ciudad = new Ciudad();
                    ciudad.IdCiudad = (int)datos.Reader["id_ciudad"];
                    ciudad.Descripcion = (string)datos.Reader["ciudad"];

                    Provincia provincia = new Provincia();
                    provincia.IdProvincia = (int)datos.Reader["id_provincia"];
                    provincia.Descripcion = (string)datos.Reader["provincia"];

                    ciudad.Provincia = provincia;
                    barrio.Ciudad = ciudad;

                    lst.Add(barrio);


                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error");
            }

            datos.CerrarConexion();
            return lst;
        }

    }
}
