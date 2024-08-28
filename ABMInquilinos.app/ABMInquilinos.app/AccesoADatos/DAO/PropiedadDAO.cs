using ABMInquilinos.app.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DAO
{
    public class PropiedadDAO
    {
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();

        public List<PropiedadDTO> ListarPropiedades()
        {
            List<PropiedadDTO> propiedades = new List<PropiedadDTO>();
            try
            {
                datos.SetearConsulta(@"select 
                                       p.direccion, 
                                       p.nro_calle, 
                                       p.mt2_propiedad ,
                                       b.descripcion 'barrio', 
                                       c.descripcion 'ciudad', 
                                       prov.descripcion 'descripcion' 
                                       from propiedades p
                                       join barrios b on p.id_barrio = b.id_barrio
                                       join ciudades c on c.id_ciudad = b.id_ciudad
                                       join provincias prov on prov.id_provincia = c.id_provincia");

                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    PropiedadDTO propiedad = new PropiedadDTO();
                    propiedad.Direccion = datos.Reader.GetString(0);
                    propiedad.NroCalle = datos.Reader.GetInt32(1);
                    propiedad.Mts2 = datos.Reader.GetInt32(2);
                    propiedad.Barrio = datos.Reader.GetString(3);
                    propiedad.Ciudad = datos.Reader.GetString(4);
                    propiedad.Provincia = datos.Reader.GetString(5);

                    propiedades.Add(propiedad);
                }
            }
            catch (Exception EX)
            {
                MessageBox.Show(EX.ToString(), "Error");
            }
            datos.CerrarConexion();
            return propiedades;
        }
    }
}