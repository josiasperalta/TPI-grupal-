using ABMInquilinos.app.AccesoADatos.DAO;
using ABMInquilinos.app.DataTransferObjects;
using ABMInquilinos.app.Dominio;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ABMInquilinos.app.Vistas
{
    public partial class FrmDetalleInquilino : Form
    {
        private Inquilino _inquilino;
        private List<ImagenesPropiedadDTO> _imagenes;
        private int ultimaPosicion;

        public FrmDetalleInquilino(Inquilino inquilino)
        {
            InitializeComponent();
            _inquilino = inquilino;
            this.Size = new Size(500, 530);
            this.StartPosition = FormStartPosition.CenterParent;
        }

        private void FrmDetalleInquilino_Load(object sender, EventArgs e)
        {
            pnlDetalleContrato.Visible = false;

            txtNombre.Text = _inquilino.Nombre;
            txtApellido.Text = _inquilino.Apellido;
            txtBarrio.Text = _inquilino.Barrio.Descripcion;
            txtCiudad.Text = _inquilino.Barrio.Ciudad.Descripcion;
            txtProvincia.Text = _inquilino.Barrio.Ciudad.Provincia.Descripcion;
            txtTipoDoc.Text = _inquilino.TipoDocumento.Descripcion;
            txtDoc.Text = _inquilino.NroDoc.ToString();
            txtDireccion.Text = _inquilino.Direccion + " " + _inquilino.NroCalle.ToString();
            chkAlquilando.Checked = _inquilino.Alquilando;

            if (!_inquilino.Alquilando)
            {
                chkDatosContrato.Visible = false;
            }

        }
        private void chkDatosContrato_Click(object sender, EventArgs e)
        {
            if (chkDatosContrato.Checked)
            {
                InquilinoDAO inquilinoDAO = new InquilinoDAO();
                List<Object> lista = inquilinoDAO.ListarContratoYPropiedad(_inquilino.IdInquilino);
                if (lista.Count == 2)
                {
                    ContratoDTO contratoDTO = (ContratoDTO)lista[0];
                    PropiedadDTO propiedadDTO = (PropiedadDTO)lista[1];

                    txtNroContrato.Text = contratoDTO.NroContrato.ToString();
                    txtInicio.Text = contratoDTO.FecInicio.ToShortDateString();
                    txtFin.Text = contratoDTO.FecFin.ToShortDateString();
                    txtDuracion.Text = contratoDTO.DuracionAnios.ToString();
                    txtMonto.Text = contratoDTO.MontoAlquiler.ToString();

                    lbMts2.Text = "Mts2 : " + propiedadDTO.Mts2.ToString();
                    txtDireccionPropiedad.Text = propiedadDTO.Direccion + " " + propiedadDTO.NroCalle.ToString();

                    _imagenes = inquilinoDAO.ListarImagenesProp(propiedadDTO.IdPropiedad);
                    if (_imagenes.Count() >= 1)
                    {
                        pbImagen.ImageLocation = _imagenes[0].urlImagen;
                        ultimaPosicion = 1;
                        lbContador.Text = $"{ultimaPosicion}/{_imagenes.Count()}";
                        if (_imagenes.Count() == 1)
                        {
                            btnAnterior.Enabled = false;
                            btnSiguiente.Enabled = false;
                        }
                    }
                    else
                    {
                        pbImagen.ImageLocation = "https://s3.oss.go.id/oss/logo/notfound.jpg";
                    }

                    this.Size = new Size(980, 530);
                    this.StartPosition = FormStartPosition.Manual;
                    this.Location = new Point(this.Location.X - 245, this.Location.Y);
                    pnlDetalleContrato.Visible = chkDatosContrato.Checked;
                }
                else
                {
                    MessageBox.Show("Todavia no se encuentra un contrato registrado para este inquilino.", "¡Atención!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    chkDatosContrato.Checked = false;
                }
            }
            else
            {
                this.Size = new Size(500, 530);
                this.Location = new Point(this.Location.X + 245, this.Location.Y);
                pnlDetalleContrato.Visible = chkDatosContrato.Checked;

            }
        }

        private void btnAnterior_Click(object sender, EventArgs e)
        {
            if (ultimaPosicion > 1)
            {
                ultimaPosicion -= 1;
                pbImagen.ImageLocation = _imagenes[ultimaPosicion - 1].urlImagen;
                lbContador.Text = $"{ultimaPosicion}/{_imagenes.Count()}";
            }
        }

        private void btnSiguiente_Click(object sender, EventArgs e)
        {
            if (_imagenes.Count() > ultimaPosicion)
            {
                ultimaPosicion += 1;
                pbImagen.ImageLocation = _imagenes[ultimaPosicion - 1].urlImagen;
                lbContador.Text = $"{ultimaPosicion}/{_imagenes.Count()}";
            }
        }
    }
}

