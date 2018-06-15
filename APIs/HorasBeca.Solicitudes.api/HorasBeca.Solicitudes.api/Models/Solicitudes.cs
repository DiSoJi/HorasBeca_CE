using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Data.SqlTypes;

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
            byte[] imgPpg = Convert.FromBase64String((string)data.GetValue("imgPpg"));
            data["imgPpg"] = imgPpg;
            byte[] imgPps = Convert.FromBase64String((string)data.GetValue("imgPps"));
            data["imgPps"] = imgPps;
            byte[] imgCg = Convert.FromBase64String((string)data.GetValue("imgCg"));
            data["imgCg"] = imgCg;
            byte[] imgCs = Convert.FromBase64String((string)data.GetValue("imgCs"));
            data["imgCs"] = imgCs;
            byte[] imgCBanco = Convert.FromBase64String((string)data.GetValue("imgCBanco"));
            data["imgCBanco"] = imgCBanco;
            byte[] imgNotaCurso = Convert.FromBase64String((string)data.GetValue("imgNotaCurso"));
            data["imgNotaCurso"] = imgNotaCurso;
            data.Remove("tipoSolicitud");
            DataTable table = SolicitudWrapper(data);
            JObject respuesta = new JObject();
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Solicitud_Test", dbConexion);//LLama un Stored Procedur
            Comando.CommandType = CommandType.StoredProcedure;
            Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = table;
            int temp = Comando.ExecuteNonQuery();
            return respuesta;
        }

        public DataTable SolicitudWrapper(JObject data)
        {
            dynamic temp = data;
            //Se crea la tabla con las columnas
            DataTable table = new DataTable();
            table.Columns.Add("cedula", typeof(int));
            table.Columns.Add("proPonGeneral", typeof(float));
            table.Columns.Add("proPonSemestral", typeof(float));
            table.Columns.Add("creditosGeneral", typeof(int));
            table.Columns.Add("creditosSemestre", typeof(int));
            table.Columns.Add("cuentaBanco", typeof(int));
            table.Columns.Add("banco", typeof(string));
            table.Columns.Add("carne", typeof(string));
            table.Columns.Add("horas", typeof(int));
            table.Columns.Add("imgPpg", typeof(SqlBinary));
            table.Columns.Add("imgPps", typeof(SqlBinary));
            table.Columns.Add("imgCg", typeof(SqlBinary));
            table.Columns.Add("imgCs", typeof(SqlBinary));
            table.Columns.Add("imgCBanco", typeof(SqlBinary));
            table.Columns.Add("idCurso", typeof(int));
            table.Columns.Add("idProfesor", typeof(int));
            table.Columns.Add("notaCurso", typeof(int));
            table.Columns.Add("imgNotaCurso", typeof(SqlBinary));
            table.Columns.Add("fecha", typeof(DateTime));
            table.Columns.Add("telefono", typeof(int));
            table.Columns.Add("anosTEC", typeof(float));
            //Agregar informacion
            table.Rows.Add((int)temp.cedula, (float)temp.proPonGeneral, (float)temp.proPonSemestral,
                (int)temp.creditosGeneral, (int)temp.creditosSemestre, (int)temp.cuentaBanco, (string)temp.banco, 
                (string)temp.carne, (int)temp.horas, (byte[])temp.imgPpg, (byte[])temp.imgPps, (byte[])temp.imgCg,
                (byte[])temp.imgCs, (byte[])temp.imgCBanco, (int)temp.idCurso, (int)temp.idProfesor, (int)temp.notaCurso,
                (byte[])temp.imgNotaCurso, (DateTime)temp.fecha, (int)temp.telefono, (float)temp.anosTEC);

            return table;

        }

            

    }
}