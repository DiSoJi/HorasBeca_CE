using System.Web;
using System.Web.Mvc;

namespace HorasBeca.Solicitudes.api
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
