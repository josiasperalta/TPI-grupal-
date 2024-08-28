namespace ABMInquilinos.app.Vistas
{
    partial class FrmPrincipal
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
            msMenu = new MenuStrip();
            tsmiArchivo = new ToolStripMenuItem();
            tsmiSalir = new ToolStripMenuItem();
            tsmiSoporte = new ToolStripMenuItem();
            tsmiABMC = new ToolStripMenuItem();
            tsmiConsulta = new ToolStripMenuItem();
            tsmiConsultasDB = new ToolStripMenuItem();
            tsmiAcercaDe = new ToolStripMenuItem();
            tsmiVersion = new ToolStripMenuItem();
            tsmiVersionModelo = new ToolStripMenuItem();
            tsmiResponsables = new ToolStripMenuItem();
            tsmiActis = new ToolStripMenuItem();
            tsmiMarconetto = new ToolStripMenuItem();
            tsmiPeralta = new ToolStripMenuItem();
            tsmiPertusati = new ToolStripMenuItem();
            tsmiPretto = new ToolStripMenuItem();
            tsmiVecchio = new ToolStripMenuItem();
            label1 = new Label();
            label2 = new Label();
            label3 = new Label();
            msMenu.SuspendLayout();
            SuspendLayout();
            // 
            // msMenu
            // 
            msMenu.Items.AddRange(new ToolStripItem[] { tsmiArchivo, tsmiSoporte, tsmiConsulta, tsmiAcercaDe });
            msMenu.Location = new Point(0, 0);
            msMenu.Name = "msMenu";
            msMenu.Size = new Size(654, 24);
            msMenu.TabIndex = 0;
            // 
            // tsmiArchivo
            // 
            tsmiArchivo.DropDownItems.AddRange(new ToolStripItem[] { tsmiSalir });
            tsmiArchivo.Name = "tsmiArchivo";
            tsmiArchivo.Size = new Size(60, 20);
            tsmiArchivo.Text = "Archivo";
            // 
            // tsmiSalir
            // 
            tsmiSalir.Name = "tsmiSalir";
            tsmiSalir.Size = new Size(96, 22);
            tsmiSalir.Text = "Salir";
            tsmiSalir.Click += salirToolStripMenuItem_Click;
            // 
            // tsmiSoporte
            // 
            tsmiSoporte.DropDownItems.AddRange(new ToolStripItem[] { tsmiABMC });
            tsmiSoporte.Name = "tsmiSoporte";
            tsmiSoporte.Size = new Size(60, 20);
            tsmiSoporte.Text = "Soporte";
            // 
            // tsmiABMC
            // 
            tsmiABMC.Name = "tsmiABMC";
            tsmiABMC.Size = new Size(174, 22);
            tsmiABMC.Text = "Inmobiliaria ABMC";
            tsmiABMC.Click += inmobiliariaABMCToolStripMenuItem_Click;
            // 
            // tsmiConsulta
            // 
            tsmiConsulta.DropDownItems.AddRange(new ToolStripItem[] { tsmiConsultasDB });
            tsmiConsulta.Name = "tsmiConsulta";
            tsmiConsulta.Size = new Size(71, 20);
            tsmiConsulta.Text = "Consultas";
            // 
            // tsmiConsultasDB
            // 
            tsmiConsultasDB.Name = "tsmiConsultasDB";
            tsmiConsultasDB.Size = new Size(201, 22);
            tsmiConsultasDB.Text = "Consultar Base de Datos";
            tsmiConsultasDB.Click += inquilinosToolStripMenuItem_Click;
            // 
            // tsmiAcercaDe
            // 
            tsmiAcercaDe.DropDownItems.AddRange(new ToolStripItem[] { tsmiVersion, tsmiResponsables });
            tsmiAcercaDe.Name = "tsmiAcercaDe";
            tsmiAcercaDe.Size = new Size(80, 20);
            tsmiAcercaDe.Text = "Acerca de...";
            // 
            // tsmiVersion
            // 
            tsmiVersion.DropDownItems.AddRange(new ToolStripItem[] { tsmiVersionModelo });
            tsmiVersion.Name = "tsmiVersion";
            tsmiVersion.Size = new Size(220, 22);
            tsmiVersion.Text = "Versión";
            // 
            // tsmiVersionModelo
            // 
            tsmiVersionModelo.Font = new Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point);
            tsmiVersionModelo.Name = "tsmiVersionModelo";
            tsmiVersionModelo.Size = new Size(139, 22);
            tsmiVersionModelo.Text = "v.20240616";
            // 
            // tsmiResponsables
            // 
            tsmiResponsables.DropDownItems.AddRange(new ToolStripItem[] { tsmiActis, tsmiMarconetto, tsmiPeralta, tsmiPertusati, tsmiPretto, tsmiVecchio });
            tsmiResponsables.Name = "tsmiResponsables";
            tsmiResponsables.Size = new Size(220, 22);
            tsmiResponsables.Text = "Responsables del Desarrollo";
            // 
            // tsmiActis
            // 
            tsmiActis.Font = new Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point);
            tsmiActis.Name = "tsmiActis";
            tsmiActis.Size = new Size(244, 22);
            tsmiActis.Text = "Actis Joel Leonardo - 412083";
            // 
            // tsmiMarconetto
            // 
            tsmiMarconetto.Font = new Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point);
            tsmiMarconetto.Name = "tsmiMarconetto";
            tsmiMarconetto.Size = new Size(244, 22);
            tsmiMarconetto.Text = "Marconetto Santiago - 412861";
            // 
            // tsmiPeralta
            // 
            tsmiPeralta.Font = new Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point);
            tsmiPeralta.Name = "tsmiPeralta";
            tsmiPeralta.Size = new Size(244, 22);
            tsmiPeralta.Text = "Peralta Josias - 412469";
            // 
            // tsmiPertusati
            // 
            tsmiPertusati.Font = new Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point);
            tsmiPertusati.Name = "tsmiPertusati";
            tsmiPertusati.Size = new Size(244, 22);
            tsmiPertusati.Text = "Pertusati Tobias - 412301";
            // 
            // tsmiPretto
            // 
            tsmiPretto.Font = new Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point);
            tsmiPretto.Name = "tsmiPretto";
            tsmiPretto.Size = new Size(244, 22);
            tsmiPretto.Text = "Pretto Valentino - 412618";
            // 
            // tsmiVecchio
            // 
            tsmiVecchio.Font = new Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point);
            tsmiVecchio.Name = "tsmiVecchio";
            tsmiVecchio.Size = new Size(244, 22);
            tsmiVecchio.Text = "Vecchio Benjamín - 412311";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI", 36F, FontStyle.Bold, GraphicsUnit.Point);
            label1.ForeColor = SystemColors.HighlightText;
            label1.Location = new Point(171, 197);
            label1.Name = "label1";
            label1.Size = new Size(335, 65);
            label1.TabIndex = 1;
            label1.Text = "¡Bienvenidos!";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new Font("Segoe UI", 20.25F, FontStyle.Bold, GraphicsUnit.Point);
            label2.ForeColor = SystemColors.HighlightText;
            label2.Location = new Point(439, 419);
            label2.Name = "label2";
            label2.Size = new Size(203, 37);
            label2.TabIndex = 2;
            label2.Text = "TPI - Grupo 22";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Font = new Font("Segoe UI", 20.25F, FontStyle.Bold, GraphicsUnit.Point);
            label3.ForeColor = SystemColors.HighlightText;
            label3.Location = new Point(12, 419);
            label3.Name = "label3";
            label3.Size = new Size(313, 37);
            label3.TabIndex = 3;
            label3.Text = "Programación I Lógica ";
            // 
            // FrmPrincipal
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(17, 76, 95);
            ClientSize = new Size(654, 491);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(msMenu);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MainMenuStrip = msMenu;
            MaximizeBox = false;
            Name = "FrmPrincipal";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Inicio";
            msMenu.ResumeLayout(false);
            msMenu.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private MenuStrip msMenu;
        private ToolStripMenuItem tsmiArchivo;
        private ToolStripMenuItem tsmiSalir;
        private ToolStripMenuItem tsmiSoporte;
        private ToolStripMenuItem tsmiConsulta;
        private ToolStripMenuItem tsmiAcercaDe;
        private ToolStripMenuItem tsmiVersion;
        private ToolStripMenuItem tsmiVersionModelo;
        private ToolStripMenuItem tsmiResponsables;
        private ToolStripMenuItem tsmiActis;
        private ToolStripMenuItem tsmiMarconetto;
        private ToolStripMenuItem tsmiPeralta;
        private ToolStripMenuItem tsmiPertusati;
        private ToolStripMenuItem tsmiPretto;
        private ToolStripMenuItem tsmiVecchio;
        private ToolStripMenuItem tsmiABMC;
        private ToolStripMenuItem tsmiConsultasDB;
        private Label label1;
        private Label label2;
        private Label label3;
    }
}