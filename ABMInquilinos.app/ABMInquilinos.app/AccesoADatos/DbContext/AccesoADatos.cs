using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DbContext
{
    public class AccesoADatos
    {
        // DAO DATABA ACCESS OBJET
        // Repositorio 
        public AccesoADatos()
        {
            _connection = new SqlConnection("server=.\\SQLEXPRESS; database=INMOBILIARIA_DB; integrated security=true");
            cmd = new SqlCommand();
        }
        private SqlConnection _connection;
        private SqlCommand cmd;
        private SqlDataReader reader;
        public SqlDataReader Reader
        {
            get { return reader; }
        }

        public void SetearConsulta(string consulta)
        {
            try
            {
                cmd.CommandText = consulta;
                cmd.CommandType = System.Data.CommandType.Text;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "No se pudo setear la consulta");
            }
        }

        public void EjecutarLectura()
        {
            cmd.Connection = _connection;
            try
            {
                _connection.Open();
                reader = cmd.ExecuteReader();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "No se puede leer la consulta");
            }
        }
        public void EjecutarAccion()
        {
            cmd.Connection = _connection;
            try
            {
                _connection.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "No se puede ejecutar la accion");
            }
        }
        public void setearParametro(string campo, object valor)
        {
            cmd.Parameters.AddWithValue(campo, valor);
        }


        public void CerrarConexion()
        {
            try
            {
                if (reader != null)
                {
                    reader.Close();
                }
                _connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "No se pudo cerrar la conexion");
            }
        }
    }

}
