using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTLWebNC
{
    public partial class QuanLyCauHoiDeThi : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();

        private int IDQueryStr()
        {
            return Convert.ToInt32(Request.QueryString["id"].ToString());
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["email"] != "admin@gmail.com" && (bool)Session["login"] == false)
            {
                Response.Redirect("TrangChu.aspx");
            }

            if (!IsPostBack)
            {
                ThongTinBaiThi();
                DanhSachCauHoi();
            }
        }

        private void ThongTinBaiThi()
        {
            SqlParameter[] sqlPars = new SqlParameter[1];

            sqlPars[0] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
            sqlPars[0].Value = IDQueryStr();

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_TimBaiThi");
            string htmlTitleExam = "";

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    htmlTitleExam += "<h3>" + row["sTieuDe"].ToString() + "</h3>";
                    htmlTitleExam += "<p>Số lượng câu hỏi : <span>" + row["iSoLuongCauHoi"].ToString() + "</span></p>";
                    htmlTitleExam += "<p>Thời gian làm bài : <span>" + row["iThoiGianLamBai"].ToString() + " phút</span></p>";
                    htmlTitleExam += "<p>Mô tả chung : <span>" + row["sMoTaChung"].ToString() + "</span></p>";
                    Session["soLuongCauHoi"] = row["iSoLuongCauHoi"].ToString();
                }
            }
            else
            {
                Response.Write("<script>alert('Không tìm thấy');</script>");
            }
            titleExam.InnerHtml = htmlTitleExam;
        }

        protected void ThemCauHoi(object sender, EventArgs e)
        {
            if (Convert.ToInt32(Session["soLuongCauHoiDaThem"].ToString()) < Convert.ToInt32(Session["soLuongCauHoi"].ToString()))
            {
                DataTable dt = DataTableCauHoi();
                bool trung = false; //Kiểm tra câu hỏi đã tồn tại hay chưa
                foreach (DataRow row in dt.Rows)
                {
                    if (txtCauHoi.Text == row["sCauHoi"].ToString() && txtDapAnA.Text == row["DapAn_A"].ToString() && txtDapAnB.Text == row["dapAn_B"].ToString()
                        && txtDapAnC.Text == row["dapAn_C"].ToString() && txtDapAnD.Text == row["dapAn_D"].ToString())
                    {
                        trung = true;
                        break;
                    }
                }
                if (trung)
                {
                    Response.Write("<script>alert('Câu hỏi đã tồn tại!');</script>");
                }
                else
                {
                    SqlParameter[] sqlPar = new SqlParameter[8];
                    sqlPar[0] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
                    sqlPar[0].Value = IDQueryStr();
                    sqlPar[1] = new SqlParameter("@CauHoi", SqlDbType.NVarChar);
                    sqlPar[1].Value = txtCauHoi.Text;
                    sqlPar[2] = new SqlParameter("@url_img", SqlDbType.NVarChar);
                    if (imgCauHoi.HasFile)
                    {
                        try
                        {
                            string ImageName = "~/Images/" + DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + imgCauHoi.PostedFile.FileName;
                            string filePath = Server.MapPath(ImageName);
                            imgCauHoi.SaveAs(filePath);
                            sqlPar[2].Value = ImageName;
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<script>alert('Đã xảy ra lỗi không thể tải file lên! " + ex.Message + "');</script>");
                        }
                    }
                    else
                    {
                        sqlPar[2].Value = "";
                    }
                    sqlPar[3] = new SqlParameter("@DapAn_A", SqlDbType.NVarChar);
                    sqlPar[3].Value = txtDapAnA.Text;
                    sqlPar[4] = new SqlParameter("@dapAn_B", SqlDbType.NVarChar);
                    sqlPar[4].Value = txtDapAnB.Text;
                    sqlPar[5] = new SqlParameter("@dapAn_C", SqlDbType.NVarChar);
                    sqlPar[5].Value = txtDapAnC.Text;
                    sqlPar[6] = new SqlParameter("@dapAn_D", SqlDbType.NVarChar);
                    sqlPar[6].Value = txtDapAnD.Text;
                    sqlPar[7] = new SqlParameter("@dapAn", SqlDbType.NVarChar);
                    sqlPar[7].Value = ddlDapAnDung.SelectedValue;

                    dBSupport.getCmd_StoredProcedure(sqlPar, "SP_ThemCauHoi");
                    Page.Response.Redirect(Page.Request.Url.ToString(), true);
                    Response.End();
                }
            }
            else
            {
                Response.Write("<script>alert('Đã thêm đủ số câu hỏi!');</script>");
            }
        }

        private DataTable DataTableCauHoi()
        {
            SqlParameter[] sqlPars = new SqlParameter[1];
            sqlPars[0] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
            sqlPars[0].Value = IDQueryStr();

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_CauHoi_BaiThi");
            return dt;
        }

        private void DanhSachCauHoi()
        {
            using (DataTable dt = DataTableCauHoi())
            {
                Session["soLuongCauHoiDaThem"] = dt.Rows.Count;
                gdvCauHoi.DataSource = dt;
                gdvCauHoi.DataBind();
            }
        }

        private void XoaAnhCauHoi(int maCauHoi)
        {
            SqlParameter[] sqlPar = new SqlParameter[1];
            sqlPar[0] = new SqlParameter("@MaCauHoi", SqlDbType.Int);
            sqlPar[0].Value = maCauHoi;
            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPar, "SP_TimCauHoi");

            foreach (DataRow row in dt.Rows)
            {
                if (row["url_img"].ToString() != "")
                {
                    string filePath = Server.MapPath(row["url_img"].ToString());
                    FileInfo file = new FileInfo(filePath);
                    file.Delete();
                }
                else continue;
            }
        }

        protected void XoaCauHoi(object sender, GridViewDeleteEventArgs e)
        {
            int maCauHoi = Convert.ToInt32(gdvCauHoi.Rows[e.RowIndex].Cells[0].Text);
            SqlParameter[] sqlPar = new SqlParameter[1];
            sqlPar[0] = new SqlParameter("@MaCauHoi", SqlDbType.Int);
            sqlPar[0].Value = maCauHoi;
            try
            {
                XoaAnhCauHoi(maCauHoi);
                dBSupport.getCmd_StoredProcedure(sqlPar, "SP_XoaCauHoi");
                Response.Write("<script>alert('Xóa câu hỏi thành công!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            DanhSachCauHoi();

        }
    }
}