using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.Data;

namespace HorasBeca.Solicitudes.api.Models
{
    public class Solicitudes
    {
        string connectionString = "";
        public Solicitudes()
        {
            connectionString = WebConfigurationManager.AppSettings["ConnectionString"];
        }

        public JObject InsertarSolicitud(JObject data)
        {
            string tipoSolicitud = (string)data.GetValue("tipoSolicitud");
            data["imgPpg"] = Convert.FromBase64String((string)data.GetValue("imgPpg").ToString());
            data["imgPps"] = Convert.FromBase64String((string)data.GetValue("imgPps").ToString());
            data["imgCg"] = Convert.FromBase64String((string)data.GetValue("imgCg").ToString());
            data["imgCs"] = Convert.FromBase64String((string)data.GetValue("imgCs").ToString());
            data["imgCBanco"] = Convert.FromBase64String((string)data.GetValue("imgCBanco").ToString());
            data["imgNotaCurso"] = Convert.FromBase64String((string)data.GetValue("imgNotaCurso").ToString());
            data.Remove("tipoSolicitud");
            DataTable table = SolicitudWrapper(data);
            JObject respuesta = new JObject();
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Solicitud_Test", dbConexion);//LLama un Stored Procedur

            Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = table;
            Comando.CommandType = CommandType.StoredProcedure;
            return respuesta;
        }

        public DataTable SolicitudWrapper(JObject data)
        {
            dynamic temp = data;
            //Se crea la tabla con las columnas
            DataTable SolicitudWrapper = new DataTable();
            SolicitudWrapper.Columns.Add("cedula", typeof(int));
            SolicitudWrapper.Columns.Add("proPonGeneral", typeof(float));
            SolicitudWrapper.Columns.Add("proPonSemestral", typeof(float));
            SolicitudWrapper.Columns.Add("creditosGeneral", typeof(int));
            SolicitudWrapper.Columns.Add("creditosSemestre", typeof(int));
            SolicitudWrapper.Columns.Add("cuentaBanco", typeof(int));
            SolicitudWrapper.Columns.Add("banco", typeof(string));
            SolicitudWrapper.Columns.Add("carne", typeof(string));
            SolicitudWrapper.Columns.Add("horas", typeof(int));
            SolicitudWrapper.Columns.Add("imgPpg", typeof(string));
            SolicitudWrapper.Columns.Add("imgPps", typeof(string));
            SolicitudWrapper.Columns.Add("imgCg", typeof(string));
            SolicitudWrapper.Columns.Add("imgCs", typeof(string));
            SolicitudWrapper.Columns.Add("imgCBanco", typeof(string));
            SolicitudWrapper.Columns.Add("idCurso", typeof(int));
            SolicitudWrapper.Columns.Add("idProfesor", typeof(int));
            SolicitudWrapper.Columns.Add("notaCurso", typeof(int));
            SolicitudWrapper.Columns.Add("imgNotaCurso", typeof(string));
            SolicitudWrapper.Columns.Add("fecha", typeof(DateTime));
            SolicitudWrapper.Columns.Add("telefono", typeof(int));
            SolicitudWrapper.Columns.Add("anosTEC", typeof(float));
            //Agregar informacion
            SolicitudWrapper.Rows.Add((int)temp.cedula, (float)temp.proPonGeneral, (float)temp.proPonSemestral,
                (int)temp.creditosGeneral, (int)temp.creditosSemestre, (int)temp.cuentaBanco, (string)temp.banco, 
                (string)temp.carne, (int)temp.horas, (string)temp.imgPpg, (string)temp.imgPps, (string)temp.imgCg,
                (string)temp.imgCs, (string)temp.imgCBanco, (int)temp.idCurso, (int)temp.idProfesor, (int)temp.notaCurso,
                (string)temp.imgNotaCurso, (DateTime)temp.fecha, (int)temp.telefono, (float)temp.anosTEC);

            return SolicitudWrapper;

        }

            

    }
}