using ABMInquilinos.app.AccesoADatos.DAO;
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
    public partial class FrmUpsertInquilino : Form
    {
        private Inquilino _inquilino;
        private List<Barrio> _barrios;
        private List<Ciudad> _ciudades;
        private List<Provincia> _provincias;
        private List<TipoDocumento> _tipoDocumentos;



        public FrmUpsertInquilino()
        {
            InitializeComponent();
            CargarListas();
            this.Text = "Nuevo Inquilino";
            lbTitulo.Text = "Nuevo Inquilino";
            chkAlquilando.Visible = false;
        }
        public FrmUpsertInquilino(Inquilino inquilino)
        {
            InitializeComponent();
            CargarListas();
            this.Text = "Modificar Inquilino";
            lbTitulo.Text = "Modificar Inquilino";
            _inquilino = inquilino;

        }

        public void ConfigurarDtp()
        {
            //todos nuestros inquilinos sean may 18 años
            string fechaMax;
            fechaMax = "" + DateTime.Today.Day;
            fechaMax += "/" + DateTime.Today.Month;
            fechaMax += "/" + (DateTime.Today.Year - 18);
            dtpFechaNacimiento.MaxDate = Convert.ToDateTime(fechaMax);
        }
        private void CargarListas()
        {
            BarrioDAO barrioDAO = new BarrioDAO();
            _barrios = barrioDAO.ListarBarrios();
            CiudadDAO ciudadDAO = new CiudadDAO();
            _ciudades = ciudadDAO.ListarCiudades();
            ProvinciaDAO provinciaDAO = new ProvinciaDAO();
            _provincias = provinciaDAO.ListarProvincias();
            TipoDocumentoDAO tipoDocumentoDAO = new TipoDocumentoDAO();
            _tipoDocumentos = tipoDocumentoDAO.ListarTiposDoc();

        }
        private void SetearCbo(ComboBox cbo, string value, string display)
        {
            cbo.ValueMember = value;
            cbo.DisplayMember = display;
            cbo.SelectedIndex = -1;
        }
        private void FrmUpsertInquilino_Load(object sender, EventArgs e)
        {
            // cargar cbos (tipodoc) y los demas
            cboBarrio.DataSource = _barrios;
            SetearCbo(cboBarrio, "IdBarrio", "Descripcion");

            cboCiudad.DataSource = _ciudades;
            SetearCbo(cboCiudad, "IdCiudad", "Descripcion");

            cboProvincia.DataSource = _provincias;
            SetearCbo(cboProvincia, "IdProvincia", "Descripcion");

            cboTipoDoc.DataSource = _tipoDocumentos;
            SetearCbo(cboTipoDoc, "IdTipoDoc", "Descripcion");

            ConfigurarDtp();
            if (_inquilino != null)
            {
                txtNombre.Text = _inquilino.Nombre;
                txtApellido.Text = _inquilino.Apellido;
                txtNroDoc.Text = _inquilino.NroDoc.ToString();
                dtpFechaNacimiento.Value = _inquilino.FechaNacimiento;
                txtDireccion.Text = _inquilino.Direccion;
                txtNroCalle.Text = _inquilino.NroCalle.ToString();
                chkAlquilando.Checked = _inquilino.Alquilando;
                cboBarrio.SelectedValue = _inquilino.Barrio.IdBarrio;
                cboCiudad.SelectedValue = _inquilino.Barrio.Ciudad.IdCiudad;
                cboTipoDoc.SelectedValue = _inquilino.TipoDocumento.IdTipoDoc;
                cboProvincia.SelectedValue = _inquilino.Barrio.Ciudad.Provincia.IdProvincia;
            }
            else
            {
                cboCiudad.Enabled = false;
                cboBarrio.Enabled = false;
            }
        }

        private void btnAcpetar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(txtNombre.Text) && !string.IsNullOrWhiteSpace(txtApellido.Text)
                    && !string.IsNullOrWhiteSpace(txtDireccion.Text) && !string.IsNullOrWhiteSpace(txtNroCalle.Text)
                    && !string.IsNullOrWhiteSpace(txtNroDoc.Text) && cboBarrio.SelectedIndex != -1)

                {
                    InquilinoDAO inquilinoDAO = new InquilinoDAO();
                    if (_inquilino == null)
                    {
                        _inquilino = new Inquilino();
                        AsignarValores();
                        _inquilino.Alquilando = true;
                        if (inquilinoDAO.NuevoInquilino(_inquilino))
                            MessageBox.Show("Creado correctamente", "Operación exitosa", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        else
                            MessageBox.Show("No se pudo cargar el inqulino", "Operación con errrores", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                    else
                    {
                        AsignarValores();
                        _inquilino.Alquilando = chkAlquilando.Checked;
                        if (inquilinoDAO.ModificarInquilino(_inquilino))
                            MessageBox.Show("Modificado correctamente", "Operación exitosa", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        else
                            MessageBox.Show("No se pudo modificar el inqulino", "Operación con errrores", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Porfavor completar todos los campos", "¡Atención!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error");
            }
        }
        public void AsignarValores()
        {
            _inquilino.Nombre = txtNombre.Text;
            _inquilino.Apellido = txtApellido.Text;
            _inquilino.Direccion = txtDireccion.Text;
            _inquilino.NroDoc = int.Parse(txtNroDoc.Text);
            _inquilino.NroCalle = int.Parse(txtNroCalle.Text);
            _inquilino.FechaNacimiento = dtpFechaNacimiento.Value;
            _inquilino.TipoDocumento = (TipoDocumento)cboTipoDoc.SelectedItem;
            _inquilino.Barrio = (Barrio)cboBarrio.SelectedItem;
            _inquilino.Barrio.Ciudad = (Ciudad)cboCiudad.SelectedItem;
            _inquilino.Barrio.Ciudad.Provincia = (Provincia)cboProvincia.SelectedItem;
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("¿Esta seguro que desea salir?", "!Atención¡", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
                this.Close();
        }
        private void cboProvincia_SelectionChangeCommitted(object sender, EventArgs e)
        {
            cboCiudad.SelectedIndex = -1;
            cboBarrio.SelectedIndex = -1;

            int id_provincia = Convert.ToInt32(cboProvincia.SelectedValue);

            cboCiudad.DataSource = _ciudades.FindAll(x => x.Provincia.IdProvincia == id_provincia);
            SetearCbo(cboCiudad, "IdCiudad", "Descripcion");

            cboCiudad.Enabled = true;
            cboBarrio.Enabled = false;
        }

        private void cboCiudad_SelectionChangeCommitted(object sender, EventArgs e)
        {
            int id_ciudad = Convert.ToInt32(cboCiudad.SelectedValue);
            List<Barrio> barriosFiltrados = _barrios.FindAll(x => x.Ciudad.IdCiudad == id_ciudad);
            if (barriosFiltrados.Count() >= 1)
            {
                cboBarrio.DataSource = barriosFiltrados;
                cboBarrio.Enabled = true;
            }
            else
            {
                MessageBox.Show("Todavia no tenemos un barrio registrado para esa ciudad, porfavor selecione otra ciudad!.", "Atención", MessageBoxButtons.OK, MessageBoxIcon.Information);
                cboCiudad.SelectedIndex = -1;
            }
            cboBarrio.SelectedIndex = -1;
        }

        private void txtNroCalle_KeyPress(object sender, KeyPressEventArgs e)
        {

            if (!char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar))
                e.Handled = true;
        }

        private void txtNroDoc_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar))
                e.Handled = true;
        }
    }
}
