using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;

namespace WebApplication1.Models
{
    public class Configuraciones
    {
        string connectionString = "";
        int rowsAffected = 0;
        JObject respuesta = new JObject();
        public Configuraciones()
        {
            connectionString = WebConfigurationManager.AppSettings["ConnectionString"];
        }

        public JObject AbrirPeriodo(JObject data)
        {
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Insert_Perido_Activo_UDP", dbConexion);//LLama un Stored Procedur
            Comando.CommandType = CommandType.StoredProcedure;
            Comando.Parameters.Add("@Fecha_inicio", SqlDbType.DateTime).Value = (DateTime)data.GetValue("fecha_inicio");
            Comando.Parameters.Add("@Fecha_cierre", SqlDbType.DateTime).Value = (DateTime)data.GetValue("fecha_cierre");
            Comando.Parameters.Add("@Fecha_envio", SqlDbType.DateTime).Value = (DateTime)data.GetValue("fecha_envio");
            Comando.Parameters.Add("@Num_max_horas", SqlDbType.DateTime).Value = (DateTime)data.GetValue("horas");
            Comando.Parameters.Add("@Fecha_inicio_EVAL", SqlDbType.DateTime).Value = (DateTime)data.GetValue("fecha_envio_eval");
            Comando.Parameters.Add("@Fecha_cierre_EVAL", SqlDbType.DateTime).Value = (DateTime)data.GetValue("fecha_cierre_eval");
            rowsAffected = Comando.ExecuteNonQuery();
            dbConexion.Close();
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

        public JObject CerrarPeriodo(JObject data)
        {
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Delete_Perido_Activo_UDP", dbConexion);//LLama un Stored Procedur
            Comando.CommandType = CommandType.StoredProcedure;
            rowsAffected = Comando.ExecuteNonQuery();
            dbConexion.Close();
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

        public JObject ExtenderPerido(JObject data)
        {
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Select_Perido_Activo_UDP", dbConexion);//LLama un Stored Procedur
            Comando.Parameters.Add("@ID_periodo", SqlDbType.DateTime).Value = (DateTime)data.GetValue("id_periodo");
            Comando.Parameters.Add("@Fecha_cierre", SqlDbType.DateTime).Value = (DateTime)data.GetValue("fecha_cierre");
            Comando.CommandType = CommandType.StoredProcedure;
            rowsAffected = Comando.ExecuteNonQuery();
            dbConexion.Close();
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

        public JObject ObtenerPeriodo()
        {
            JArray temp = new JArray();
            var jsonResult = new StringBuilder();
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Select_Perido_Activo_UDP", dbConexion);//LLama un Stored Procedur
            Comando.CommandType = CommandType.StoredProcedure;
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
                respuesta = new JObject(
                    new JProperty("Periodo", temp),
                    new JProperty("Codigo", 200),
                    new JProperty("Estado", "Exito")
                );
            }
            dbConexion.Close();
            reader.Close();
            return respuesta;
        }

        public JObject ObtenerTodosPeriodos()
        {
            JArray temp = new JArray();
            var jsonResult = new StringBuilder();
            SqlConnection dbConexion = new SqlConnection(connectionString);
            dbConexion.Open();
            SqlCommand Comando = new SqlCommand("Select_Peridos_UDP", dbConexion);//LLama un Stored Procedur
            Comando.CommandType = CommandType.StoredProcedure;
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
                respuesta = new JObject(
                    new JProperty("Periodos", temp),
                    new JProperty("Codigo", 200),
                    new JProperty("Estado", "Exito")
                );
            }
            dbConexion.Close();
            reader.Close();
            return respuesta;
        }
    }
}