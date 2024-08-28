using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.Dominio
{
    public class Barrio
    {
        public int IdBarrio { get; set; }

        public string Descripcion { get; set; }

        public Ciudad Ciudad { get; set; }

        public override string ToString()
        {
            return Descripcion;
        }
    }
}
