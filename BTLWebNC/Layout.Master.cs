using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTLWebNC
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string html = "";
                if ((bool)Session["login"] == true && (string)Session["email"] == "admin@gmail.com")
                {
                    html += "<a href = '#' class='drop-btn' onclick='dropContentAccount()'>";
                    html += "<i class='fa fa-user' id='login-btn'></i> " + Session["email"] + " <i class='fa-solid fa-caret-down'></i></a>";
                    html += "<div id='dropDownContentAccount' class='dropdown-content-account'>";
                    html += "<a href ='QuanLyUser.aspx' > Quản lý tài khoản </a>";
                    html += "<a href ='QuanLyDeThi.aspx' > Quản lý đề thi </a >";
                    html += "<a href = 'DangXuat.aspx' id='btnDangXuat'> Thoát tài khoản</a ></div > ";

                    account.InnerHtml = html;
                }
                else if ((bool)Session["login"] == true)
                {
                    html += "<a href = '#' class='drop-btn' onclick='dropContentAccount()'>";
                    html += "<i class='fa fa-user' id='login-btn'></i> " + Session["hoTen"] + " <i class='fa-solid fa-caret-down'></i></a>";
                    html += "<div id='dropDownContentAccount' class='dropdown-content-account'>";
                    html += "<a href = QuanLyKetQuaThiUser.aspx?id=" + Session["id"] + " id='btnKetQuaThi' value='Kết quả thi'>Kết quả thi</a> ";
                    html += "<a href = 'DangXuat.aspx' id='btnDangXuat' value='Đăng xuất'>Thoát tài khoản</a > ";
                    html += "</div>";

                    account.InnerHtml = html;
                }
                else
                {
                    html += "<a href='DangNhap.aspx'><i class='fa fa-user' id='login-btn'></i></a>";

                    account.InnerHtml = html;
                }

            }
        }
    }
}