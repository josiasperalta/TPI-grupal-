namespace ABMInquilinos.app.Vistas
{
    partial class FrmUpsertInquilino
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
            txtNombre = new TextBox();
            label1 = new Label();
            label2 = new Label();
            txtApellido = new TextBox();
            label3 = new Label();
            txtNroDoc = new TextBox();
            label4 = new Label();
            label5 = new Label();
            lbdirec = new Label();
            txtDireccion = new TextBox();
            label7 = new Label();
            txtNroCalle = new TextBox();
            label9 = new Label();
            chkAlquilando = new CheckBox();
            cboTipoDoc = new ComboBox();
            cboBarrio = new ComboBox();
            cboCiudad = new ComboBox();
            cboProvincia = new ComboBox();
            label6 = new Label();
            lbTitulo = new Label();
            btnCancelar = new Button();
            btnAcpetar = new Button();
            dtpFechaNacimiento = new DateTimePicker();
            label8 = new Label();
            SuspendLayout();
            // 
            // txtNombre
            // 
            txtNombre.Location = new Point(109, 104);
            txtNombre.MaxLength = 50;
            txtNombre.Name = "txtNombre";
            txtNombre.Size = new Size(100, 23);
            txtNombre.TabIndex = 1;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(49, 104);
            label1.Name = "label1";
            label1.Size = new Size(54, 15);
            label1.TabIndex = 2;
            label1.Text = "Nombre:";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(233, 107);
            label2.Name = "label2";
            label2.Size = new Size(54, 15);
            label2.TabIndex = 4;
            label2.Text = "Apellido:";
            // 
            // txtApellido
            // 
            txtApellido.Location = new Point(293, 104);
            txtApellido.MaxLength = 50;
            txtApellido.Name = "txtApellido";
            txtApellido.Size = new Size(100, 23);
            txtApellido.TabIndex = 3;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(233, 212);
            label3.Name = "label3";
            label3.Size = new Size(51, 15);
            label3.TabIndex = 6;
            label3.Text = "Nro Doc";
            // 
            // txtNroDoc
            // 
            txtNroDoc.Location = new Point(293, 209);
            txtNroDoc.MaxLength = 8;
            txtNroDoc.Name = "txtNroDoc";
            txtNroDoc.Size = new Size(100, 23);
            txtNroDoc.TabIndex = 5;
            txtNroDoc.KeyPress += txtNroDoc_KeyPress;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(62, 319);
            label4.Name = "label4";
            label4.Size = new Size(41, 15);
            label4.TabIndex = 8;
            label4.Text = "Barrio:";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new Point(44, 270);
            label5.Name = "label5";
            label5.Size = new Size(59, 15);
            label5.TabIndex = 10;
            label5.Text = "Provincia:";
            // 
            // lbdirec
            // 
            lbdirec.AutoSize = true;
            lbdirec.Location = new Point(47, 164);
            lbdirec.Name = "lbdirec";
            lbdirec.Size = new Size(56, 15);
            lbdirec.TabIndex = 12;
            lbdirec.Text = "direccion";
            // 
            // txtDireccion
            // 
            txtDireccion.Location = new Point(109, 158);
            txtDireccion.MaxLength = 50;
            txtDireccion.Name = "txtDireccion";
            txtDireccion.Size = new Size(100, 23);
            txtDireccion.TabIndex = 11;
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Location = new Point(235, 164);
            label7.Name = "label7";
            label7.Size = new Size(54, 15);
            label7.TabIndex = 14;
            label7.Text = "Nro calle";
            // 
            // txtNroCalle
            // 
            txtNroCalle.Location = new Point(293, 161);
            txtNroCalle.MaxLength = 6;
            txtNroCalle.Name = "txtNroCalle";
            txtNroCalle.Size = new Size(100, 23);
            txtNroCalle.TabIndex = 13;
            txtNroCalle.KeyPress += txtNroCalle_KeyPress;
            // 
            // label9
            // 
            label9.AutoSize = true;
            label9.Location = new Point(236, 270);
            label9.Name = "label9";
            label9.Size = new Size(48, 15);
            label9.TabIndex = 18;
            label9.Text = "Ciudad:";
            // 
            // chkAlquilando
            // 
            chkAlquilando.AutoSize = true;
            chkAlquilando.ForeColor = Color.Transparent;
            chkAlquilando.Location = new Point(236, 318);
            chkAlquilando.Name = "chkAlquilando";
            chkAlquilando.Size = new Size(82, 19);
            chkAlquilando.TabIndex = 23;
            chkAlquilando.Text = "alquilando";
            chkAlquilando.UseVisualStyleBackColor = true;
            // 
            // cboTipoDoc
            // 
            cboTipoDoc.DropDownStyle = ComboBoxStyle.DropDownList;
            cboTipoDoc.FormattingEnabled = true;
            cboTipoDoc.Location = new Point(109, 209);
            cboTipoDoc.Name = "cboTipoDoc";
            cboTipoDoc.Size = new Size(100, 23);
            cboTipoDoc.TabIndex = 24;
            // 
            // cboBarrio
            // 
            cboBarrio.DropDownStyle = ComboBoxStyle.DropDownList;
            cboBarrio.FormattingEnabled = true;
            cboBarrio.Location = new Point(109, 314);
            cboBarrio.Name = "cboBarrio";
            cboBarrio.Size = new Size(100, 23);
            cboBarrio.TabIndex = 25;
            // 
            // cboCiudad
            // 
            cboCiudad.DropDownStyle = ComboBoxStyle.DropDownList;
            cboCiudad.FormattingEnabled = true;
            cboCiudad.Location = new Point(293, 262);
            cboCiudad.Name = "cboCiudad";
            cboCiudad.Size = new Size(100, 23);
            cboCiudad.TabIndex = 26;
            cboCiudad.SelectionChangeCommitted += cboCiudad_SelectionChangeCommitted;
            // 
            // cboProvincia
            // 
            cboProvincia.DropDownStyle = ComboBoxStyle.DropDownList;
            cboProvincia.FormattingEnabled = true;
            cboProvincia.Location = new Point(109, 262);
            cboProvincia.Name = "cboProvincia";
            cboProvincia.Size = new Size(100, 23);
            cboProvincia.TabIndex = 27;
            cboProvincia.SelectionChangeCommitted += cboProvincia_SelectionChangeCommitted;
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Location = new Point(7, 212);
            label6.Name = "label6";
            label6.Size = new Size(96, 15);
            label6.TabIndex = 28;
            label6.Text = "Tipo Documento";
            // 
            // lbTitulo
            // 
            lbTitulo.AutoSize = true;
            lbTitulo.Font = new Font("Segoe UI", 18F, FontStyle.Regular, GraphicsUnit.Point);
            lbTitulo.Location = new Point(131, 31);
            lbTitulo.Name = "lbTitulo";
            lbTitulo.Size = new Size(195, 32);
            lbTitulo.TabIndex = 29;
            lbTitulo.Text = "Nuevo/Modificar";
            // 
            // btnCancelar
            // 
            btnCancelar.FlatAppearance.BorderSize = 0;
            btnCancelar.FlatStyle = FlatStyle.Flat;
            btnCancelar.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            btnCancelar.ForeColor = Color.White;
            btnCancelar.Image = Properties.Resources.close2_24px;
            btnCancelar.ImageAlign = ContentAlignment.MiddleRight;
            btnCancelar.Location = new Point(77, 415);
            btnCancelar.Name = "btnCancelar";
            btnCancelar.Size = new Size(132, 46);
            btnCancelar.TabIndex = 30;
            btnCancelar.Text = "Cancelar";
            btnCancelar.TextAlign = ContentAlignment.MiddleLeft;
            btnCancelar.UseVisualStyleBackColor = true;
            btnCancelar.Click += btnCancelar_Click;
            // 
            // btnAcpetar
            // 
            btnAcpetar.FlatAppearance.BorderSize = 0;
            btnAcpetar.FlatStyle = FlatStyle.Flat;
            btnAcpetar.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            btnAcpetar.ForeColor = Color.White;
            btnAcpetar.Image = Properties.Resources.done_24px;
            btnAcpetar.ImageAlign = ContentAlignment.MiddleRight;
            btnAcpetar.Location = new Point(261, 415);
            btnAcpetar.Name = "btnAcpetar";
            btnAcpetar.Size = new Size(132, 46);
            btnAcpetar.TabIndex = 31;
            btnAcpetar.Text = "Aceptar";
            btnAcpetar.TextAlign = ContentAlignment.MiddleLeft;
            btnAcpetar.UseVisualStyleBackColor = true;
            btnAcpetar.Click += btnAcpetar_Click;
            // 
            // dtpFechaNacimiento
            // 
            dtpFechaNacimiento.CustomFormat = "dd/MM/yyyy";
            dtpFechaNacimiento.Format = DateTimePickerFormat.Custom;
            dtpFechaNacimiento.Location = new Point(161, 368);
            dtpFechaNacimiento.MaxDate = new DateTime(2024, 6, 10, 0, 0, 0, 0);
            dtpFechaNacimiento.MinDate = new DateTime(1900, 1, 1, 0, 0, 0, 0);
            dtpFechaNacimiento.Name = "dtpFechaNacimiento";
            dtpFechaNacimiento.Size = new Size(96, 23);
            dtpFechaNacimiento.TabIndex = 32;
            dtpFechaNacimiento.Value = new DateTime(2024, 6, 10, 0, 0, 0, 0);
            // 
            // label8
            // 
            label8.AutoSize = true;
            label8.Location = new Point(49, 374);
            label8.Name = "label8";
            label8.Size = new Size(106, 15);
            label8.TabIndex = 33;
            label8.Text = "Fecha Nacimiento:";
            // 
            // FrmUpsertInquilino
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(17, 76, 95);
            ClientSize = new Size(439, 491);
            Controls.Add(label8);
            Controls.Add(dtpFechaNacimiento);
            Controls.Add(btnAcpetar);
            Controls.Add(btnCancelar);
            Controls.Add(lbTitulo);
            Controls.Add(label6);
            Controls.Add(cboProvincia);
            Controls.Add(cboCiudad);
            Controls.Add(cboBarrio);
            Controls.Add(cboTipoDoc);
            Controls.Add(chkAlquilando);
            Controls.Add(label9);
            Controls.Add(label7);
            Controls.Add(txtNroCalle);
            Controls.Add(lbdirec);
            Controls.Add(txtDireccion);
            Controls.Add(label5);
            Controls.Add(label4);
            Controls.Add(label3);
            Controls.Add(txtNroDoc);
            Controls.Add(label2);
            Controls.Add(txtApellido);
            Controls.Add(label1);
            Controls.Add(txtNombre);
            ForeColor = Color.White;
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "FrmUpsertInquilino";
            StartPosition = FormStartPosition.CenterParent;
            Text = "FrmUpsertInquilino";
            Load += FrmUpsertInquilino_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button btnAceptar;
        private TextBox txtNombre;
        private Label label1;
        private Label label2;
        private TextBox txtApellido;
        private Label label3;
        private TextBox txtNroDoc;
        private Label label4;
        private TextBox textBox4;
        private Label label5;
        private TextBox textBox5;
        private Label lbdirec;
        private TextBox txtDireccion;
        private Label label7;
        private TextBox txtNroCalle;
        private Label label9;
        private TextBox textBox9;
        private Label label10;
        private TextBox textBox10;
        private Label label11;
        private TextBox textBox11;
        private CheckBox chkAlquilando;
        private ComboBox cboTipoDoc;
        private ComboBox cboBarrio;
        private ComboBox cboCiudad;
        private ComboBox cboProvincia;
        private Label label6;
        private Label lbTitulo;
        private Button btnCancelar;
        private Button btnAcpetar;
        private DateTimePicker dtpFechaNacimiento;
        private Label label8;
    }
}