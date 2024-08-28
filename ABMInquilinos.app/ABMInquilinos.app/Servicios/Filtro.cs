using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ABMInquilinos.app.Servicios
{
    public class Filtro
    {
        public Filtro(string campo,string criterio,string valor)
        {
            this.Campo = campo;
            this.Criterio = criterio;
            this.Valor = valor;
        }
        public string Campo { get; set; }
        public string Criterio { get; set; }
        public string Valor { get; set; }   
    }
}
