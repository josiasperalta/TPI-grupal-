using ABMInquilinos.app.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DAO
{
    public class TipoDocumentoDAO
    {
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();

        // LISTAR Tipos de Documento
        public List<TipoDocumento> ListarTiposDoc()
        {
            List<TipoDocumento> lst = new List<TipoDocumento>();
            try
            {
                datos.SetearConsulta("SELECT id_tipo_doc, descripcion FROM TIPOS_DOC");
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    TipoDocumento tipoDocumento = new TipoDocumento();
                    tipoDocumento.IdTipoDoc = (int)datos.Reader["id_tipo_doc"];
                    tipoDocumento.Descripcion = (string)datos.Reader["descripcion"];

                    lst.Add(tipoDocumento);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error al cargar Tipo de Documento");
            }
            datos.CerrarConexion();
            return lst;
        }

    }
}
