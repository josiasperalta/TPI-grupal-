using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.Dominio
{
    public class TipoDocumento
    {
        public int IdTipoDoc { get; set; }

        public string Descripcion { get; set; }
        public override string ToString()
        {
            return Descripcion;
        }

    }
}
