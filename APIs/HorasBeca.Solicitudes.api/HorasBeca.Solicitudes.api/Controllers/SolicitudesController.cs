using System.Web.Http;
using System.Web.Http.Cors;
using Newtonsoft.Json.Linq;


namespace HorasBeca.Solicitudes.api.Controllers
{
    /**
    * Solicitud Controller
    * */
    using HorasBeca.Solicitudes.api.Models;
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class SolicitudesController : ApiController
    {
        JObject respuesta = new JObject();
        Solicitudes solicitud = new Solicitudes();
        public JObject Get()
        {
            respuesta.Add("Codigo", 200);
            respuesta.Add("Estado", "Exito");
            return respuesta;
        }

        public JObject Post(JObject x, string codigo)
        {
            switch (codigo)
            {
                case ("S01")://Codigo S01 -> Envio de solicitud
                    respuesta = solicitud.InsertarSolicitud(x);
                    break;
                case ("S02")://Codigo S02 -> Solicitud de solicitudes por tipo solicitud
                    respuesta = solicitud.ObtenerTodasSolicitudesPorTipo(x);
                    break;
                case ("S03")://Codigo S03 -> Solicitud de solicitudes por carne
                    respuesta = solicitud.ObtenerTodasSolicitudesPorCarne(x);
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
                case ("S04")://Cancelar Solicitud(Diferente a borrador)
                    respuesta = solicitud.CambiarEstadoSolicitud(data);
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
                case ("S05")://Borrar Solicitudes (Borrador)
                    respuesta = solicitud.EliminarSolicitud(data);
                    break;
                default:
                    break;
            }
            return respuesta;
        }
    }
}
