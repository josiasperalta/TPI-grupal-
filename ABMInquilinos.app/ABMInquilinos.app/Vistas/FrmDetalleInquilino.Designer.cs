namespace ABMInquilinos.app.Vistas
{
    partial class FrmDetalleInquilino
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
            pbImagen = new PictureBox();
            btnSiguiente = new Button();
            btnAnterior = new Button();
            lbContador = new Label();
            txtNombre = new TextBox();
            txtTipoDoc = new TextBox();
            chkDatosContrato = new CheckBox();
            label2 = new Label();
            txtApellido = new TextBox();
            txtDoc = new TextBox();
            txtDireccion = new TextBox();
            txtBarrio = new TextBox();
            txtCiudad = new TextBox();
            label3 = new Label();
            label4 = new Label();
            label5 = new Label();
            label6 = new Label();
            label7 = new Label();
            label8 = new Label();
            label10 = new Label();
            chkAlquilando = new CheckBox();
            label9 = new Label();
            label12 = new Label();
            label13 = new Label();
            label14 = new Label();
            lbMts2 = new Label();
            txtDuracion = new TextBox();
            txtFin = new TextBox();
            txtDireccionPropiedad = new TextBox();
            label16 = new Label();
            txtInicio = new TextBox();
            txtNroContrato = new TextBox();
            label11 = new Label();
            txtMonto = new TextBox();
            label18 = new Label();
            txtProvincia = new TextBox();
            pnlDetalleContrato = new Panel();
            label1 = new Label();
            ((System.ComponentModel.ISupportInitialize)pbImagen).BeginInit();
            pnlDetalleContrato.SuspendLayout();
            SuspendLayout();
            // 
            // pbImagen
            // 
            pbImagen.Location = new Point(231, 87);
            pbImagen.Name = "pbImagen";
            pbImagen.Size = new Size(259, 288);
            pbImagen.SizeMode = PictureBoxSizeMode.StretchImage;
            pbImagen.TabIndex = 0;
            pbImagen.TabStop = false;
            // 
            // btnSiguiente
            // 
            btnSiguiente.FlatAppearance.BorderSize = 0;
            btnSiguiente.FlatStyle = FlatStyle.Flat;
            btnSiguiente.Font = new Font("Arial", 20.25F, FontStyle.Bold, GraphicsUnit.Point);
            btnSiguiente.Location = new Point(450, 381);
            btnSiguiente.Name = "btnSiguiente";
            btnSiguiente.Size = new Size(45, 39);
            btnSiguiente.TabIndex = 1;
            btnSiguiente.Text = ">";
            btnSiguiente.UseVisualStyleBackColor = true;
            btnSiguiente.Click += btnSiguiente_Click;
            // 
            // btnAnterior
            // 
            btnAnterior.FlatAppearance.BorderSize = 0;
            btnAnterior.FlatStyle = FlatStyle.Flat;
            btnAnterior.Font = new Font("Arial", 20.25F, FontStyle.Bold, GraphicsUnit.Point);
            btnAnterior.Location = new Point(231, 381);
            btnAnterior.Name = "btnAnterior";
            btnAnterior.Size = new Size(45, 39);
            btnAnterior.TabIndex = 2;
            btnAnterior.Text = "<";
            btnAnterior.UseVisualStyleBackColor = true;
            btnAnterior.Click += btnAnterior_Click;
            // 
            // lbContador
            // 
            lbContador.AutoSize = true;
            lbContador.Font = new Font("Segoe UI", 11.25F, FontStyle.Regular, GraphicsUnit.Point);
            lbContador.Location = new Point(350, 393);
            lbContador.Name = "lbContador";
            lbContador.Size = new Size(31, 20);
            lbContador.TabIndex = 3;
            lbContador.Text = "0/0";
            // 
            // txtNombre
            // 
            txtNombre.Location = new Point(114, 128);
            txtNombre.Name = "txtNombre";
            txtNombre.ReadOnly = true;
            txtNombre.Size = new Size(100, 23);
            txtNombre.TabIndex = 4;
            // 
            // txtTipoDoc
            // 
            txtTipoDoc.Location = new Point(114, 191);
            txtTipoDoc.Name = "txtTipoDoc";
            txtTipoDoc.ReadOnly = true;
            txtTipoDoc.Size = new Size(100, 23);
            txtTipoDoc.TabIndex = 5;
            // 
            // chkDatosContrato
            // 
            chkDatosContrato.AutoSize = true;
            chkDatosContrato.Location = new Point(152, 440);
            chkDatosContrato.Name = "chkDatosContrato";
            chkDatosContrato.Size = new Size(147, 19);
            chkDatosContrato.TabIndex = 6;
            chkDatosContrato.Text = "Mostrar datos contrato";
            chkDatosContrato.UseVisualStyleBackColor = true;
            chkDatosContrato.Click += chkDatosContrato_Click;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(24, 131);
            label2.Name = "label2";
            label2.Size = new Size(51, 15);
            label2.TabIndex = 8;
            label2.Text = "Nombre";
            // 
            // txtApellido
            // 
            txtApellido.Location = new Point(316, 128);
            txtApellido.Name = "txtApellido";
            txtApellido.ReadOnly = true;
            txtApellido.Size = new Size(100, 23);
            txtApellido.TabIndex = 9;
            // 
            // txtDoc
            // 
            txtDoc.Location = new Point(316, 191);
            txtDoc.Name = "txtDoc";
            txtDoc.ReadOnly = true;
            txtDoc.Size = new Size(100, 23);
            txtDoc.TabIndex = 10;
            // 
            // txtDireccion
            // 
            txtDireccion.Location = new Point(114, 261);
            txtDireccion.Name = "txtDireccion";
            txtDireccion.ReadOnly = true;
            txtDireccion.Size = new Size(100, 23);
            txtDireccion.TabIndex = 11;
            // 
            // txtBarrio
            // 
            txtBarrio.Location = new Point(316, 259);
            txtBarrio.Name = "txtBarrio";
            txtBarrio.ReadOnly = true;
            txtBarrio.Size = new Size(100, 23);
            txtBarrio.TabIndex = 12;
            // 
            // txtCiudad
            // 
            txtCiudad.Location = new Point(114, 321);
            txtCiudad.Name = "txtCiudad";
            txtCiudad.ReadOnly = true;
            txtCiudad.Size = new Size(100, 23);
            txtCiudad.TabIndex = 13;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(237, 131);
            label3.Name = "label3";
            label3.Size = new Size(51, 15);
            label3.TabIndex = 15;
            label3.Text = "Apellido";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(18, 194);
            label4.Name = "label4";
            label4.Size = new Size(96, 15);
            label4.TabIndex = 16;
            label4.Text = "Tipo Documento";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new Point(237, 196);
            label5.Name = "label5";
            label5.Size = new Size(70, 15);
            label5.TabIndex = 17;
            label5.Text = "Documento";
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Location = new Point(18, 259);
            label6.Name = "label6";
            label6.Size = new Size(57, 15);
            label6.TabIndex = 18;
            label6.Text = "Direccion";
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Location = new Point(237, 264);
            label7.Name = "label7";
            label7.Size = new Size(38, 15);
            label7.TabIndex = 19;
            label7.Text = "Barrio";
            // 
            // label8
            // 
            label8.AutoSize = true;
            label8.Location = new Point(18, 324);
            label8.Name = "label8";
            label8.Size = new Size(45, 15);
            label8.TabIndex = 20;
            label8.Text = "Ciudad";
            // 
            // label10
            // 
            label10.AutoSize = true;
            label10.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            label10.Location = new Point(153, 37);
            label10.Name = "label10";
            label10.Size = new Size(174, 30);
            label10.TabIndex = 22;
            label10.Text = "Detalles Inquilino";
            // 
            // chkAlquilando
            // 
            chkAlquilando.AutoSize = true;
            chkAlquilando.Enabled = false;
            chkAlquilando.Location = new Point(152, 394);
            chkAlquilando.Name = "chkAlquilando";
            chkAlquilando.Size = new Size(84, 19);
            chkAlquilando.TabIndex = 23;
            chkAlquilando.Text = "Alquilando";
            chkAlquilando.UseVisualStyleBackColor = true;
            // 
            // label9
            // 
            label9.AutoSize = true;
            label9.Location = new Point(13, 266);
            label9.Name = "label9";
            label9.Size = new Size(105, 15);
            label9.TabIndex = 37;
            label9.Text = "Duracion Contrato";
            // 
            // label12
            // 
            label12.AutoSize = true;
            label12.Location = new Point(59, 223);
            label12.Name = "label12";
            label12.Size = new Size(57, 15);
            label12.TabIndex = 35;
            label12.Text = "Fecha Fin";
            // 
            // label13
            // 
            label13.AutoSize = true;
            label13.Location = new Point(321, 61);
            label13.Name = "label13";
            label13.Size = new Size(60, 15);
            label13.TabIndex = 34;
            label13.Text = "Direccion:";
            // 
            // label14
            // 
            label14.AutoSize = true;
            label14.Location = new Point(48, 179);
            label14.Name = "label14";
            label14.Size = new Size(70, 15);
            label14.TabIndex = 33;
            label14.Text = "Fecha Inicio";
            // 
            // lbMts2
            // 
            lbMts2.AutoSize = true;
            lbMts2.Location = new Point(231, 61);
            lbMts2.Name = "lbMts2";
            lbMts2.Size = new Size(36, 15);
            lbMts2.TabIndex = 32;
            lbMts2.Text = "Mts2:";
            // 
            // txtDuracion
            // 
            txtDuracion.Location = new Point(124, 263);
            txtDuracion.Name = "txtDuracion";
            txtDuracion.ReadOnly = true;
            txtDuracion.Size = new Size(100, 23);
            txtDuracion.TabIndex = 31;
            // 
            // txtFin
            // 
            txtFin.Location = new Point(124, 220);
            txtFin.Name = "txtFin";
            txtFin.ReadOnly = true;
            txtFin.Size = new Size(100, 23);
            txtFin.TabIndex = 29;
            // 
            // txtDireccionPropiedad
            // 
            txtDireccionPropiedad.Location = new Point(387, 58);
            txtDireccionPropiedad.Name = "txtDireccionPropiedad";
            txtDireccionPropiedad.ReadOnly = true;
            txtDireccionPropiedad.Size = new Size(100, 23);
            txtDireccionPropiedad.TabIndex = 28;
            // 
            // label16
            // 
            label16.AutoSize = true;
            label16.Location = new Point(40, 131);
            label16.Name = "label16";
            label16.Size = new Size(78, 15);
            label16.TabIndex = 26;
            label16.Text = "Nro contrato:";
            // 
            // txtInicio
            // 
            txtInicio.Location = new Point(124, 176);
            txtInicio.Name = "txtInicio";
            txtInicio.ReadOnly = true;
            txtInicio.Size = new Size(100, 23);
            txtInicio.TabIndex = 25;
            // 
            // txtNroContrato
            // 
            txtNroContrato.Location = new Point(124, 128);
            txtNroContrato.Name = "txtNroContrato";
            txtNroContrato.ReadOnly = true;
            txtNroContrato.Size = new Size(100, 23);
            txtNroContrato.TabIndex = 24;
            // 
            // label11
            // 
            label11.AutoSize = true;
            label11.Location = new Point(31, 313);
            label11.Name = "label11";
            label11.Size = new Size(87, 15);
            label11.TabIndex = 39;
            label11.Text = "Monto Alquiler";
            // 
            // txtMonto
            // 
            txtMonto.Location = new Point(124, 310);
            txtMonto.Name = "txtMonto";
            txtMonto.ReadOnly = true;
            txtMonto.Size = new Size(100, 23);
            txtMonto.TabIndex = 38;
            // 
            // label18
            // 
            label18.AutoSize = true;
            label18.Location = new Point(237, 321);
            label18.Name = "label18";
            label18.Size = new Size(56, 15);
            label18.TabIndex = 43;
            label18.Text = "Provincia";
            // 
            // txtProvincia
            // 
            txtProvincia.Location = new Point(316, 316);
            txtProvincia.Name = "txtProvincia";
            txtProvincia.ReadOnly = true;
            txtProvincia.Size = new Size(100, 23);
            txtProvincia.TabIndex = 42;
            // 
            // pnlDetalleContrato
            // 
            pnlDetalleContrato.Controls.Add(label1);
            pnlDetalleContrato.Controls.Add(pbImagen);
            pnlDetalleContrato.Controls.Add(btnSiguiente);
            pnlDetalleContrato.Controls.Add(btnAnterior);
            pnlDetalleContrato.Controls.Add(label11);
            pnlDetalleContrato.Controls.Add(lbContador);
            pnlDetalleContrato.Controls.Add(txtMonto);
            pnlDetalleContrato.Controls.Add(txtNroContrato);
            pnlDetalleContrato.Controls.Add(label9);
            pnlDetalleContrato.Controls.Add(txtInicio);
            pnlDetalleContrato.Controls.Add(label12);
            pnlDetalleContrato.Controls.Add(label16);
            pnlDetalleContrato.Controls.Add(label13);
            pnlDetalleContrato.Controls.Add(txtDireccionPropiedad);
            pnlDetalleContrato.Controls.Add(label14);
            pnlDetalleContrato.Controls.Add(txtFin);
            pnlDetalleContrato.Controls.Add(lbMts2);
            pnlDetalleContrato.Controls.Add(txtDuracion);
            pnlDetalleContrato.Location = new Point(445, 24);
            pnlDetalleContrato.Name = "pnlDetalleContrato";
            pnlDetalleContrato.Size = new Size(502, 435);
            pnlDetalleContrato.TabIndex = 44;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI", 15.75F, FontStyle.Regular, GraphicsUnit.Point);
            label1.Location = new Point(170, 13);
            label1.Name = "label1";
            label1.Size = new Size(174, 30);
            label1.TabIndex = 45;
            label1.Text = "Detalles Contrato";
            // 
            // FrmDetalleInquilino
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(17, 76, 95);
            ClientSize = new Size(964, 491);
            Controls.Add(pnlDetalleContrato);
            Controls.Add(label18);
            Controls.Add(txtProvincia);
            Controls.Add(chkAlquilando);
            Controls.Add(label10);
            Controls.Add(label8);
            Controls.Add(label7);
            Controls.Add(label6);
            Controls.Add(label5);
            Controls.Add(label4);
            Controls.Add(label3);
            Controls.Add(txtCiudad);
            Controls.Add(txtBarrio);
            Controls.Add(txtDireccion);
            Controls.Add(txtDoc);
            Controls.Add(txtApellido);
            Controls.Add(label2);
            Controls.Add(chkDatosContrato);
            Controls.Add(txtTipoDoc);
            Controls.Add(txtNombre);
            ForeColor = Color.White;
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "FrmDetalleInquilino";
            StartPosition = FormStartPosition.CenterParent;
            Text = "DetalleInquilino";
            Load += FrmDetalleInquilino_Load;
            ((System.ComponentModel.ISupportInitialize)pbImagen).EndInit();
            pnlDetalleContrato.ResumeLayout(false);
            pnlDetalleContrato.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private PictureBox pbImagen;
        private Button btnSiguiente;
        private Button btnAnterior;
        private Label lbContador;
        private TextBox txtNombre;
        private TextBox txtTipoDoc;
        private CheckBox chkDatosContrato;
        private Label label2;
        private TextBox txtApellido;
        private TextBox txtDoc;
        private TextBox txtDireccion;
        private TextBox txtBarrio;
        private TextBox txtCiudad;
        private Label label3;
        private Label label4;
        private Label label5;
        private Label label6;
        private Label label7;
        private Label label8;
        private Label label10;
        private CheckBox chkAlquilando;
        private Label label9;
        private Label label12;
        private Label label13;
        private Label label14;
        private Label lbMts2;
        private TextBox txtDuracion;
        private TextBox txtFin;
        private TextBox txtDireccionPropiedad;
        private Label label16;
        private TextBox txtInicio;
        private TextBox txtNroContrato;
        private Label label11;
        private TextBox txtMonto;
        private Label label18;
        private TextBox txtProvincia;
        private Panel pnlDetalleContrato;
        private Label label1;
    }
}