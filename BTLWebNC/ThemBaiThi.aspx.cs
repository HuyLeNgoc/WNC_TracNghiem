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
    public partial class ThemBaiThi : System.Web.UI.Page
    {
        DBSupport dBSupport = new DBSupport();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["email"] != "admin@gmail.com" && (bool)Session["login"] == false)
            {
                Response.Redirect("TrangChu.aspx");
            }
        }

        protected void TaoDeThi(object sender, EventArgs e)
        {
            SqlParameter[] sqlPar = new SqlParameter[8];
            sqlPar[0] = new SqlParameter("@TieuDe", SqlDbType.NVarChar);
            sqlPar[0].Value = txtTieuDe.Text;
            sqlPar[1] = new SqlParameter("@NgayTao", SqlDbType.DateTime);
            sqlPar[1].Value = DateTime.Now;
            sqlPar[2] = new SqlParameter("@SoLuongCauHoi", SqlDbType.Int);
            sqlPar[2].Value = txtSoLuongCauHoi.Text;
            sqlPar[3] = new SqlParameter("@ThoiGianLamBai", SqlDbType.Int);
            sqlPar[3].Value = txtThoiGianLamBai.Text;
            sqlPar[4] = new SqlParameter("@MoTaChung", SqlDbType.NVarChar);
            sqlPar[4].Value = txtMoTaChung.Text;
            sqlPar[5] = new SqlParameter("@MaCaThi", SqlDbType.NVarChar);
            sqlPar[5].Value = txtMaCaThi.Text;
            sqlPar[6] = new SqlParameter("@SoCauHoiDaThem", SqlDbType.NVarChar);
            sqlPar[6].Value = 0; 
            sqlPar[7] = new SqlParameter("@MaBaiThi", SqlDbType.Int);
            sqlPar[7].Direction = ParameterDirection.Output;

            dBSupport.getCmd_StoredProcedure(sqlPar, "SP_ThemBaiThi");
            Response.Redirect("QuanLyDeThi.aspx");

        }
    }
}