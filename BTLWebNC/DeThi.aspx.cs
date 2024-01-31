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
    public partial class DeThi : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        private int IDQueryStr()
        {
            return Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ThongTinBaiThi();
            }
        }

        private void ThongTinBaiThi()
        {
            DataTable dt = DataTableBaiThi();
            string htmlTitleExam = "";
            string htmlExamCode = "";

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    htmlTitleExam += "<h2>" + row["sTieuDe"].ToString() + "</h2>";
                    htmlTitleExam += "<p class='border-bottom'>Ngày tạo: " + row["dNgayTao"].ToString() + "</p>";
                    if (row["sMaCaThi"].ToString() != "")
                    {
                        htmlExamCode += "<input type='text' name='examCode' class='box' placeholder='Nhập mã ca thi' runat='server' required>";
                        examCode.InnerHtml = htmlExamCode;
                    }
                }
            }

            title.InnerHtml = htmlTitleExam;
        }

        private DataTable DataTableBaiThi()
        {
            SqlParameter[] sqlPars = new SqlParameter[1];
            sqlPars[0] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
            sqlPars[0].Value = IDQueryStr();

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_TimBaiThi");
            return dt;
        }

        protected void BatDauThi(object sender, EventArgs e)
        {
            int soLuongCauHoi = 0;
            int thoiGianLamBai = 0;
            string maCaThi = "";
            DataTable dt = DataTableBaiThi();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    soLuongCauHoi = Convert.ToInt32(row["iSoLuongCauHoi"].ToString());
                    thoiGianLamBai = Convert.ToInt32(row["iThoiGianLamBai"].ToString());
                    maCaThi = row["sMaCaThi"].ToString();
                }
            }

            if (maCaThi != "")
            {
                if (Request.Form["examCode"] == maCaThi)
                {
                    Session["soLuongCauHoi"] = soLuongCauHoi;
                    Session["thoiGianLamBai"] = thoiGianLamBai;

                    if ((bool)Session["login"] == true)
                    {
                        Response.Redirect("CauHoiThi.aspx?id=" + IDQueryStr());
                    }
                    else
                    {
                        Session["DangNhapLamBaiThi"] = true;
                        Session["idDeThi"] = IDQueryStr();
                        Response.Redirect("DangNhap.aspx");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Mã ca thi không chính xác!');</script>");
                }
            }
            else
            {
                Session["soLuongCauHoi"] = soLuongCauHoi;
                Session["thoiGianLamBai"] = thoiGianLamBai;

                if ((bool)Session["login"] == true)
                {
                    Response.Redirect("CauHoiThi.aspx?id=" + IDQueryStr());
                }
                else
                {
                    Session["DangNhapLamBaiThi"] = true;
                    Session["idDeThi"] = IDQueryStr();
                    Response.Redirect("DangNhap.aspx");
                }
            }
        }

        protected void QuayLai(object sender, EventArgs e)
        {
            Response.Redirect("TrangChu.aspx");
        }
    }
}