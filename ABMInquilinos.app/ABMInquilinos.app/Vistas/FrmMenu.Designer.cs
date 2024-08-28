namespace ABMInquilinos.app.Vistas
{
    partial class FrmMenu
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            DataGridViewCellStyle dataGridViewCellStyle1 = new DataGridViewCellStyle();
            DataGridViewCellStyle dataGridViewCellStyle5 = new DataGridViewCellStyle();
            DataGridViewCellStyle dataGridViewCellStyle6 = new DataGridViewCellStyle();
            DataGridViewCellStyle dataGridViewCellStyle7 = new DataGridViewCellStyle();
            DataGridViewCellStyle dataGridViewCellStyle2 = new DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmMenu));
            DataGridViewCellStyle dataGridViewCellStyle3 = new DataGridViewCellStyle();
            DataGridViewCellStyle dataGridViewCellStyle4 = new DataGridViewCellStyle();
            dgvInquilinos = new DataGridView();
            chkAlquilando = new CheckBox();
            lbFiltro = new Label();
            lbApellido = new Label();
            btnRefrescar = new Button();
            lbTitulo = new Label();
            pnlBusqueda = new Panel();
            cboCriterio = new ComboBox();
            txtValor = new TextBox();
            cboFiltro = new ComboBox();
            label4 = new Label();
            label3 = new Label();
            cboProvincia = new ComboBox();
            chkBusqueda = new CheckBox();
            btnNuevo = new Button();
            lbResultados = new Label();
            IdInquilino = new DataGridViewTextBoxColumn();
            Inquilino = new DataGridViewTextBoxColumn();
            NroDoc = new DataGridViewTextBoxColumn();
            FechaNac = new DataGridViewTextBoxColumn();
            Barrio = new DataGridViewTextBoxColumn();
            Ciudad = new DataGridViewTextBoxColumn();
            Provincia = new DataGridViewTextBoxColumn();
            Alquilando = new DataGridViewCheckBoxColumn();
            Ver = new DataGridViewImageColumn();
            modificar = new DataGridViewImageColumn();
            eliminar = new DataGridViewImageColumn();
            ((System.ComponentModel.ISupportInitialize)dgvInquilinos).BeginInit();
            pnlBusqueda.SuspendLayout();
            SuspendLayout();
            // 
            // dgvInquilinos
            // 
            dgvInquilinos.AllowUserToAddRows = false;
            dgvInquilinos.AllowUserToDeleteRows = false;
            dgvInquilinos.AllowUserToResizeColumns = false;
            dgvInquilinos.AllowUserToResizeRows = false;
            dgvInquilinos.BackgroundColor = Color.FromArgb(0, 48, 73);
            dgvInquilinos.BorderStyle = BorderStyle.None;
            dataGridViewCellStyle1.Alignment = DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = Color.FromArgb(0, 48, 73);
            dataGridViewCellStyle1.Font = new Font("Segoe UI", 14.25F, FontStyle.Bold, GraphicsUnit.Point);
            dataGridViewCellStyle1.ForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle1.SelectionBackColor = Color.FromArgb(0, 48, 73);
            dataGridViewCellStyle1.SelectionForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = DataGridViewTriState.True;
            dgvInquilinos.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            dgvInquilinos.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvInquilinos.Columns.AddRange(new DataGridViewColumn[] { IdInquilino, Inquilino, NroDoc, FechaNac, Barrio, Ciudad, Provincia, Alquilando, Ver, modificar, eliminar });
            dataGridViewCellStyle5.Alignment = DataGridViewContentAlignment.BottomLeft;
            dataGridViewCellStyle5.BackColor = Color.FromArgb(51, 92, 103);
            dataGridViewCellStyle5.Font = new Font("Segoe UI", 11.25F, FontStyle.Regular, GraphicsUnit.Point);
            dataGridViewCellStyle5.ForeColor = Color.White;
            dataGridViewCellStyle5.SelectionBackColor = Color.FromArgb(7, 153, 182);
            dataGridViewCellStyle5.SelectionForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle5.WrapMode = DataGridViewTriState.False;
            dgvInquilinos.DefaultCellStyle = dataGridViewCellStyle5;
            dgvInquilinos.EnableHeadersVisualStyles = false;
            dgvInquilinos.Location = new Point(14, 53);
            dgvInquilinos.MultiSelect = false;
            dgvInquilinos.Name = "dgvInquilinos";
            dgvInquilinos.ReadOnly = true;
            dataGridViewCellStyle6.Alignment = DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle6.BackColor = Color.FromArgb(102, 155, 188);
            dataGridViewCellStyle6.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            dataGridViewCellStyle6.ForeColor = Color.White;
            dataGridViewCellStyle6.SelectionBackColor = Color.FromArgb(156, 210, 250);
            dataGridViewCellStyle6.SelectionForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle6.WrapMode = DataGridViewTriState.True;
            dgvInquilinos.RowHeadersDefaultCellStyle = dataGridViewCellStyle6;
            dataGridViewCellStyle7.BackColor = Color.FromArgb(102, 155, 188);
            dataGridViewCellStyle7.ForeColor = Color.White;
            dataGridViewCellStyle7.SelectionBackColor = Color.FromArgb(0, 192, 192);
            dataGridViewCellStyle7.SelectionForeColor = Color.White;
            dgvInquilinos.RowsDefaultCellStyle = dataGridViewCellStyle7;
            dgvInquilinos.RowTemplate.Height = 25;
            dgvInquilinos.ScrollBars = ScrollBars.Vertical;
            dgvInquilinos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvInquilinos.ShowCellToolTips = false;
            dgvInquilinos.Size = new Size(1451, 531);
            dgvInquilinos.TabIndex = 0;
            dgvInquilinos.CellClick += dgvInquilinos_CellClick;
            // 
            // chkAlquilando
            // 
            chkAlquilando.AutoSize = true;
            chkAlquilando.Font = new Font("Century Gothic", 14.25F, FontStyle.Regular, GraphicsUnit.Point);
            chkAlquilando.ForeColor = Color.White;
            chkAlquilando.Location = new Point(265, 596);
            chkAlquilando.Name = "chkAlquilando";
            chkAlquilando.Size = new Size(128, 26);
            chkAlquilando.TabIndex = 2;
            chkAlquilando.Text = "Alquilando";
            chkAlquilando.UseVisualStyleBackColor = true;
            chkAlquilando.Click += chkAlquilando_Click;
            // 
            // lbFiltro
            // 
            lbFiltro.AutoSize = true;
            lbFiltro.Font = new Font("Century Gothic", 14.25F, FontStyle.Regular, GraphicsUnit.Point);
            lbFiltro.ForeColor = Color.White;
            lbFiltro.Location = new Point(13, 13);
            lbFiltro.Name = "lbFiltro";
            lbFiltro.Size = new Size(55, 22);
            lbFiltro.TabIndex = 3;
            lbFiltro.Text = "Filtro:";
            // 
            // lbApellido
            // 
            lbApellido.AutoSize = true;
            lbApellido.Font = new Font("Century Gothic", 14.25F, FontStyle.Regular, GraphicsUnit.Point);
            lbApellido.ForeColor = Color.White;
            lbApellido.Location = new Point(454, 13);
            lbApellido.Name = "lbApellido";
            lbApellido.Size = new Size(64, 22);
            lbApellido.TabIndex = 5;
            lbApellido.Text = "Valor:";
            // 
            // btnRefrescar
            // 
            btnRefrescar.FlatStyle = FlatStyle.Flat;
            btnRefrescar.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            btnRefrescar.ForeColor = SystemColors.HighlightText;
            btnRefrescar.Image = Properties.Resources.restart_24px;
            btnRefrescar.ImageAlign = ContentAlignment.MiddleRight;
            btnRefrescar.Location = new Point(688, 679);
            btnRefrescar.Name = "btnRefrescar";
            btnRefrescar.Size = new Size(134, 41);
            btnRefrescar.TabIndex = 9;
            btnRefrescar.Text = "Reiniciar";
            btnRefrescar.TextAlign = ContentAlignment.MiddleLeft;
            btnRefrescar.UseVisualStyleBackColor = true;
            btnRefrescar.Click += btnRefrescar_Click;
            // 
            // lbTitulo
            // 
            lbTitulo.AutoSize = true;
            lbTitulo.Font = new Font("Segoe UI", 21.75F, FontStyle.Regular, GraphicsUnit.Point);
            lbTitulo.ForeColor = Color.White;
            lbTitulo.Location = new Point(409, 9);
            lbTitulo.Name = "lbTitulo";
            lbTitulo.Size = new Size(610, 40);
            lbTitulo.TabIndex = 11;
            lbTitulo.Text = "Listado de inquilinos - Inmobiliaria Las Toninas";
            // 
            // pnlBusqueda
            // 
            pnlBusqueda.Controls.Add(cboCriterio);
            pnlBusqueda.Controls.Add(txtValor);
            pnlBusqueda.Controls.Add(cboFiltro);
            pnlBusqueda.Controls.Add(label4);
            pnlBusqueda.Controls.Add(lbFiltro);
            pnlBusqueda.Controls.Add(lbApellido);
            pnlBusqueda.ForeColor = Color.White;
            pnlBusqueda.Location = new Point(14, 673);
            pnlBusqueda.Name = "pnlBusqueda";
            pnlBusqueda.Size = new Size(656, 52);
            pnlBusqueda.TabIndex = 12;
            // 
            // cboCriterio
            // 
            cboCriterio.DropDownStyle = ComboBoxStyle.DropDownList;
            cboCriterio.FormattingEnabled = true;
            cboCriterio.Location = new Point(303, 13);
            cboCriterio.Name = "cboCriterio";
            cboCriterio.Size = new Size(121, 23);
            cboCriterio.TabIndex = 22;
            cboCriterio.SelectionChangeCommitted += cboCriterio_SelectionChangeCommitted;
            // 
            // txtValor
            // 
            txtValor.Location = new Point(526, 12);
            txtValor.Name = "txtValor";
            txtValor.Size = new Size(121, 23);
            txtValor.TabIndex = 21;
            txtValor.TextChanged += txtValor_TextChanged;
            txtValor.KeyPress += txtValor_KeyPress;
            // 
            // cboFiltro
            // 
            cboFiltro.DropDownStyle = ComboBoxStyle.DropDownList;
            cboFiltro.FormattingEnabled = true;
            cboFiltro.Location = new Point(74, 12);
            cboFiltro.Name = "cboFiltro";
            cboFiltro.Size = new Size(121, 23);
            cboFiltro.TabIndex = 20;
            cboFiltro.SelectionChangeCommitted += cboFiltro_SelectionChangeCommitted;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Font = new Font("Century Gothic", 14.25F, FontStyle.Regular, GraphicsUnit.Point);
            label4.ForeColor = Color.White;
            label4.Location = new Point(208, 17);
            label4.Name = "label4";
            label4.Size = new Size(79, 22);
            label4.TabIndex = 19;
            label4.Text = "Criterio:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Font = new Font("Century Gothic", 14.25F, FontStyle.Regular, GraphicsUnit.Point);
            label3.ForeColor = Color.White;
            label3.Location = new Point(16, 597);
            label3.Name = "label3";
            label3.Size = new Size(100, 22);
            label3.TabIndex = 14;
            label3.Text = "Provincia:";
            // 
            // cboProvincia
            // 
            cboProvincia.DropDownStyle = ComboBoxStyle.DropDownList;
            cboProvincia.FormattingEnabled = true;
            cboProvincia.Location = new Point(122, 598);
            cboProvincia.Name = "cboProvincia";
            cboProvincia.Size = new Size(121, 23);
            cboProvincia.TabIndex = 11;
            cboProvincia.SelectionChangeCommitted += cboProvincia_SelectionChangeCommitted;
            // 
            // chkBusqueda
            // 
            chkBusqueda.AutoSize = true;
            chkBusqueda.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            chkBusqueda.ForeColor = Color.White;
            chkBusqueda.Location = new Point(14, 636);
            chkBusqueda.Name = "chkBusqueda";
            chkBusqueda.Size = new Size(176, 34);
            chkBusqueda.TabIndex = 13;
            chkBusqueda.Text = "Filtro Avanzado";
            chkBusqueda.UseVisualStyleBackColor = true;
            chkBusqueda.CheckedChanged += chkBusqueda_CheckedChanged;
            // 
            // btnNuevo
            // 
            btnNuevo.FlatStyle = FlatStyle.Flat;
            btnNuevo.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            btnNuevo.ForeColor = Color.White;
            btnNuevo.Image = Properties.Resources.add_32;
            btnNuevo.ImageAlign = ContentAlignment.MiddleRight;
            btnNuevo.Location = new Point(1195, 596);
            btnNuevo.Name = "btnNuevo";
            btnNuevo.Size = new Size(270, 53);
            btnNuevo.TabIndex = 14;
            btnNuevo.Text = "Cargar nuevo inquilino";
            btnNuevo.TextAlign = ContentAlignment.MiddleLeft;
            btnNuevo.UseVisualStyleBackColor = true;
            btnNuevo.Click += btnNuevo_Click;
            // 
            // lbResultados
            // 
            lbResultados.AutoSize = true;
            lbResultados.Font = new Font("Segoe UI", 18F, FontStyle.Underline, GraphicsUnit.Point);
            lbResultados.ForeColor = SystemColors.HighlightText;
            lbResultados.Location = new Point(604, 590);
            lbResultados.Name = "lbResultados";
            lbResultados.Size = new Size(277, 32);
            lbResultados.TabIndex = 15;
            lbResultados.Text = "1 inquilinos encontrados";
            // 
            // IdInquilino
            // 
            IdInquilino.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            IdInquilino.HeaderText = "id";
            IdInquilino.Name = "IdInquilino";
            IdInquilino.ReadOnly = true;
            IdInquilino.Visible = false;
            // 
            // Inquilino
            // 
            Inquilino.HeaderText = "Inquilino";
            Inquilino.Name = "Inquilino";
            Inquilino.ReadOnly = true;
            Inquilino.Width = 150;
            // 
            // NroDoc
            // 
            NroDoc.HeaderText = "Documento";
            NroDoc.Name = "NroDoc";
            NroDoc.ReadOnly = true;
            NroDoc.Width = 133;
            // 
            // FechaNac
            // 
            FechaNac.HeaderText = "Fecha Nacimiento";
            FechaNac.Name = "FechaNac";
            FechaNac.ReadOnly = true;
            FechaNac.Width = 195;
            // 
            // Barrio
            // 
            Barrio.HeaderText = "Barrio";
            Barrio.Name = "Barrio";
            Barrio.ReadOnly = true;
            Barrio.Width = 133;
            // 
            // Ciudad
            // 
            Ciudad.HeaderText = "Ciudad";
            Ciudad.Name = "Ciudad";
            Ciudad.ReadOnly = true;
            Ciudad.Width = 134;
            // 
            // Provincia
            // 
            Provincia.HeaderText = "Provincia";
            Provincia.Name = "Provincia";
            Provincia.ReadOnly = true;
            Provincia.Width = 134;
            // 
            // Alquilando
            // 
            Alquilando.HeaderText = "Alquilando";
            Alquilando.Name = "Alquilando";
            Alquilando.ReadOnly = true;
            Alquilando.Width = 133;
            // 
            // Ver
            // 
            Ver.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dataGridViewCellStyle2.Alignment = DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle2.BackColor = Color.FromArgb(156, 210, 211);
            dataGridViewCellStyle2.ForeColor = Color.White;
            dataGridViewCellStyle2.NullValue = resources.GetObject("dataGridViewCellStyle2.NullValue");
            dataGridViewCellStyle2.SelectionBackColor = Color.FromArgb(0, 64, 64);
            dataGridViewCellStyle2.SelectionForeColor = Color.White;
            Ver.DefaultCellStyle = dataGridViewCellStyle2;
            Ver.Description = "Ver detalle";
            Ver.HeaderText = "Detalles";
            Ver.Image = Properties.Resources.view_32px;
            Ver.ImageLayout = DataGridViewImageCellLayout.Zoom;
            Ver.Name = "Ver";
            Ver.ReadOnly = true;
            Ver.Resizable = DataGridViewTriState.False;
            Ver.SortMode = DataGridViewColumnSortMode.Automatic;
            Ver.ToolTipText = "Ver detalle";
            // 
            // modificar
            // 
            modificar.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dataGridViewCellStyle3.Alignment = DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle3.BackColor = Color.FromArgb(156, 210, 211);
            dataGridViewCellStyle3.ForeColor = Color.White;
            dataGridViewCellStyle3.NullValue = resources.GetObject("dataGridViewCellStyle3.NullValue");
            dataGridViewCellStyle3.SelectionBackColor = Color.FromArgb(0, 64, 64);
            dataGridViewCellStyle3.SelectionForeColor = Color.White;
            modificar.DefaultCellStyle = dataGridViewCellStyle3;
            modificar.Description = "Modificar";
            modificar.HeaderText = "Modificar";
            modificar.Image = Properties.Resources.Edit_Property_32px;
            modificar.ImageLayout = DataGridViewImageCellLayout.Zoom;
            modificar.Name = "modificar";
            modificar.ReadOnly = true;
            modificar.Resizable = DataGridViewTriState.False;
            modificar.SortMode = DataGridViewColumnSortMode.Automatic;
            // 
            // eliminar
            // 
            eliminar.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dataGridViewCellStyle4.Alignment = DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle4.BackColor = Color.FromArgb(156, 210, 211);
            dataGridViewCellStyle4.ForeColor = Color.White;
            dataGridViewCellStyle4.NullValue = resources.GetObject("dataGridViewCellStyle4.NullValue");
            dataGridViewCellStyle4.SelectionBackColor = Color.FromArgb(0, 64, 64);
            dataGridViewCellStyle4.SelectionForeColor = Color.White;
            eliminar.DefaultCellStyle = dataGridViewCellStyle4;
            eliminar.Description = "Eliminar";
            eliminar.HeaderText = "Eliminar";
            eliminar.Image = Properties.Resources.delete_32px;
            eliminar.ImageLayout = DataGridViewImageCellLayout.Zoom;
            eliminar.Name = "eliminar";
            eliminar.ReadOnly = true;
            eliminar.Resizable = DataGridViewTriState.False;
            eliminar.SortMode = DataGridViewColumnSortMode.Automatic;
            // 
            // FrmMenu
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(17, 76, 95);
            ClientSize = new Size(1481, 733);
            Controls.Add(lbResultados);
            Controls.Add(btnNuevo);
            Controls.Add(chkBusqueda);
            Controls.Add(pnlBusqueda);
            Controls.Add(lbTitulo);
            Controls.Add(label3);
            Controls.Add(dgvInquilinos);
            Controls.Add(btnRefrescar);
            Controls.Add(cboProvincia);
            Controls.Add(chkAlquilando);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "FrmMenu";
            StartPosition = FormStartPosition.CenterParent;
            Text = "ABMC Inquilinos";
            Load += FrmMenu_Load;
            ((System.ComponentModel.ISupportInitialize)dgvInquilinos).EndInit();
            pnlBusqueda.ResumeLayout(false);
            pnlBusqueda.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private DataGridView dgvInquilinos;
        private CheckBox chkAlquilando;
        private Label lbFiltro;
        private Label lbApellido;
        private Button btnRefrescar;
        private Label lbTitulo;
        private Panel pnlBusqueda;
        private Label label3;
        private ComboBox cboProvincia;
        private CheckBox chkBusqueda;
        private Button btnNuevo;
        private Label label4;
        private ComboBox cboCriterio;
        private TextBox txtValor;
        private ComboBox cboFiltro;
        private Label lbResultados;
        private DataGridViewTextBoxColumn IdInquilino;
        private DataGridViewTextBoxColumn Inquilino;
        private DataGridViewTextBoxColumn NroDoc;
        private DataGridViewTextBoxColumn FechaNac;
        private DataGridViewTextBoxColumn Barrio;
        private DataGridViewTextBoxColumn Ciudad;
        private DataGridViewTextBoxColumn Provincia;
        private DataGridViewCheckBoxColumn Alquilando;
        private DataGridViewImageColumn Ver;
        private DataGridViewImageColumn modificar;
        private DataGridViewImageColumn eliminar;
    }
}