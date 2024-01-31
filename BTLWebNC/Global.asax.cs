using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace BTLWebNC
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["login"] = false;
            Session["id"] = "";
            Session["email"] = "";
            Session["hoTen"] = "";
            Session["matKhau"] = "";

            Session["DangNhapLamBaiThi"] = false;

            Session["timer"] = "";

            Session["idDeThi"] = "";
            Session["tieuDe"] = "";
            Session["soLuongCauHoi"] = "";
            Session["thoiGianLamBai"] = "";
            Session["loaiBaiThi"] = "";
            Session["maCaThi"] = "";

            Session["thoiGianBatDau"] = "";
            Session["thoiGianKetThuc"] = "";
            Session["diemSo"] = "";

            Session["soCauHoanThanh"] = "";
            Session["soDapAnDung"] = "";

            Session["soLuongCauHoiDaThem"] = "";

            Session["adminXemNhungNguoiDaLamBaiThi"] = false;
            Session["adminXemKetQuaThiUser"] = false;

            Session["soCauHoiChuaLam"] = "";

            Session["thongBaoXoa"] = "";
            Session["idNguoiLamBaiThi"] = "";
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}