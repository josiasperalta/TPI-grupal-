using ABMInquilinos.app.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DAO
{
    public class ContratoDAO
    {
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();

        public List<ContratoDTO> ListarContratos()
        {
            List<ContratoDTO> contratos = new List<ContratoDTO>();
            try
            {
                datos.SetearConsulta("select c.monto_alquiler, c.fec_inicio, c.fec_fin, c.anios_contrato from contratos c");
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    ContratoDTO contrato = new ContratoDTO();
                    contrato.MontoAlquiler = datos.Reader.GetDecimal(0) ;
                    contrato.FecInicio = datos.Reader.GetDateTime(1);
                    contrato.FecFin = datos.Reader.GetDateTime(2);
                    contrato.DuracionAnios = datos.Reader.GetInt32(3);
                    contratos.Add(contrato);
                }

            }
            catch (Exception EX)
            {

                MessageBox.Show(EX.ToString(), "Error");
            }
            datos.CerrarConexion();
            return contratos;
        }

    }
}
