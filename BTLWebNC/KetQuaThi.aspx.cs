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
    public partial class KetQuaThi : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["email"] == "" && (bool)Session["login"] == false)
            {
                Response.Redirect("TrangChu.aspx");
            }

            int maKetQuaThi = 0;
            if(Request.QueryString["id"] != null)
            {
                maKetQuaThi = Convert.ToInt32(Request.QueryString["id"].ToString());
            }
            string html = "";
            DataTable dt = DataTableKetQuaThi();
            foreach(DataRow row in dt.Rows)
            {
                if(Convert.ToInt32(row["PK_MaKetQuaThi"].ToString()) == maKetQuaThi)
                {
                    html += "<p class='title-result-exam'>" + row["sTieuDe"].ToString() + "</p>";
                    html += "<div class='result-exam'>";
                    html += "<h3>Điểm số bài thi</h3>";
                    html += "<h2 class='scores-exam'>" + row["fDiemSo"].ToString() + "</h2>";
                    //html += "<p>Số câu hoàn thành:<span>" + Session["soCauHoanThanh"] + "/" + Session["soLuongCauHoi"] + "</span></p>";
                    html += "<p>Số đáp án đúng:<span>" + Session["soDapAnDung"] + "/" + row["iSoLuongCauHoi"].ToString() + "</span></p>";
                    html += "<p>Thời gian làm bài:<span>" + row["sThoiGianLamBai"].ToString() + "</span> </p>";
                    html += "</div>";

                    ketQuaThi.InnerHtml = html;
                    break;
                }
            }

            if (Request.Form["btnThoatBaiThi"] == "Thoát bài thi")
            {
                Response.Redirect("TrangChu.aspx");
            }
        }

        private DataTable DataTableKetQuaThi()
        {
            SqlParameter[] sqlPars = new SqlParameter[0];

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_DanhSachKetQuaThi");
            return dt;
        }
    }
}