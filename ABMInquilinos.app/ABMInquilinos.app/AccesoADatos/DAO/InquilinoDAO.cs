using ABMInquilinos.app.DataTransferObjects;
using ABMInquilinos.app.Dominio;
using ABMInquilinos.app.Servicios;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.AccesoADatos.DAO
{
    public class InquilinoDAO
    {
        private AccesoADatos.DbContext.AccesoADatos datos = new AccesoADatos.DbContext.AccesoADatos();
        // LISTAR LOS INQUILINOS
        public List<Inquilino> ListarInquilinos(Filtro filtro = null)
        {
            List<Inquilino> inquilinos = new List<Inquilino>();
            try
            {
                string consulta = @"SELECT
                                        I.id_inquilino,
                                        I.nombre,
                                        I.apellido,
                                        I.fec_nac,
                                        I.direccion,
                                        I.nro_calle,
                                        I.alquilando,
                                        I.estado,
                                        I.nro_doc,
                                        I.id_barrio,
                                        b.descripcion 'barrio',
                                        c.id_ciudad,
                                        c.descripcion 'ciudad',
                                        p.id_provincia,
                                        p.descripcion 'provincia',
                                        I.id_tipo_doc,
                                        td.descripcion 'tipo-doc'
                                        FROM inquilinos I
                                        JOIN tipos_doc td on td.id_tipo_doc = i.id_tipo_doc
                                        JOIN barrios b on i.id_barrio = b.id_barrio
                                        JOIN ciudades c on c.id_ciudad  = b.id_ciudad
                                        JOIN provincias p on c.id_provincia = p.id_provincia
                                        WHERE I.estado = 1";
                if (filtro != null)
                {
                    switch (filtro.Campo)
                    {
                        case "Nombre":
                            consulta += swichtCriterio(filtro.Criterio, "nombre", filtro.Valor);
                            break;
                        case "Apellido":
                            consulta += swichtCriterio(filtro.Criterio, "apellido", filtro.Valor);
                            break;
                        default:
                            consulta += swichtCriterio(filtro.Criterio, "nro_doc", filtro.Valor);
                            break;
                    }
                }
                datos.SetearConsulta(consulta);
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    Inquilino aux = new Inquilino();

                    aux.IdInquilino = (int)datos.Reader["id_inquilino"];
                    aux.Nombre = (string)datos.Reader["nombre"];
                    aux.Apellido = (string)datos.Reader["apellido"];
                    aux.FechaNacimiento = (DateTime)datos.Reader["fec_nac"];
                    aux.Direccion = (string)datos.Reader["direccion"];
                    aux.NroCalle = (int)datos.Reader["nro_calle"];
                    aux.Alquilando = (bool)datos.Reader["alquilando"];
                    aux.Estado = (bool)datos.Reader["estado"];
                    aux.NroDoc = (int)datos.Reader["nro_doc"];

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
                    aux.Barrio = barrio;

                    TipoDocumento tipoDoc = new TipoDocumento();
                    tipoDoc.IdTipoDoc = (int)datos.Reader["id_tipo_doc"];
                    tipoDoc.Descripcion = (string)datos.Reader["tipo-doc"];
                    aux.TipoDocumento = tipoDoc;

                    inquilinos.Add(aux);
                }
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.ToString(), "Error");
            }
            datos.CerrarConexion();
            return inquilinos;

        }
        private string swichtCriterio(string criterio, string campo, string valor)
        {
            string query;
            switch (criterio)
            {
                case "Comienza con":
                    query = $" AND {campo} like '{valor}%'";
                    break;

                case "Termina con":
                    query = $" AND {campo} like '%{valor}'";
                    break;

                default:
                    query = $" AND {campo} like '%{valor}%'";
                    break;
            }
            return query;
        }

    // INSERTAR NUEVO INQUILINO
    public bool NuevoInquilino(Inquilino inquilino)
        {
            bool res = true;
            try
            {
                datos.SetearConsulta("INSERT INTO inquilinos (nombre,apellido,id_tipo_doc,nro_doc,fec_nac,direccion,nro_calle,id_barrio,alquilando) values(@nombre,@apellido,@id_tipo_doc,@nro_doc,@fec_nac,@direccion,@nro_calle,@id_barrio,@alquilando)");
                datos.setearParametro("@nombre", inquilino.Nombre);
                datos.setearParametro("@apellido", inquilino.Apellido);
                datos.setearParametro("@id_tipo_doc", inquilino.TipoDocumento.IdTipoDoc);
                datos.setearParametro("@nro_doc", inquilino.NroDoc);
                datos.setearParametro("@fec_nac", inquilino.FechaNacimiento);
                datos.setearParametro("@direccion", inquilino.Direccion);
                datos.setearParametro("@nro_calle", inquilino.NroCalle);
                datos.setearParametro("@id_barrio", inquilino.Barrio.IdBarrio);
                datos.setearParametro("@alquilando", inquilino.Alquilando);
                datos.EjecutarAccion();

            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.ToString(), "Error");
            }
            datos.CerrarConexion();
            return res;

        }
        // MODIFICAR INQUILINO
        public bool ModificarInquilino(Inquilino inquilino)
        {
            bool res = true;
            try
            {
                datos.SetearConsulta("update inquilinos set nombre = @nombre , apellido = @apellido, id_tipo_doc = @id_tipo_doc, nro_doc = @nro_doc, fec_nac = @fec_nac, direccion = @direccion,nro_calle = @nro_calle ,id_barrio = @id_barrio, alquilando = @alquilando WHERE id_inquilino = @id_inquilino;");
                datos.setearParametro("@id_inquilino", inquilino.IdInquilino);
                datos.setearParametro("@nombre", inquilino.Nombre);
                datos.setearParametro("@apellido", inquilino.Apellido);
                datos.setearParametro("@id_tipo_doc", inquilino.TipoDocumento.IdTipoDoc);
                datos.setearParametro("@nro_doc", inquilino.NroDoc);
                datos.setearParametro("@fec_nac", inquilino.FechaNacimiento);
                datos.setearParametro("@direccion", inquilino.Direccion);
                datos.setearParametro("@nro_calle", inquilino.NroCalle);
                datos.setearParametro("@id_barrio", inquilino.Barrio.IdBarrio);
                datos.setearParametro("@alquilando", inquilino.Alquilando);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error la modificar el inquilino.");
            }
            datos.CerrarConexion();
            return res;
        }

        // ELIMINAR INQUILINO BAJA LOGICA
        // UTLIZAMOS ESTE METODO EN VES DE LA BAJA FISICA PARA NO TENER ERRORES DE INTEGRIDAD REFERENCIAL.
        public bool BajaLogicaInquilino(int idInquilino)
        {
            bool res = true;
            try
            {
                datos.SetearConsulta("update inquilinos set estado = 0 where id_inquilino = " + idInquilino);
                datos.EjecutarAccion();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error");
            }
            datos.CerrarConexion();
            return res;
        }
        // ELIMINAR INQUILINO BAJA FISICA
        public bool EliminarInquilino(int idInquilino)
        {
            bool res = true;
            try
            {
                datos.SetearConsulta("delete from inquilinos where id_inquilino =" + idInquilino);
                datos.EjecutarAccion();

            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.ToString(), "Error");
            }
            datos.CerrarConexion();
            return res;
        }

        // LISTAR CONTRATO INQUILINO
        public List<object> ListarContratoYPropiedad(int idInquilino)
        {
            List<object> list = new List<object>();
            try
            {
                datos.SetearConsulta("SELECT C.id_contrato, C.fec_inicio,C.fec_fin,C.anios_contrato,c.monto_alquiler,p.direccion,p.nro_calle,p.mt2_propiedad, p.id_propiedad FROM INQUILINOS I JOIN CONTRATOS C ON I.Id_inquilino = C.id_inquilino JOIN PROPIEDADES P ON P.ID_PROPIEDAD = C.ID_PROPIEDAD WHERE I.id_inquilino = " + idInquilino);
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    ContratoDTO contratoDTO = new ContratoDTO();
                    contratoDTO.NroContrato = datos.Reader.GetInt32(0);
                    contratoDTO.FecInicio = datos.Reader.GetDateTime(1);
                    contratoDTO.FecFin = datos.Reader.GetDateTime(2);
                    contratoDTO.DuracionAnios = datos.Reader.GetInt32(3);
                    contratoDTO.MontoAlquiler = datos.Reader.GetDecimal(4);
                    PropiedadDTO propiedadDTO = new PropiedadDTO();
                    propiedadDTO.Direccion = datos.Reader.GetString(5);
                    propiedadDTO.NroCalle = datos.Reader.GetInt32(6);
                    propiedadDTO.Mts2 = datos.Reader.GetInt32(7);
                    propiedadDTO.IdPropiedad = datos.Reader.GetInt32(8);
                    list.Add(contratoDTO);
                    list.Add(propiedadDTO);
                }
            }
            catch (Exception)
            {

                throw;
            }
            datos.CerrarConexion();
            return list;
        }
        // LISTAR IMAGENES PROPIEDAD
        public List<ImagenesPropiedadDTO> ListarImagenesProp(int idPropiedad)
        {
            List<ImagenesPropiedadDTO> imagenesPropiedad = new();
            try
            {
                datos.SetearConsulta("SELECT IMGP.url_imagen FROM imagenes_propiedad IMGP JOIN propiedades p on IMGP.ID_PROPIEDAD = p.ID_PROPIEDAD WHERE p.ID_PROPIEDAD = " + idPropiedad);
                datos.EjecutarLectura();
                while (datos.Reader.Read())
                {
                    ImagenesPropiedadDTO img = new();
                    img.urlImagen = datos.Reader.GetString(0);
                    imagenesPropiedad.Add(img);
                }
            }
            catch (Exception)
            {

                throw;
            }
            datos.CerrarConexion();
            return imagenesPropiedad;
        }

    }
}
