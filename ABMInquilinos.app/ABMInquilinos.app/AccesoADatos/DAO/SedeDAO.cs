using ABMInquilinos.app.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DAO
{
    public class SedeDAO
    {
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();

        public List<SedeDTO> ListarSedes()
        {
            List<SedeDTO> sedes = new List<SedeDTO>();
            try
            {
                datos.SetearConsulta(@"Select s.nombre 'Sede', 
                                        s.direccion 'Calle', 
                                        s.nro_calle 'Nro', 
                                        b.descripcion 'Barrio', 
                                        c.descripcion 'Ciudad', 
                                        p.descripcion 'Provincia'
                                        from sedes s
                                        join barrios b on s.id_barrio = b.id_barrio
                                        join ciudades c on b.id_ciudad = c.id_ciudad
                                        join provincias p on c.id_provincia = p.id_provincia");
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    SedeDTO sede = new SedeDTO();
                    sede.Nombre = datos.Reader.GetString(0);
                    sede.Direccion = datos.Reader.GetString(1);
                    sede.Direccion += " " + datos.Reader.GetInt32(2);
                    sede.Barrio = datos.Reader.GetString(3);
                    sede.Ciudad = datos.Reader.GetString(4);
                    sede.Provincia = datos.Reader.GetString(5);

                    sedes.Add(sede);
                }
            }
            catch (Exception EX)
            {
                MessageBox.Show(EX.ToString(), "Error");
            }
            datos.CerrarConexion();
            return sedes;
        }
    }
}
