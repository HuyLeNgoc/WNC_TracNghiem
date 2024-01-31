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
    public partial class TrangChu : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DanhSachDeThi();
            }
        }

        private void DanhSachDeThi()
        {
            DataTable dt = DataTableBaiThi();

            string html = "";
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if(row["iSoLuongCauHoi"].ToString() == row["iSoCauHoiDaThem"].ToString())
                    {
                        html += "<div class='box'>";
                        html += "<div class='title'>";
                        html += "<a href = DeThi.aspx?id=" + row["PK_MaBaiThi"].ToString() + ">";
                        html += "<h3>" + row["sTieuDe"].ToString() + "</h3>";
                        html += "</a>";
                        html += "<br>";
                        html += "<p>" + row["dNgayTao"].ToString() + "</p>";
                        html += "</div>";
                        html += "<div class='details'>";
                        html += "<ul>";
                        html += "<li>Số lượng câu hỏi : <span>" + row["iSoLuongCauHoi"].ToString() + "</span></li>";
                        html += "<li>Thời gian làm bài : <span>" + row["iThoiGianLamBai"].ToString() + " phút</span></li>";
                        html += "<li>Mô tả chung : <span>" + row["sMoTaChung"].ToString() + "</span></li>";
                        html += "</ul>";
                        html += "</div>";
                        html += "<form method='post'>";
                        html += "<button class='detail-btn' id='btnChiTietDeThi' name='btnChiTietDeThi' value='" + row["PK_MaBaiThi"].ToString() + "'>Chi tiết<i class='fa-solid fa-angles-right'></i></button>";
                        html += "</form>";
                        html += "</div>";
                    }  
                }
                listExamHomePage.InnerHtml = html;
            }
            foreach (DataRow row in dt.Rows)
            {
                if (Request.Form["btnChiTietDeThi"] == row["PK_MaBaiThi"].ToString())
                {
                    Response.Redirect("DeThi.aspx?id=" + row["PK_MaBaiThi"].ToString());
                }
            }
        }

        private DataTable DataTableBaiThi()
        {
            SqlParameter[] sqlPars = new SqlParameter[0];

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_DanhSachBaiThi");
            return dt;
        }
    }
}