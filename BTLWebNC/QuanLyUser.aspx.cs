using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTLWebNC
{
    public partial class QuanLyUser : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["email"] != "admin@gmail.com" && (bool)Session["login"] == false)
            {
                Response.Redirect("TrangChu.aspx");
            }

            //Danh sách người dùng
            SqlParameter[] sqlPars = new SqlParameter[0];

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_DanhSachNguoiDung");

            string html = "";
            html += "<table>";
            html += "<tr>";
            html += "<th>STT</th>";
            html += "<th>Email</th>";
            html += "<th>Họ Tên</th>";
            html += "<th>Kết Quả Thi</th>";
            html += "</tr>";

            int stt = 1;

            foreach (DataRow row in dt.Rows)
            {
                html += "<tr>";
                html += "<td>" + stt + "</td>";
                html += "<td>" + row["sEmail"].ToString() + "</td>";
                html += "<td>" + row["sHoTen"].ToString() + "</td>";
                html += "<form method='post'>";
                html += "<td><button id='btnKetQuaThiUser' class='KetQuaThiUser' name='btnKetQuaThiUser' value='" + row["PK_MaNguoiDung"].ToString() + "'>Xem</button></td>";
                html += "</form>";
                html += "</tr>";

                stt++;
            }

            html += "</table>";
            tableUsers.InnerHtml = html;

            foreach (DataRow row in dt.Rows)
            {
                if (Request.Form["btnKetQuaThiUser"] == row["PK_MaNguoiDung"].ToString())
                {
                    Session["adminXemKetQuaThiUser"] = true;
                    Response.Redirect("QuanLyKetQuaThiUser.aspx?id=" + row["PK_MaNguoiDung"].ToString());
                }
            }
        }
    }
}