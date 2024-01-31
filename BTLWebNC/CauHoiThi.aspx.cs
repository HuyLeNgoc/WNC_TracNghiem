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
    public partial class CauHoiThi : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        private int IDQueryStr()
        {
            return Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["email"] == "" && (bool)Session["login"] == false)
            {
                Response.Redirect("TrangChu.aspx");
            }

            if (!IsPostBack)
            {
                DanhSachCauHoi();
                using (DataTable dt = DataTableKetQuaThi())
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (Session["id"].ToString() == row["FK_MaNguoiDung"].ToString() && row["sDaLamBai"].ToString() == "1")
                        {
                            string html = "<p>Đã làm bài</p>";
                            dalambai.InnerHtml = html;
                            break;
                        }
                        else
                        {
                            Session["timer"] = DateTime.Now.AddMinutes(Convert.ToDouble(Session["thoiGianLamBai"].ToString()));
                            Session["thoiGianBatDau"] = DateTime.Now;
                            Session.Timeout = 60;
                        }
                    }
                }
            }

            if (Request.Form["btnNopBai"] == "Nộp bài")
            {
                //Session["diemSo"] = tinhDiem();

                DateTime thoiGianKetThuc = DateTime.Now;

                TimeSpan KhoangThoiGian = Convert.ToDateTime(thoiGianKetThuc).Subtract(Convert.ToDateTime(Session["thoiGianBatDau"].ToString()));

                string thoiGianLamBai = KhoangThoiGian.Hours + ":" + KhoangThoiGian.Minutes + ":" + KhoangThoiGian.Seconds;
                SqlParameter[] sqlPars = new SqlParameter[8];

                sqlPars[0] = new SqlParameter("@MaNguoiDung", SqlDbType.Int);
                sqlPars[0].Value = Convert.ToInt32(Session["id"].ToString());
                sqlPars[1] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
                sqlPars[1].Value = IDQueryStr();
                sqlPars[2] = new SqlParameter("@ThoiGianBatDau", SqlDbType.NVarChar);
                sqlPars[2].Value = Session["thoiGianBatDau"].ToString();
                sqlPars[3] = new SqlParameter("@ThoiGianKetThuc", SqlDbType.NVarChar);
                sqlPars[3].Value = thoiGianKetThuc;
                sqlPars[4] = new SqlParameter("@ThoiGianLamBai", SqlDbType.NVarChar);
                sqlPars[4].Value = thoiGianLamBai;
                sqlPars[5] = new SqlParameter("@DiemSo", SqlDbType.Float);
                sqlPars[5].Value = tinhDiem();
                sqlPars[6] = new SqlParameter("@DaLamBai", SqlDbType.VarChar);
                sqlPars[6].Value = 1;
                sqlPars[7] = new SqlParameter("@MaKetQuaThi", SqlDbType.Int);
                sqlPars[7].Direction = ParameterDirection.Output;

                SqlCommand cmd = dBSupport.getCmd_StoredProcedure(sqlPars, "SP_ThemKetQuaThi");
                int maKetQuaThi = Convert.ToInt32(cmd.Parameters["@MaKetQuaThi"].Value.ToString());

                Response.Redirect("KetQuaThi.aspx?id=" + maKetQuaThi);
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

        private DataTable DataTableCauHoiGiamDan()
        {
            SqlParameter[] sqlPars = new SqlParameter[1];
            sqlPars[0] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
            sqlPars[0].Value = IDQueryStr();

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_CauHoi_BaiThi_GiamDan");
            return dt;
        }

        private DataTable DataTableKetQuaThi()
        {
            SqlParameter[] sqlPars = new SqlParameter[0];

            DataTable dt = dBSupport.getDataTable_StoredProcedure(sqlPars, "SP_DanhSachKetQuaThi");
            return dt;
        }
        private void DanhSachCauHoi()
        {
            DataTable dt;
            float id = Convert.ToInt32(Session["id"].ToString()) % 2;
            if (id == 0)
            {
                dt = DataTableCauHoi();
            }
            else
            {
                dt = DataTableCauHoiGiamDan();

            }

            string html = "";
            string htmlMiniBox = "";
            int stt = 1;
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    html += "<div class='box' id='box" + stt + "'>";
                    html += "<div class='question' >";
                    html += "<p><span>" + stt + "</span>" + row["sCauHoi"].ToString() + "</p>";
                    if (row["url_img"].ToString() != "")
                    {
                        html += " <img src = '" + row["url_img"].ToString() + "' alt=''>";
                    }
                    html += "</div>";
                    html += "<div class='answers'>";
                    html += "<input type='hidden' id='idQuestion" + stt + "' name ='idQuestion" + stt + "' value='" + row["PK_MaCauHoi"].ToString() + "'>";
                    html += "<div>";
                    html += "<input type ='radio' name='question" + stt + "' value='A' id='answeraQuestion" + stt + "' runat='server'>";
                    html += "<label for='answeraQuestion" + stt + "'><b>A.</b></label>";
                    html += "<label class='answer-content'>" + row["DapAn_A"].ToString() + "</label>";
                    html += "</div>";
                    html += "<div>";
                    html += "<input type = 'radio' name='question" + stt + "' value='B' id='answerbQuestion" + stt + "' runat='server'>";
                    html += "<label for='answerbQuestion" + stt + "'><b>B.</b></label>";
                    html += "<label class='answer-content'>" + row["dapAn_B"].ToString() + "</label>";
                    html += "</div>";
                    html += "<div>";
                    html += "<input type = 'radio' name='question" + stt + "' value='C' id='answercQuestion" + stt + "' runat='server'>";
                    html += "<label for='answercQuestion" + stt + "'><b>C.</b></label>";
                    html += "<label class='answer-content'>" + row["dapAn_C"].ToString() + "</label>";
                    html += "</div>";
                    html += "<div>";
                    html += "<input type = 'radio' name='question" + stt + "' value='D' id='answerdQuestion" + stt + "' runat='server'>";
                    html += "<label for='answerdQuestion" + stt + "'><b>D.</b></label>";
                    html += "<label class='answer-content'>" + row["dapAn_D"].ToString() + "</label>";
                    html += "</div>";
                    html += "</div>";
                    html += "</div>";

                    htmlMiniBox += "<div class='mini-box' id='mini-box-question" + stt + "'>";
                    htmlMiniBox += "<p>" + stt + "</p>";
                    htmlMiniBox += "</div>";

                    stt++;
                }
                listQuestionExamHtml.InnerHtml = html;

                listMiniBoxQuestions.InnerHtml = htmlMiniBox;
            }

            //Phần cột bên phải

            string htmlBoxExam = "";
            htmlBoxExam += "<p class='name-user' id='name-user'>" + Session["hoTen"].ToString() + "</p>";
            headerBoxExam.InnerHtml = htmlBoxExam;
        }

        private double tinhDiem()
        {

            double diemSoMoiCau = 10 / Convert.ToDouble(Session["soLuongCauHoi"].ToString());
            int stt = 1;

            double tongDiem = 0;

            int soCauHoanThanh = 0;

            int soDapAnDung = 0;

            //Lấy những câu hỏi có cùng một mã đề thi
            DataTable dt = DataTableCauHoi();

            foreach (DataRow row in dt.Rows)
            {
                if (Request.Form["idQuestion" + stt + ""] == row["PK_MaCauHoi"].ToString() && Convert.ToInt32(row["FK_MaBaiThi"].ToString()) == IDQueryStr())
                {
                    if (Request.Form["question" + stt + ""] == "A" || Request.Form["question" + stt + ""] == "B" || Request.Form["question" + stt + ""] == "C" || Request.Form["question" + stt + ""] == "D")
                    {
                        soCauHoanThanh++;
                    }
                    if (Request.Form["question" + stt + ""] == row["dapAn"].ToString())
                    {
                        tongDiem += diemSoMoiCau;
                        soDapAnDung++;
                    }
                    stt++;
                }
            }

            Session["soCauHoanThanh"] = soCauHoanThanh;

            Session["soDapAnDung"] = soDapAnDung;

            return tongDiem;
        }

        //Đếm ngược thời gian làm bài
        protected void timer_tick(object sender, EventArgs e)
        {
            if (DateTime.Compare(DateTime.Now, DateTime.Parse(Session["timer"].ToString())) < 0)
            {
                countdown.Text = ((Int32)DateTime.Parse(Session["timer"].ToString()).Subtract(DateTime.Now).TotalHours).ToString() +
                    ":" + ((Int32)DateTime.Parse(Session["timer"].ToString()).Subtract(DateTime.Now).TotalMinutes).ToString() +
                    ":" + (((Int32)DateTime.Parse(Session["timer"].ToString()).Subtract(DateTime.Now).TotalSeconds) % 60).ToString();
            }
            else
            {

                Session["diemSo"] = tinhDiem();
                Session["idDeThi"] = IDQueryStr();

                Session["thoiGianKetThuc"] = DateTime.Now;

                TimeSpan KhoangThoiGian = Convert.ToDateTime(Session["thoiGianKetThuc"].ToString()).Subtract(Convert.ToDateTime(Session["thoiGianBatDau"].ToString()));

                string thoiGianLamBai = KhoangThoiGian.Hours + ":" + KhoangThoiGian.Minutes + ":" + KhoangThoiGian.Seconds;

                Session["thoiGianLamBai"] = thoiGianLamBai;

                Response.Redirect("KetQuaThi.aspx");
            }

        }
    }
}