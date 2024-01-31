using Newtonsoft.Json;
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
    public partial class QuanLyDeThi : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["email"] != "admin@gmail.com" && (bool)Session["login"] == false)
            {
                Response.Redirect("TrangChu.aspx");
            }

            if (!IsPostBack)
            {
                DanhSachDeThi();
            }

            using (DataTable dt = DataTableBaiThi())
            {
                foreach (DataRow row in dt.Rows)
                {
                    if(Request.Form["btnDaLamBai"] == row["PK_MaBaiThi"].ToString())
                    {
                        Session["adminXemNhungNguoiDaLamBaiThi"] = true;
                        Response.Redirect("QuanLyKetQuaThiUser.aspx?id=" + row["PK_MaBaiThi"].ToString());
                    }
                }
            }

                int maBaiThi = 0;

            if (Request.QueryString["xoaid"] != null)
            {
                maBaiThi = Convert.ToInt32(Request.QueryString["xoaid"].ToString());
                if (maBaiThi != 0)
                {
                    SqlParameter[] sqlPar = new SqlParameter[1];
                    sqlPar[0] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
                    sqlPar[0].Value = maBaiThi;
                    dBSupport.getCmd_StoredProcedure(sqlPar, "SP_XoaBaiThi");
                    //html += "<p id='success'> Xóa thành công</p>";
                    using (DataTable dt = DataTableBaiThi())
                    {
                        if (dt.Rows.Count > 0)
                        {
                            try
                            {
                                string json = JsonConvert.SerializeObject(dt);
                                Response.Clear();
                                Response.Write(json);
                                HttpContext.Current.Response.Flush(); 
                                HttpContext.Current.Response.SuppressContent = true;
                                HttpContext.Current.ApplicationInstance.CompleteRequest();
                            }
                            catch(Exception ex)
                            {
                                Response.Write(ex.Message);
                            }
                        }
                        else
                        {
                            string json = "no data";
                            Response.Clear();
                            Response.Write(json);
                            Response.End();
                        }
                    }

                }
            }
        }

        private DataTable DataTableBaiThi()
        {
            SqlParameter[] sqlPars = new SqlParameter[0];

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_DanhSachBaiThi");
            return dt;
        }

        private void DanhSachDeThi()
        {
            string html = "";
            html += "<table>";
            html += "<tr>";
            html += "<th>STT</th>";
            html += "<th>Tiêu Đề</th>";
            html += "<th>Ngày Tạo</th>";
            html += "<th>Số Lượng Câu Hỏi</th>";
            html += "<th>Đã thêm</th>";
            html += "<th>Thời Gian Làm Bài (Phút)</th>";
            html += "<th>Loại Bài Thi</th>";
            html += "<th>Mã Ca Thi</th>";
            html += "<th></th>";
            html += "<th></th>";
            html += "<th></th>";
            html += "</tr>";

            int stt = 1;
            using (DataTable dt = DataTableBaiThi())
            {
                foreach (DataRow row in dt.Rows)
                {
                    html += "<tr>";
                    html += "<td> " + stt + " </td>";
                    html += "<td> " + row["sTieuDe"].ToString() + " </td>";
                    html += "<td> " + row["dNgayTao"].ToString() + " </td>";
                    html += "<td> " + row["iSoLuongCauHoi"].ToString() + " </td>";
                    if (row["iSoLuongCauHoi"].ToString() == row["iSoCauHoiDaThem"].ToString())
                    {
                        html += "<td style='color:green;'> " + row["iSoCauHoiDaThem"].ToString() + "/"+ row["iSoLuongCauHoi"].ToString() + " </td>";
                    }
                    else
                    {
                        html += "<td style='color:red;'> " + row["iSoCauHoiDaThem"].ToString() + "/" + row["iSoLuongCauHoi"].ToString() + "</td>";
                    }
                    html += "<td> " + row["iThoiGianLamBai"].ToString() + " </td>";
                    html += "<td> " + row["sMoTaChung"].ToString() + " </td>";
                    html += "<td> " + row["sMaCaThi"].ToString() + " </td>";
                    html += "<td>";
                    html += "<button id='btnDaLamBai' name='btnDaLamBai' value='"+row["PK_MaBaiThi"].ToString()+"'>Những người đã làm</button></td>";
                    html += "<td>";
                    html += "<a id='btnChiTiet' name='btnChiTiet' href='QuanLyCauHoiDeThi.aspx?id=" + row["PK_MaBaiThi"].ToString() + "'>Chi tiết</a></td>";
                    html += "<td>";
                    html += "<button id='btnXoaDeThi' type='button' onclick='return toastXoa(" + row["PK_MaBaiThi"].ToString() + ")' name='btnXoaDeThi' value='" + row["PK_MaBaiThi"].ToString() + "'>Xóa</button></td>";
                    html += "</tr>";

                    stt++;
                }
                html += "</table>";
            }
            //HttpUtility.HtmlEncode(html);
            listExam.InnerHtml = html;
        }

        //private void DanhSachDeThi()
        //{
        //    using (DataTable dt = DataTableBaiThi())
        //    {
        //        gdvBaiThi.DataSource = dt;
        //        gdvBaiThi.DataBind();
        //    }
        //}

        //protected void TaoDeThi(object sender, EventArgs e)
        //{
        //    SqlParameter[] sqlPar = new SqlParameter[7];
        //    sqlPar[0] = new SqlParameter("@TieuDe", SqlDbType.NVarChar);
        //    sqlPar[0].Value = txtTieuDe.Text;
        //    sqlPar[1] = new SqlParameter("@NgayTao", SqlDbType.DateTime);
        //    sqlPar[1].Value = DateTime.Now;
        //    sqlPar[2] = new SqlParameter("@SoLuongCauHoi", SqlDbType.Int);
        //    sqlPar[2].Value = txtSoLuongCauHoi.Text;
        //    sqlPar[3] = new SqlParameter("@ThoiGianLamBai", SqlDbType.Int);
        //    sqlPar[3].Value = txtThoiGianLamBai.Text;
        //    sqlPar[4] = new SqlParameter("@MoTaChung", SqlDbType.NVarChar);
        //    sqlPar[4].Value = txtMoTaChung.Text;
        //    sqlPar[5] = new SqlParameter("@MaCaThi", SqlDbType.NVarChar);
        //    sqlPar[5].Value = txtMaCaThi.Text;
        //    sqlPar[6] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
        //    sqlPar[6].Direction = ParameterDirection.Output;

        //    dBSupport.getCmd_StoredProcedure(sqlPar, "SP_ThemBaiThi");
        //    Response.Write("<script>alert('Thêm bài thi thành công!');</script>");
        //    Page.Response.Redirect(Page.Request.Url.ToString(), true);
        //    Response.End();

        //}

        //protected void XoaBaiThi(object sender, GridViewDeleteEventArgs e)
        //{
        //    SqlParameter[] sqlPar = new SqlParameter[1];
        //    sqlPar[0] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
        //    sqlPar[0].Value = gdvBaiThi.Rows[e.RowIndex].Cells[0].Text;
        //    try
        //    {
        //        //string html = "";
        //        dBSupport.getCmd_StoredProcedure(sqlPar, "SP_XoaBaiThi");
        //        //Session["thongBaoXoa"] = "success";
        //        //html += "<p id='success'> Xóa thành công</p>";
        //        //Response.Clear();
        //        //Response.Write(html);

        //        Response.Write("<script>alert('Xóa bài thi thành công!');</script>");
        //        Page.Response.Redirect(Page.Request.Url.ToString(), true);
        //        Response.End();

        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write(ex.Message);
        //        //Session["thongBaoXoa"] = "fail";
        //    }

        //}

        //protected void gdvBaiThi_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName.Equals("dalambai"))
        //    {
        //        int id = Convert.ToInt32(e.CommandArgument);
        //        Session["adminXemNhungNguoiDaLamBaiThi"] = true;
        //        Response.Redirect("QuanLyKetQuaThiUser.aspx?id=" + id);
        //    }
        //}
    }
}