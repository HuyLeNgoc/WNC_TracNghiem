using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTLWebNC
{
    public partial class DangNhap : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((bool)Session["DangNhapLamBaiThi"] == true)
            {
                Response.Write("<script>alert('Vui lòng đăng nhập để làm bài thi!');</script>");
            }

        }

        protected void DangNhap_click(object sender, EventArgs e)
        {
            SqlParameter[] sqlPars = new SqlParameter[2];

            sqlPars[0] = new SqlParameter("@Email", SqlDbType.VarChar);
            sqlPars[0].Value = txtEmail.Text;
            sqlPars[1] = new SqlParameter("@MatKhau", SqlDbType.NVarChar);
            sqlPars[1].Value = GetMD5(txtMatKhau.Text.Trim());

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_DangNhap");

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    Session["login"] = true;
                    Session["id"] = row["PK_MaNguoiDung"].ToString();
                    Session["hoTen"] = row["sHoTen"].ToString();
                    Session["email"] = row["sEmail"].ToString();
                    Session.Timeout = 60;
                }

                if ((bool)Session["DangNhapLamBaiThi"] == true && (bool)Session["login"] == true)
                {
                    Response.Redirect("CauHoiThi.aspx?id=" + Session["idDeThi"]);
                }

                Session["DangNhapLamBaiThi"] = false;

                if ((bool)Session["login"] == true)
                {
                    Response.Redirect("TrangChu.aspx");
                }
            }
            else
            {
                Response.Write("<script>alert('Không tìm thấy');</script>");
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