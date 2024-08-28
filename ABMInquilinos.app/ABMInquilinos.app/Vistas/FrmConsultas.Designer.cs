namespace ABMInquilinos.app.Vistas
{
    partial class FrmConsultas
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
            DataGridViewCellStyle dataGridViewCellStyle2 = new DataGridViewCellStyle();
            DataGridViewCellStyle dataGridViewCellStyle3 = new DataGridViewCellStyle();
            DataGridViewCellStyle dataGridViewCellStyle4 = new DataGridViewCellStyle();
            dgvConsultar = new DataGridView();
            btnConsultar = new Button();
            lblConsulta = new Label();
            rbContratos = new RadioButton();
            rbPropiedades = new RadioButton();
            rbSedes = new RadioButton();
            ((System.ComponentModel.ISupportInitialize)dgvConsultar).BeginInit();
            SuspendLayout();
            // 
            // dgvConsultar
            // 
            dgvConsultar.AllowUserToAddRows = false;
            dgvConsultar.AllowUserToDeleteRows = false;
            dgvConsultar.AllowUserToResizeColumns = false;
            dgvConsultar.AllowUserToResizeRows = false;
            dgvConsultar.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvConsultar.BackgroundColor = Color.FromArgb(0, 48, 73);
            dgvConsultar.BorderStyle = BorderStyle.None;
            dataGridViewCellStyle1.Alignment = DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = Color.FromArgb(0, 48, 73);
            dataGridViewCellStyle1.Font = new Font("Segoe UI", 14.25F, FontStyle.Bold, GraphicsUnit.Point);
            dataGridViewCellStyle1.ForeColor = Color.White;
            dataGridViewCellStyle1.SelectionBackColor = Color.FromArgb(0, 48, 73);
            dataGridViewCellStyle1.SelectionForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = DataGridViewTriState.True;
            dgvConsultar.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            dgvConsultar.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle2.Alignment = DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = Color.FromArgb(51, 92, 103);
            dataGridViewCellStyle2.Font = new Font("Segoe UI", 11.25F, FontStyle.Regular, GraphicsUnit.Point);
            dataGridViewCellStyle2.ForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle2.SelectionBackColor = Color.FromArgb(7, 153, 182);
            dataGridViewCellStyle2.SelectionForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = DataGridViewTriState.False;
            dgvConsultar.DefaultCellStyle = dataGridViewCellStyle2;
            dgvConsultar.EnableHeadersVisualStyles = false;
            dgvConsultar.Location = new Point(27, 218);
            dgvConsultar.Name = "dgvConsultar";
            dgvConsultar.ReadOnly = true;
            dataGridViewCellStyle3.Alignment = DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = Color.FromArgb(102, 155, 188);
            dataGridViewCellStyle3.Font = new Font("Segoe UI", 9F, FontStyle.Regular, GraphicsUnit.Point);
            dataGridViewCellStyle3.ForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle3.SelectionBackColor = Color.FromArgb(0, 192, 192);
            dataGridViewCellStyle3.SelectionForeColor = SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = DataGridViewTriState.True;
            dgvConsultar.RowHeadersDefaultCellStyle = dataGridViewCellStyle3;
            dataGridViewCellStyle4.BackColor = Color.FromArgb(102, 155, 188);
            dataGridViewCellStyle4.ForeColor = Color.White;
            dataGridViewCellStyle4.SelectionBackColor = Color.FromArgb(0, 192, 192);
            dataGridViewCellStyle4.SelectionForeColor = Color.White;
            dgvConsultar.RowsDefaultCellStyle = dataGridViewCellStyle4;
            dgvConsultar.RowTemplate.Height = 25;
            dgvConsultar.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvConsultar.Size = new Size(881, 333);
            dgvConsultar.TabIndex = 0;
            // 
            // btnConsultar
            // 
            btnConsultar.FlatStyle = FlatStyle.Flat;
            btnConsultar.Font = new Font("Segoe UI", 18F, FontStyle.Regular, GraphicsUnit.Point);
            btnConsultar.ForeColor = Color.White;
            btnConsultar.Location = new Point(764, 153);
            btnConsultar.Name = "btnConsultar";
            btnConsultar.Size = new Size(135, 49);
            btnConsultar.TabIndex = 1;
            btnConsultar.Text = "Consultar";
            btnConsultar.UseVisualStyleBackColor = true;
            btnConsultar.Click += btnConsultar_Click;
            // 
            // lblConsulta
            // 
            lblConsulta.AutoSize = true;
            lblConsulta.Font = new Font("Segoe UI", 24F, FontStyle.Regular, GraphicsUnit.Point);
            lblConsulta.ForeColor = Color.White;
            lblConsulta.Location = new Point(38, 9);
            lblConsulta.Name = "lblConsulta";
            lblConsulta.Size = new Size(158, 45);
            lblConsulta.TabIndex = 2;
            lblConsulta.Text = "Consultas";
            // 
            // rbContratos
            // 
            rbContratos.AutoSize = true;
            rbContratos.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point);
            rbContratos.ForeColor = Color.White;
            rbContratos.Location = new Point(38, 88);
            rbContratos.Name = "rbContratos";
            rbContratos.Size = new Size(96, 25);
            rbContratos.TabIndex = 3;
            rbContratos.TabStop = true;
            rbContratos.Text = "Contratos";
            rbContratos.UseVisualStyleBackColor = true;
            rbContratos.CheckedChanged += rbContratos_CheckedChanged;
            // 
            // rbPropiedades
            // 
            rbPropiedades.AutoSize = true;
            rbPropiedades.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point);
            rbPropiedades.ForeColor = Color.White;
            rbPropiedades.Location = new Point(38, 130);
            rbPropiedades.Name = "rbPropiedades";
            rbPropiedades.Size = new Size(114, 25);
            rbPropiedades.TabIndex = 4;
            rbPropiedades.TabStop = true;
            rbPropiedades.Text = "Propiedades";
            rbPropiedades.UseVisualStyleBackColor = true;
            rbPropiedades.CheckedChanged += rbPropiedades_CheckedChanged;
            // 
            // rbSedes
            // 
            rbSedes.AutoSize = true;
            rbSedes.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point);
            rbSedes.ForeColor = Color.White;
            rbSedes.Location = new Point(38, 172);
            rbSedes.Name = "rbSedes";
            rbSedes.Size = new Size(69, 25);
            rbSedes.TabIndex = 5;
            rbSedes.TabStop = true;
            rbSedes.Text = "Sedes";
            rbSedes.UseVisualStyleBackColor = true;
            rbSedes.CheckedChanged += rbSedes_CheckedChanged;
            // 
            // FrmConsultas
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(17, 76, 95);
            ClientSize = new Size(920, 563);
            Controls.Add(rbSedes);
            Controls.Add(rbPropiedades);
            Controls.Add(rbContratos);
            Controls.Add(lblConsulta);
            Controls.Add(btnConsultar);
            Controls.Add(dgvConsultar);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            Name = "FrmConsultas";
            StartPosition = FormStartPosition.CenterParent;
            Text = "Consultas a BD";
            Load += FrmConsultas_Load;
            ((System.ComponentModel.ISupportInitialize)dgvConsultar).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private DataGridView dgvConsultar;
        private Button btnConsultar;
        private Label lblConsulta;
        private RadioButton rbContratos;
        private RadioButton rbPropiedades;
        private RadioButton rbSedes;
    }
}