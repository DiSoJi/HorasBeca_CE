using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using Newtonsoft.Json.Linq;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    /**
    * Solicitud Controller
   * */
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class ConfiguracionesController : ApiController
    {
        JObject respuesta = new JObject();
        Configuraciones config = new Configuraciones();

        public JObject Get()
        {
            respuesta.Add("Codigo", 200);
            respuesta.Add("Estado", "Exito");
            return respuesta;
        }

        public JObject Post(JObject data, string codigo)
        {
            switch (codigo)
            {
                case ("C01")://Codigo C01 -> Creacion de periodo
                    respuesta = config.AbrirPeriodo(data);
                    break;
                case ("C04")://Codigo C04 -> Obtener Periodo Activo
                    respuesta = config.ObtenerPeriodo();
                    break;
                case ("C05")://Codigo C05 -> Obtener historial peridos 
                    respuesta = config.ObtenerTodosPeriodos();
                    break;
                default:
                    break;
            }
            return respuesta;
        }
        public JObject Delete(JObject data, string codigo)
        {
            switch (codigo)
            {
                case ("C02")://Codigo C02 -> Eliminacion de periodo
                    respuesta = config.CerrarPeriodo(data);
                    break;
                default:
                    break;
            }
            return respuesta;
        }

        public JObject Put(JObject data, string codigo)
        {
            switch (codigo)
            {
                case ("C03")://Codigo C03 -> Extender Perido
                    respuesta = config.ExtenderPerido(data);
                    break;
                default:
                    break;
            }
            return respuesta;
        }
    }
}
