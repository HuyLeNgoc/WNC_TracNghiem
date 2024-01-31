using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BTLWebNC
{
    public class DBSupport
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        public SqlCommand getCmd_StoredProcedure(SqlParameter[] sqlParameters, string spName)
        {
            SqlCommand cmd;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "" + spName + "";
                    foreach (SqlParameter sqlParameter in sqlParameters)
                    {
                        cmd.Parameters.Add(sqlParameter);
                    }
                    conn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }

                    //status = (int)cmd.ExecuteScalar();
                    conn.Close();
                }
            }
            return cmd;
        }

        public DataTable getDataTable_StoredProcedure(SqlParameter[] sqlParameters, string spName)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "" + spName + "";
                    foreach (SqlParameter sqlParameter in sqlParameters)
                    {
                        cmd.Parameters.Add(sqlParameter);
                    }
                    conn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.SelectCommand = cmd;
                            da.Fill(dt);  // đổ dữ liệu vào kho
                        }

                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                    conn.Close();
                }
            }
            return dt;
        }





    }
}