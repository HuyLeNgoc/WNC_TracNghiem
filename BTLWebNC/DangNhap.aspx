<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" MasterPageFile="~/Layout.Master" Inherits="BTLWebNC.DangNhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <style>
        .login-form-container {
            position: relative;
            align-items: center;
            justify-content: center;
            margin: 10rem 30%;
        }

            .login-form-container form {
                margin: 1rem;
                padding: 1rem 1rem;
                border-radius: .5rem;
                background: #f2f2f2;
            }

                .login-form-container form h3 {
                    font-size: 3rem;
                    color: #444;
                    text-transform: uppercase;
                    text-align: center;
                    padding: 1rem 0;
                }

                .login-form-container form .box {
                    width: 100%;
                    padding: 1rem;
                    font-size: 1.5rem;
                    color: #333;
                    margin: 1rem 0;
                    border: .1rem solid rgba(0, 0, 0, .3);
                    text-transform: none;
                }

                    .login-form-container form .box:focus {
                        border-color: var(--orange);
                    }

                .login-form-container form #remember {
                    margin: 1rem 0;
                }

                .login-form-container form label {
                    font-size: 1.5rem;
                }

                .login-form-container form .btn {
                    display: block;
                    width: 100%;
                }

                .login-form-container form p {
                    font-size: 1.5rem;
                    margin: 0.5rem;
                    padding: 0.6rem;
                    color: #666;
                }

                    .login-form-container form p a {
                        color: var(--orange);
                    }

                        .login-form-container form p a:hover {
                            color: #CC3300;
                            text-decoration: underline;
                        }

        @media (max-width: 768px) {
            .login-form-container{
            margin: 10rem 10%;
        }

}
    </style>
    <div class="login-form-container">
        <form runat="server">
            <h3>Đăng Nhập</h3>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="box" textMode="Email" placeholder="Nhập email" required></asp:TextBox>
            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="box" TextMode="Password" placeholder="Nhập mật khẩu" required></asp:TextBox>
            <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" CssClass="btn" OnClick="DangNhap_click" />
            <asp:CheckBox ID="remember" runat="server" />Nhớ mật khẩu
            <p>Quên mật khẩu ? <a href="#">Lấy lại mật khẩu</a></p>
            <p>Bạn chưa có tài khoản? <a href="DangKy.aspx">Đăng ký</a></p>    
        </form>
    </div>

</asp:Content>
