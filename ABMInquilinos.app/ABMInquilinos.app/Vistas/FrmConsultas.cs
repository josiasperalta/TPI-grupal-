using ABMInquilinos.app.AccesoADatos.DAO;
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
    public partial class FrmConsultas : Form
    {
        public FrmConsultas()
        {
            InitializeComponent();
        }

        private void btnConsultar_Click(object sender, EventArgs e)
        {
            if (rbContratos.Checked)
            {
                ContratoDAO contratoDAO = new ContratoDAO();
                dgvConsultar.DataSource = contratoDAO.ListarContratos();
                dgvConsultar.Columns[0].Visible = false;
                dgvConsultar.Columns[1].HeaderText = "Fecha Inicio";
                dgvConsultar.Columns[2].HeaderText = "Fecha Fin";
                dgvConsultar.Columns[3].HeaderText = "Duracion Años";
                dgvConsultar.Columns[4].HeaderText = "Monto Alquiler";
            }
            else if (rbPropiedades.Checked)
            {
                PropiedadDAO propiedadDAO = new PropiedadDAO();
                dgvConsultar.DataSource = propiedadDAO.ListarPropiedades();
                dgvConsultar.Columns[0].Visible = false;
                dgvConsultar.Columns[2].HeaderText = "Nro Calle";
                dgvConsultar.Columns[3].HeaderText = "Mts 2";
            }
            else
            {
                SedeDAO sedeDAO = new SedeDAO();
                dgvConsultar.DataSource = sedeDAO.ListarSedes();
            }
        }

        private void rbContratos_CheckedChanged(object sender, EventArgs e)
        {
            btnConsultar.Enabled = rbContratos.Checked;
        }

        private void rbPropiedades_CheckedChanged(object sender, EventArgs e)
        {
            btnConsultar.Enabled = rbPropiedades.Checked;
        }

        private void rbSedes_CheckedChanged(object sender, EventArgs e)
        {
            btnConsultar.Enabled = rbSedes.Checked;
        }

        private void FrmConsultas_Load(object sender, EventArgs e)
        {
            btnConsultar.Enabled = false;
        }
    }
}
