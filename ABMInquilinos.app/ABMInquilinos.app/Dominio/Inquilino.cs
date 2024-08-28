using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.Dominio
{
    public class Inquilino
    {
        public int IdInquilino { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public TipoDocumento TipoDocumento { get; set; }
        public int NroDoc { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Direccion { get; set; }
        public int NroCalle { get; set; }
        public Barrio Barrio { get; set; }
        public bool Alquilando { get; set; }
        public bool Estado { get; set; }
    }
}
