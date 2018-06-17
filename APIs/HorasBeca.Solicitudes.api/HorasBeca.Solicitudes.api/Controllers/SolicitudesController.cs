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
      
       Solicitudes solicitud = new Solicitudes();
        public JObject Get()
        {
            JObject response =
                new JObject(
                new JProperty("Codigo", 200),
                new JProperty("Descripcion", "Exito")
                );
            return response;
        }

        public JObject Post(JObject x, string codigo)
        {
            JObject resultado = new JObject();
            switch (codigo){
                case ("S01")://Codigo S01 -> Envio de solicitud
                    resultado = solicitud.InsertarSolicitud(x);
                    break;
                case ("S02")://Codigo S02 -> Solicitud de solicitudes por tipo solicitud
                    resultado = solicitud.ObtenerTodasSolicitudesPorTipo(x);
                    break;
                case ("S03")://Codigo S03 -> Solicitud de solicitudes por carne
                    resultado = solicitud.ObtenerTodasSolicitudesPorCarne(x);
                    break;
                case ("S04")://Actualizar estado 
                    //resultado = solicitud.
                    break;
                default:
                    break;
            }
            return resultado;
      
        }
    }
}
