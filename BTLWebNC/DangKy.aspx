<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="DangKy.aspx.cs" Inherits="BTLWebNC.DangKy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .register-form-container {
            position: relative;
            align-items: center;
            justify-content: center;
            margin: 10rem 30%;
        }

            .register-form-container form {
                margin: 1rem;
                padding: 1rem 1rem;
                border-radius: .5rem;
                background: #fff;
                border-left: .5rem solid #f2f2f2;
                background: #f2f2f2;
            }

                .register-form-container form h3 {
                    font-size: 3rem;
                    color: #444;
                    text-transform: uppercase;
                    text-align: center;
                    padding: 1rem 0;
                }

                .register-form-container form .box {
                    width: 100%;
                    padding: 1rem;
                    font-size: 1.5rem;
                    color: #333;
                    margin: 1rem 0;
                    border: .1rem solid rgba(0, 0, 0, .3);
                    text-transform: none;
                }

                    .register-form-container form .box:focus {
                        border-color: var(--orange);
                    }

                .register-form-container form label {
                    font-size: 1.5rem;
                }

                .register-form-container form .btn {
                    display: block;
                    width: 100%;
                }

@media (max-width: 768px){
    .register-form-container {
            margin: 10rem 10%;
        }
}

    </style>
    <div class="register-form-container">
        <form runat="server">
            <h3>Đăng kí</h3>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="box" textMode="Email" placeholder="Nhập email" required></asp:TextBox>
            <asp:TextBox ID="txtHoTen" runat="server" CssClass="box" placeholder="Nhập họ tên" required></asp:TextBox>
            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="box" TextMode="Password" placeholder="Nhập mật khẩu" required></asp:TextBox>
            <input type="password" id="txtMatKhau2" name="txtMatKhau2" class="box"
                placeholder="Nhập lại mật khẩu của bạn" required>
            <asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" CssClass="btn" OnClick="DangKy_click" OnClientClick="return check()"/>
        </form>
    </div>

    <script>

        function check() {
            let txtEmail = document.getElementById("<%= txtEmail.ClientID %>");
            let txtMatKhau = document.getElementById("<%= txtMatKhau.ClientID %>");

            if (txtEmail.value.includes(".com") == false) {
                alert("Vui lòng nhập đúng email của bạn (vd: nguyenvana@gmail.com)");
                txtEmail.focus();
                return false;
            }

            if (txtMatKhau.value.length < 6) {
                alert("Mật khẩu phải hơn 6 ký tự");
                return false;
            }
            if (document.getElementById("txtMatKhau2").value != txtMatKhau.value) {
                alert("Mật khẩu nhập lại không trùng với mật khẩu ! Vui lòng nhập lại");
                document.getElementById("txtMatKhau2").focus();
                return false;
            }
        }


                //0 - 9: 48 - 57
        //A - Z: 65 - 90
        //a - z: 97 - 122
        //function checkUppercase(str) {
        //    for (var i = 0; i < str.length; i++) {
        //        if (str.charAt(i) == str.charAt(i).toUpperCase() && str.charAt(i).match(/[a-z]/i)) {
        //            return true;
        //        }
        //    }
        //    return false;
        //};

                    //if (txtPass.charAt(0).match(/[a-z]/i) == null) {
            //    alert("Mật khẩu phải bắt đầu bằng chữ hoa!");
            //    return false;
            //}
            //if (txtPass.charAt(0) != txtPass.charAt(0).toUpperCase()) {
            //    alert("Mật khẩu phải bắt đầu bằng chữ hoa !");
            //    return false;
            //}
            //if (txtPass.charAt(txtPass.length - 1).match(/[0-9]/g) == null) {
            //    alert("Mật khẩu phải kết thúc bằng chữ số !");
            //    return false;
            //}
    </script>
</asp:Content>