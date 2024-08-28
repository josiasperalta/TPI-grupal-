using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.DataTransferObjects
{
    public class ContratoDTO
    {
        // QUE MOSTRAMOS DEL CONTRATO
        public int NroContrato { get; set; }
        public DateTime FecInicio { get; set; }
        public DateTime FecFin { get; set; }
        public int DuracionAnios { get; set; }
        public decimal MontoAlquiler { get; set; }

    }
}
