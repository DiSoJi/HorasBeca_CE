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
    //Clase Solicitudes
    //Maneja todas las interacciones con la base de datos
    public class Solicitudes
    {
        string connectionString = "";
        int rowsAffected = 0;
        public Solicitudes()
        {
            connectionString = WebConfigurationManager.AppSettings["ConnectionString"];
        }

        public JObject InsertarSolicitud(JObject data)
        {
            JObject respuesta = new JObject();
            string tipoSolicitud = (string)data.GetValue("tipoSolicitud");
            //Cobierte las imagenes de base64 a bit[]
            data["imgPpg"] = Convert.FromBase64String((string)data.GetValue("imgPpg"));
            data["imgPps"] = Convert.FromBase64String((string)data.GetValue("imgPps"));
            data["imgCg"] = Convert.FromBase64String((string)data.GetValue("imgCg"));
            data["imgCs"] = Convert.FromBase64String((string)data.GetValue("imgCs"));
            data["imgCBanco"] = Convert.FromBase64String((string)data.GetValue("imgCBanco"));
            data["imgNotaCurso"] = Convert.FromBase64String((string)data.GetValue("imgNotaCurso"));
            data["imgCed"] = Convert.FromBase64String((string)data.GetValue("imgCed"));
            data["imgCar"] = Convert.FromBase64String((string)data.GetValue("imgCar"));
            data.Remove("tipoSolicitud");
            var otrasAsistenciasDesc = data.GetValue("otrasAsistenciasDesc");
            var otrasAsistenciasHoras = data.GetValue("otrasAsistenciasHoras");
            data.Remove("otrasAsistenciasDesc");
            data.Remove("otrasAsistenciasHoras");
            bool existOtrasAsistencias = false;
            //Retorna una wrapper(tabla) con toda la informacion para mandarla al store procedure
            DataTable solicitudTable = SolicitudWrapper(data);
            DataTable otrasAsistenciasTable = new DataTable();
            if (otrasAsistenciasDesc.Count() > 0) {
                existOtrasAsistencias = true;
                otrasAsistenciasTable = OtrasAsistenciasWrapper(otrasAsistenciasDesc, otrasAsistenciasHoras);
            }
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            switch (tipoSolicitud)
            {
                //Solicitud Horas Estudiante
                case ("HE"):
                    if (existOtrasAsistencias)
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Estudiante_UDP_1", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        Comando.Parameters.Add("@AsistenciasWrapper", SqlDbType.Structured).Value = otrasAsistenciasTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Estudiante_UDP_2", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    break;
                //Solicitud Horas Asistente
                case ("HA"):
                    if (existOtrasAsistencias)
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Asistente_UDP_1", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        Comando.Parameters.Add("@AsistenciasWrapper", SqlDbType.Structured).Value = otrasAsistenciasTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Asistente_UDP_2", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    break;
                //Solicitud Asistencia Especial 
                case ("AE"):
                    if (existOtrasAsistencias)
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Especial_UDP_1", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        Comando.Parameters.Add("@AsistenciasWrapper", SqlDbType.Structured).Value = otrasAsistenciasTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Especial_UDP_2", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    break;
                //Solicitud Horas Tutoria
                case ("HT"):
                    if (existOtrasAsistencias)
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Tutor_UDP_1", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        Comando.Parameters.Add("@AsistenciasWrapper", SqlDbType.Structured).Value = otrasAsistenciasTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Insert_Sol_Horas_Tutor_UDP_2", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@solicitudWrapper", SqlDbType.Structured).Value = solicitudTable;
                        rowsAffected = Comando.ExecuteNonQuery();
                    }
                    break;
            }
            //Por problemas con el noncount la insersion es correcta si afecta al numero teorico de filas
            if (rowsAffected == (2 + otrasAsistenciasDesc.Count()))
            {
                respuesta.Add("Estado", "Exito");
                respuesta.Add("Codigo", 200);
            }
            else
            {
                respuesta.Add("Estado", "Error");
                respuesta.Add("Codigo", 201);
            }
            return respuesta;
        }
        //Wrapper para enviar la informacion de la solicitud de asistencia 
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
            table.Columns.Add("imgCed", typeof(SqlBinary));
            table.Columns.Add("imgCar", typeof(SqlBinary));
            table.Columns.Add("idCurso", typeof(int));
            table.Columns.Add("idProfesor", typeof(int));
            table.Columns.Add("notaCurso", typeof(int));
            table.Columns.Add("imgNotaCurso", typeof(SqlBinary));
            table.Columns.Add("fecha", typeof(DateTime));
            table.Columns.Add("telefono", typeof(int));
            table.Columns.Add("anosTEC", typeof(float));
            table.Columns.Add("estado", typeof(int));
            
            //Agregar informacion
            table.Rows.Add((int)temp.cedula, (float)temp.proPonGeneral, (float)temp.proPonSemestral,
                (int)temp.creditosGeneral, (int)temp.creditosSemestre, (int)temp.cuentaBanco, (string)temp.banco, 
                (string)temp.carne, (int)temp.horas, (byte[])temp.imgPpg, (byte[])temp.imgPps, (byte[])temp.imgCg,
                (byte[])temp.imgCs, (byte[])temp.imgCBanco, (byte[])temp.imgCed, (byte[])temp.imgCar, (int)temp.idCurso,
                (int)temp.idProfesor, (int)temp.notaCurso, (byte[])temp.imgNotaCurso, (DateTime)temp.fecha, 
                (int)temp.telefono, (float)temp.anosTEC,(int)temp.estado);
            return table;

        }
        //Wrapper para enviar la informacion sobre otras solicitudes de asistencias en otras areas/escuelas etc
        public DataTable OtrasAsistenciasWrapper(dynamic desc, dynamic horas)
        {
            DataTable table = new DataTable();
            table.Columns.Add("horas", typeof(int));
            table.Columns.Add("descripcion", typeof(string));
            //table.Columns.Add("id", typeof(string));
            int a = 0;
            foreach(string i in desc)
            {
                table.Rows.Add((int)horas[a], i );
                a++;
            }
            return table;
        }
        //Funcion para obtener solicitudes por tipo de solicitud 
        public JObject ObtenerTodasSolicitudesPorTipo(JObject data)
        {
            JObject respuesta = new JObject();
            string tipoSolicitud = (string)data.GetValue("tipoSolicitud");
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            switch (tipoSolicitud)
            {
                case ("HE"):
                    SqlCommand Comando = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando.CommandType = CommandType.StoredProcedure;
                    rowsAffected = Comando.ExecuteNonQuery();
                    break;
                case ("HA"):
                    SqlCommand Comando1 = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando1.CommandType = CommandType.StoredProcedure;
                    rowsAffected = Comando1.ExecuteNonQuery();
                    break;
                case ("AE"):
                    SqlCommand Comando2 = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando2.CommandType = CommandType.StoredProcedure;
                    rowsAffected = Comando2.ExecuteNonQuery();
                    break;
                case ("HT"):
                    SqlCommand Comando3 = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando3.CommandType = CommandType.StoredProcedure;
                    rowsAffected = Comando3.ExecuteNonQuery();
                    break;
            }
            //Se comprueba si el select fue exitoso
            if (rowsAffected !=0 )
            {
                respuesta.Add("Estado", "Exito");
                respuesta.Add("Codigo", 200);
            }
            else
            {
                respuesta.Add("Estado", "Error");
                respuesta.Add("Codigo", 201);
            }
            return respuesta;
        }

        //Funcion para obtener solicitudes por carnet
        public JObject ObtenerTodasSolicitudesPorCarne(JObject data)
        {
            JObject respuesta = new JObject();
            string estado = (string)data.GetValue("estado");
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            switch (estado)
            {
                case ("borrador"):
                    SqlCommand Comando = new SqlCommand("Select_SolicitudesEspecialxCarne_Borrador_UDP", dbConexion);//LLama un Stored Procedur
                    Comando.CommandType = CommandType.StoredProcedure;
                    Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                    rowsAffected = Comando.ExecuteNonQuery();
                    break;
                case ("historial"):
                    SqlCommand Comando1 = new SqlCommand("Select_SolicitudesEspecialxCarne_Historial_UDP", dbConexion);//LLama un Stored Procedur
                    Comando1.CommandType = CommandType.StoredProcedure;
                    Comando1.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                    rowsAffected = Comando1.ExecuteNonQuery();
                    break;
            }
            //Se comprueba si el select fue exitoso
            if (rowsAffected != 0)
            {
                respuesta.Add("Estado", "Exito");
                respuesta.Add("Codigo", 200);
            }
            else
            {
                respuesta.Add("Estado", "Error");
                respuesta.Add("Codigo", 201);
            }
            return respuesta;
        }
    }
}