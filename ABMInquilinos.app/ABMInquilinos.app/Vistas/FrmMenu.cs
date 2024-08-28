using ABMInquilinos.app.AccesoADatos.DAO;
using ABMInquilinos.app.Dominio;
using ABMInquilinos.app.Servicios;
using Microsoft.SqlServer.Server;
using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ABMInquilinos.app.Vistas
{
    public partial class FrmMenu : Form
    {
        private InquilinoDAO inquilinoDAO = new InquilinoDAO();
        private List<Inquilino> _inquilinoList;
        private List<Inquilino> _listaFiltrada;
        private List<Barrio> _barrios;
        private List<Ciudad> _ciudades;
        private List<Provincia> _provincias;
        public FrmMenu()
        {
            InitializeComponent();
        }
        public void RecorrerDgv(List<Inquilino> lst)
        {
            foreach (Inquilino item in lst)
            {
                dgvInquilinos.Rows.Add(new object[] {
                        item.IdInquilino,
                        item.Apellido+ ", "  + item.Nombre,
                        item.NroDoc,
                        item.FechaNacimiento.ToShortDateString(),
                        item.Barrio.Descripcion,
                        item.Barrio.Ciudad.Descripcion,
                        item.Barrio.Ciudad.Provincia.Descripcion,
                        item.Alquilando
                    });
            }
        }
        private void setearLbResultado(List<Inquilino> lst)
        {
            if (lst.Count == 1)
                lbResultados.Text = $"{lst.Count} inqulino encontrado";

            else
                lbResultados.Text = $"{lst.Count} inqulinos encontrados";
        }

        private void CargarDgv(List<Inquilino> inquilinosFiltrados = null)
        {
            dgvInquilinos.Rows.Clear();
            if (inquilinosFiltrados != null)
            {
                //FILTRA CON LA LISTA SIN IR A LA DB CON LINQ
                // PARA FILTROS FACILES
                _listaFiltrada = inquilinosFiltrados;
                RecorrerDgv(inquilinosFiltrados);
                setearLbResultado(inquilinosFiltrados);
            }
            else
            {
                // FILTRO
                _inquilinoList = inquilinoDAO.ListarInquilinos();
                RecorrerDgv(_inquilinoList);
                setearLbResultado(_inquilinoList);
            }
        }
        private void SetearCbo(ComboBox cbo, string value, string display)
        {
            cbo.ValueMember = value;
            cbo.DisplayMember = display;
            cbo.SelectedIndex = -1;
        }
        private void FrmMenu_Load(object sender, EventArgs e)
        {
            CargarDgv();

            ProvinciaDAO provinciaDAO = new ProvinciaDAO();
            _provincias = provinciaDAO.ListarProvincias();
            cboProvincia.DataSource = _provincias;
            SetearCbo(cboProvincia, "IdProvincia", "Descripcion");

            pnlBusqueda.Visible = false;
            cboFiltro.Items.Add("Nombre");
            cboFiltro.Items.Add("Apellido");
            cboFiltro.Items.Add("Documento");

            cboCriterio.Items.Add("Comienza con");
            cboCriterio.Items.Add("Termina con");
            cboCriterio.Items.Add("Contiene");
            cboCriterio.Enabled = false;
            txtValor.Enabled = false;


        }

        private void chkBusqueda_CheckedChanged(object sender, EventArgs e)
        {
            pnlBusqueda.Visible = chkBusqueda.Checked;
        }

        private void dgvInquilinos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int celdaClikeada = dgvInquilinos.CurrentCell.ColumnIndex;
            if (celdaClikeada < 8)
            {
                return;
            }
            int IdInquilino = Convert.ToInt32(dgvInquilinos.CurrentRow.Cells[0].Value.ToString());
            Inquilino inquilino = _inquilinoList.Find(x => x.IdInquilino == IdInquilino);
            switch (celdaClikeada)
            {
                case 8:
                    FrmDetalleInquilino frmDetalle = new(inquilino);
                    frmDetalle.ShowDialog();
                    break;
                case 9:
                    FrmUpsertInquilino frmUpsertInquilino = new(inquilino);
                    frmUpsertInquilino.ShowDialog();
                    CargarDgv();
                    break;
                default:
                    DialogResult dialogResult = MessageBox.Show("¿Desea eliminar a " + inquilino.Apellido + " " + inquilino.Nombre + " ?", "¿Esta Seguro?", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                    if (dialogResult == DialogResult.OK)
                    {
                        if (inquilinoDAO.BajaLogicaInquilino(inquilino.IdInquilino))
                            MessageBox.Show("Eliminado con exito", "Exito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        CargarDgv();
                    }
                    break;
            }
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            FrmUpsertInquilino frmUpsertInquilino = new();
            frmUpsertInquilino.ShowDialog();
            CargarDgv();
        }

        private void btnRefrescar_Click(object sender, EventArgs e)
        {
            cboFiltro.SelectedIndex = -1;
            cboCriterio.SelectedIndex = -1;
            txtValor.Text = string.Empty;
            chkAlquilando.Checked = false;
            cboProvincia.SelectedIndex = -1;
            cboCriterio.Enabled = false;
            txtValor.Enabled = false;
            _listaFiltrada = null;
            CargarDgv();
        }

        private void cboProvincia_SelectionChangeCommitted(object sender, EventArgs e)
        {
            int id_provincia = Convert.ToInt32(cboProvincia.SelectedValue);

            List<Inquilino> listaFiltrada = _inquilinoList.FindAll(x => x.Barrio.Ciudad.Provincia.IdProvincia == id_provincia);
            CargarDgv(listaFiltrada);
        }

        private void txtValor_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cboFiltro.SelectedItem.ToString() == "Documento")
            {
                if (!char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar))
                    e.Handled = true;
            }
        }

        private void txtValor_TextChanged(object sender, EventArgs e)
        {
            if (txtValor.Text.Length >= 3)
            {
                string campo = cboFiltro.SelectedItem.ToString();
                string criterio = cboCriterio.SelectedItem.ToString();
                string valor = txtValor.Text;
                Filtro filtro = new Filtro(campo, criterio, valor);
                CargarDgv(inquilinoDAO.ListarInquilinos(filtro));
            }
        }

        private void cboFiltro_SelectionChangeCommitted(object sender, EventArgs e)
        {
            cboCriterio.Enabled = true;
        }

        private void cboCriterio_SelectionChangeCommitted(object sender, EventArgs e)
        {
            txtValor.Enabled = true;
        }

        private void chkAlquilando_Click(object sender, EventArgs e)
        {
            List<Inquilino> listaFiltrada = _inquilinoList.FindAll(x => x.Alquilando == chkAlquilando.Checked);
            CargarDgv(listaFiltrada);
        }
    }
}
