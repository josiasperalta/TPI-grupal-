using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.DataTransferObjects
{
    public class PropiedadDTO
    {
        public int IdPropiedad { get; set; }
        public string Direccion { get; set; }
        public int NroCalle { get; set; }
        public int Mts2 { get; set; }
        public string Barrio { get; set; }
        public string Ciudad { get; set; }
        public string Provincia { get; set; }

    }
}
