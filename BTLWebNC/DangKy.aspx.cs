using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;

namespace BTLWebNC
{
    public partial class DangKy : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DangKy_click(object sender, EventArgs e)
        {
            SqlParameter[] sqlPars = new SqlParameter[4];

            sqlPars[0] = new SqlParameter("@Email", SqlDbType.VarChar);
            sqlPars[0].Value = txtEmail.Text;
            sqlPars[1] = new SqlParameter("@HoTen", SqlDbType.NVarChar);
            sqlPars[1].Value = txtHoTen.Text;
            sqlPars[2] = new SqlParameter("@MatKhau", SqlDbType.VarChar);
            sqlPars[2].Value = GetMD5(txtMatKhau.Text.Trim());
            sqlPars[3] = new SqlParameter("@status", SqlDbType.Int);
            sqlPars[3].Direction = ParameterDirection.Output;

            SqlCommand cmd = dBSupport.getCmd_StoredProcedure(sqlPars, "SP_DangKy");
            int status = Convert.ToInt32(cmd.Parameters["@status"].Value.ToString()); 
            
            if (status == 1)
            {
                Response.Write("<script>alert('Đăng ký thành công');</script>");
                Response.Redirect("DangNhap.aspx");
            }
            else if (status == 0)
            {
                Response.Write("<script>alert('Tài khoản đã tồn tại');</script>");
            }
            else
            {
                Response.Write("<script>alert('Thất bại');</script>");
            }
        }

        public static string GetMD5(string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = Encoding.UTF8.GetBytes(str);
            byte[] targetData = md5.ComputeHash(fromData);
            string byte2String = null;

            for (int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x2");

            }
            return byte2String;
        }
    }
}