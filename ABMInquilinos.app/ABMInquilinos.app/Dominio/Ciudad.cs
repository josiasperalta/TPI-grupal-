using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.Dominio
{
    public class Ciudad
    {
        public int IdCiudad { get; set; }

        public string Descripcion { get; set; }

        public Provincia Provincia { get; set; } 
        
        public override string ToString()
        {
            return Descripcion;
        }
    }
}
