using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Data.SqlTypes;
using System.Text;

namespace HorasBeca.Solicitudes.api.Models
{
    //Clase Solicitudes
    //Maneja todas las interacciones con la base de datos
    public class Solicitudes
    {
        string connectionString = "";
        int rowsAffected = 0;
        JObject respuesta = new JObject();
        public Solicitudes()
        {
            connectionString = WebConfigurationManager.AppSettings["ConnectionString"];
        }
        //Insertar solicitudes
        public JObject InsertarSolicitud(JObject data)
        {
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
            dbConexion.Close();
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
            table.Columns.Add("carrera", typeof(string));
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
            table.Columns.Add("idCurso", typeof(string));
            table.Columns.Add("idProfesor", typeof(int));
            table.Columns.Add("notaCurso", typeof(int));
            table.Columns.Add("imgNotaCurso", typeof(SqlBinary));
            table.Columns.Add("fecha", typeof(DateTime));
            table.Columns.Add("telefono", typeof(int));
            table.Columns.Add("anosTEC", typeof(float));
            table.Columns.Add("estado", typeof(int));
            
            //Agregar informacion
            table.Rows.Add((int)temp.cedula, (string)temp.carrera, (float)temp.proPonGeneral, (float)temp.proPonSemestral,
                (int)temp.creditosGeneral, (int)temp.creditosSemestre, (int)temp.cuentaBanco, (string)temp.banco, 
                (string)temp.carne, (int)temp.horas, (byte[])temp.imgPpg, (byte[])temp.imgPps, (byte[])temp.imgCg,
                (byte[])temp.imgCs, (byte[])temp.imgCBanco, (byte[])temp.imgCed, (byte[])temp.imgCar, (string)temp.idCurso,
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
        //Conviete los bytes[] a base64 para devolverlo al servidor
        public JObject ByteArrayToBase64(JObject data, string tipo)
        {
            if (tipo == "HE" || tipo=="AE")
            {
                data["cedula_img"] = Convert.ToBase64String((byte[])data.GetValue("cedula_img"));
                data["carne_img"] = Convert.ToBase64String((byte[])data.GetValue("carne_img"));
                data["prom_pond_gen_img"] = Convert.ToBase64String((byte[])data.GetValue("prom_pond_gen_img"));
                data["prom_pond_sem_img"] = Convert.ToBase64String((byte[])data.GetValue("prom_pond_sem_img"));
                data["creds_gen_img"] = Convert.ToBase64String((byte[])data.GetValue("creds_gen_img"));
                data["creds_sem_img"] = Convert.ToBase64String((byte[])data.GetValue("creds_sem_img"));
                data["cuenta_banco_img"] = Convert.ToBase64String((byte[])data.GetValue("cuenta_banco_img"));
            }
            else if (tipo == "HA")
            {
                data["cedula_img"] = Convert.ToBase64String((byte[])data.GetValue("cedula_img"));
                data["carne_img"] = Convert.ToBase64String((byte[])data.GetValue("carne_img"));
                data["prom_pond_gen_img"] = Convert.ToBase64String((byte[])data.GetValue("prom_pond_gen_img"));
                data["prom_pond_sem_img"] = Convert.ToBase64String((byte[])data.GetValue("prom_pond_sem_img"));
                data["creds_gen_img"] = Convert.ToBase64String((byte[])data.GetValue("creds_gen_img"));
                data["creds_sem_img"] = Convert.ToBase64String((byte[])data.GetValue("creds_sem_img"));
                data["cuenta_banco_img"] = Convert.ToBase64String((byte[])data.GetValue("cuenta_banco_img"));
                data["nota_curso_asist_img"] = Convert.ToBase64String((byte[])data.GetValue("nota_curso_asist_img"));
            }
            else if (tipo == "HT")
            {
                data["prom_pond_gen_img"] = Convert.ToBase64String((byte[])data.GetValue("prom_pond_gen_img"));
                data["prom_pond_sem_img"] = Convert.ToBase64String((byte[])data.GetValue("prom_pond_sem_img"));
                data["creds_gen_img"] = Convert.ToBase64String((byte[])data.GetValue("creds_gen_img"));
                data["creds_sem_img"] = Convert.ToBase64String((byte[])data.GetValue("creds_sem_img"));
                data["cuenta_banco_img"] = Convert.ToBase64String((byte[])data.GetValue("cuenta_banco_img"));
                data["cedula_img"] = Convert.ToBase64String((byte[])data.GetValue("cedula_img"));
                data["carne_img"] = Convert.ToBase64String((byte[])data.GetValue("carne_img"));
                data["nota_curso_tut_img"] = Convert.ToBase64String((byte[])data.GetValue("nota_curso_tut_img"));
            }
            return data;

        }
        //Funcion para obtener solicitudes por tipo de solicitud 
        public JObject ObtenerTodasSolicitudesPorTipo(JObject data)
        {
            JArray temp = new JArray();
            var jsonResult = new StringBuilder();
            string tipoSolicitud = (string)data.GetValue("tipoSolicitud");
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            switch (tipoSolicitud)
            {
                case ("HE"):
                    SqlCommand Comando = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando.CommandType = CommandType.StoredProcedure;
                    //Comando almacena el JSON que devolvio la base de datos
                    //.ExecuteReader() permite obtener el contenido de la variable Comando
                    SqlDataReader reader = Comando.ExecuteReader();
                    if (!reader.HasRows)
                    {
                        respuesta.Add("Estado", "Error");
                        respuesta.Add("Codigo", 201);
                    }
                    else
                    {
                        //Se construye un string con los valores del JSON dentro de Comando 
                        //Luego el string es parseado a JSON por medio de un JObject 
                        //El JObject ya se puede manejar con normalidad
                        while (reader.Read())
                        {
                            jsonResult.Append(reader.GetValue(0).ToString());
                        }
                        temp = JArray.Parse(jsonResult.ToString());
                        JArray temp2 = new JArray();
                        foreach (JObject content in temp.Children<JObject>())
                        {
                            temp2.Add(ByteArrayToBase64(content, "HE"));
                        }
                        respuesta = new JObject(
                            new JProperty("Solicitudes", temp2),
                            new JProperty("Codigo", 200),
                            new JProperty("Estado", "Exito")
                        );
                    }
                    reader.Close();
                    break;
                case ("HA"):
                    SqlCommand Comando1 = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando1.CommandType = CommandType.StoredProcedure;
                    //Comando almacena el JSON que devolvio la base de datos
                    //.ExecuteReader() permite obtener el contenido de la variable Comando
                    SqlDataReader reader1 = Comando1.ExecuteReader();
                    if (!reader1.HasRows)
                    {
                        respuesta.Add("Estado", "Error");
                        respuesta.Add("Codigo", 201);
                    }
                    else
                    {
                        //Se construye un string con los valores del JSON dentro de Comando 
                        //Luego el string es parseado a JSON por medio de un JObject 
                        //El JObject ya se puede manejar con normalidad
                        while (reader1.Read())
                        {
                            jsonResult.Append(reader1.GetValue(0).ToString());
                        }
                        temp = JArray.Parse(jsonResult.ToString());
                        JArray temp2 = new JArray();
                        foreach (JObject content in temp.Children<JObject>())
                        {
                            temp2.Add(ByteArrayToBase64(content, "HA"));
                        }
                        respuesta = new JObject(
                            new JProperty("Solicitudes", temp2),
                            new JProperty("Codigo", 200),
                            new JProperty("Estado", "Exito")
                        );
                    }
                    reader1.Close();
                    break;
                case ("AE"):
                    SqlCommand Comando2 = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando2.CommandType = CommandType.StoredProcedure;
                    //Comando almacena el JSON que devolvio la base de datos
                    //.ExecuteReader() permite obtener el contenido de la variable Comando
                    SqlDataReader reader2 = Comando2.ExecuteReader();
                    if (!reader2.HasRows)
                    {
                        respuesta.Add("Estado", "Error");
                        respuesta.Add("Codigo", 201);
                    }
                    else
                    {
                        //Se construye un string con los valores del JSON dentro de Comando 
                        //Luego el string es parseado a JSON por medio de un JObject 
                        //El JObject ya se puede manejar con normalidad
                        while (reader2.Read())
                        {
                            jsonResult.Append(reader2.GetValue(0).ToString());
                        }
                        temp = JArray.Parse(jsonResult.ToString());
                        JArray temp2 = new JArray();
                        foreach (JObject content in temp.Children<JObject>())
                        {
                            temp2.Add(ByteArrayToBase64(content, "AE"));
                        }
                        respuesta = new JObject(
                            new JProperty("Solicitudes", temp2),
                            new JProperty("Codigo", 200),
                            new JProperty("Estado", "Exito")
                        );
                    }
                    reader2.Close();
                    break;
                case ("HT"):
                    SqlCommand Comando3 = new SqlCommand("", dbConexion);//LLama un Stored Procedur
                    Comando3.CommandType = CommandType.StoredProcedure;
                    //Comando almacena el JSON que devolvio la base de datos
                    //.ExecuteReader() permite obtener el contenido de la variable Comando
                    SqlDataReader reader3 = Comando3.ExecuteReader();
                    if (!reader3.HasRows)
                    {
                        respuesta.Add("Estado", "Error");
                        respuesta.Add("Codigo", 201);
                    }
                    else
                    {
                        //Se construye un string con los valores del JSON dentro de Comando 
                        //Luego el string es parseado a JSON por medio de un JObject 
                        //El JObject ya se puede manejar con normalidad
                        while (reader3.Read())
                        {
                            jsonResult.Append(reader3.GetValue(0).ToString());
                        }
                        temp = JArray.Parse(jsonResult.ToString());
                        JArray temp2 = new JArray();
                        foreach (JObject content in temp.Children<JObject>())
                        {
                            temp2.Add(ByteArrayToBase64(content, "HT"));
                        }
                        respuesta = new JObject(
                            new JProperty("Solicitudes", temp2),
                            new JProperty("Codigo", 200),
                            new JProperty("Estado", "Exito")
                        );
                    }
                    reader3.Close();
                    break;
            }
            dbConexion.Close();
            return respuesta;
        }

        //Funcion para obtener solicitudes por carnet
        public JObject ObtenerTodasSolicitudesPorCarne(JObject data)
        {
            JArray temp = new JArray();
            var jsonResult = new StringBuilder();
            string tipoSolicitud = (string)data.GetValue("tipoSolicitud");
            string estado = (string)data.GetValue("estado");
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            switch (tipoSolicitud)
            {
                case ("HT")://Horas Tutor
                    if (estado == "Historial")
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesTuroriaxCarne_Historial_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content, "HT"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesTuroriaxCarne_Borrador_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content, "HT"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    break;
                case ("HE")://Horas Estudiante
                    if (estado == "Historial")
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesEstudiantexCarne_Historial_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content,"HE"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesEstudiantexCarne_Borrador_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content, "HE"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    break;
                case ("AE")://Asistencia Especial
                    if (estado == "Historial")
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesEspecialxCarne_Historial_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content, "AE"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesEspecialxCarne_Borrador_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content, "AE"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    break;
                case ("HA")://Horas Asistente
                    if (estado == "Historial")
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesAsistentexCarne_Historial_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content, "HA"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    else
                    {
                        SqlCommand Comando = new SqlCommand("Select_SolicitudesAsistentexCarne_Borrador_UDP", dbConexion);//LLama un Stored Procedur
                        Comando.CommandType = CommandType.StoredProcedure;
                        Comando.Parameters.Add("@carne", SqlDbType.VarChar).Value = (string)data.GetValue("carne");
                        //Comando almacena el JSON que devolvio la base de datos
                        //.ExecuteReader() permite obtener el contenido de la variable Comando
                        SqlDataReader reader = Comando.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            respuesta.Add("Estado", "Error");
                            respuesta.Add("Codigo", 201);
                        }
                        else
                        {
                            //Se construye un string con los valores del JSON dentro de Comando 
                            //Luego el string es parseado a JSON por medio de un JObject 
                            //El JObject ya se puede manejar con normalidad
                            while (reader.Read())
                            {
                                jsonResult.Append(reader.GetValue(0).ToString());
                            }
                            temp = JArray.Parse(jsonResult.ToString());
                            JArray temp2 = new JArray();
                            foreach (JObject content in temp.Children<JObject>())
                            {
                                temp2.Add(ByteArrayToBase64(content, "HA"));
                            }
                            respuesta = new JObject(
                                new JProperty("Solicitudes", temp2),
                                new JProperty("Codigo", 200),
                                new JProperty("Estado", "Exito")
                            );
                        }
                        reader.Close();
                    }
                    break;
            }
            dbConexion.Close();
            return respuesta;
        }
        //Ejecuta la cancelacion de solictud en las diferentes instancias donde se pueda cancelar 
        public JObject EliminarSolicitud(JObject data)
        {
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Delete_Solicitud_UDP", dbConexion);//LLama un Stored Procedur
            Comando.CommandType = CommandType.StoredProcedure;
            Comando.Parameters.Add("@id_solicitud", SqlDbType.Int).Value = (int)data.GetValue("id");
            rowsAffected = Comando.ExecuteNonQuery();
            if (rowsAffected == 1)
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

        //Ejecuta la cancelacion de solictud en las diferentes instancias donde se pueda cancelar 
        public JObject CambiarEstadoSolicitud(JObject data)
        {
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Update_Estado_Solicitud_UDP", dbConexion);//LLama un Stored Procedur
            Comando.CommandType = CommandType.StoredProcedure;
            Comando.Parameters.Add("@id_solicitud", SqlDbType.Int).Value = (int)data.GetValue("id");
            Comando.Parameters.Add("@id_estado", SqlDbType.Int).Value = (int)data.GetValue("estado");
            Comando.Parameters.Add("@comentario", SqlDbType.VarChar).Value = (string)data.GetValue("comentario");
            rowsAffected = Comando.ExecuteNonQuery();
            if (rowsAffected == 2)
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
        //Actualizar solicitudes 
        public JObject ActualizarSolicitudes(JObject data)
        {

            return respuesta;


        }
     
    }
}