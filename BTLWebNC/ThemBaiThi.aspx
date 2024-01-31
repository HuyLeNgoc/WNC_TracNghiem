<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="ThemBaiThi.aspx.cs" Inherits="BTLWebNC.ThemBaiThi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        /*         Phần css của tạo đề thi admin 
*/
        .add-exam-box {
            position: relative;
            align-items: center;
            justify-content: center;
            margin: 10rem 30%;
        }

            .add-exam-box .form {
                margin: 1rem;
                padding: 1rem 1rem;
                border-radius: .5rem;
                background-color: #f2f2f2;
            }

                .add-exam-box .form h3 {
                    font-size: 3rem;
                    color: #444;
                    text-transform: uppercase;
                    text-align: center;
                    padding: 1rem 0;
                }

                .add-exam-box .form .box {
                    width: 100%;
                    padding: 1rem;
                    font-size: 1.5rem;
                    color: #333;
                    margin: 1rem 0;
                    border: .1rem solid rgba(0, 0, 0, .3);
                    text-transform: none;
                }

                .add-exam-box .form .btn {
                    display: inline-block;
                    width: 100%;
                }

                .add-exam-box .form .box:focus {
                    border-color: var(--orange);
                }


        .btnThemMoiDeThi {
            display: inline-block;
            margin: 0 10%;
            margin-top: 7rem;
            margin-bottom: 3rem;
            background: #ffc04d;
            padding: 1rem 2rem;
            text-align: center;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 1.5rem;
        }
    </style>

    <form id="form1" runat="server">
        <div class="add-exam-box">
            <div class="form">
                <h3>Đề Thi</h3>
                <asp:TextBox ID="txtTieuDe" placeholder="Tiêu đề đề thi" CssClass="box" runat="server" required></asp:TextBox>
                <asp:TextBox ID="txtSoLuongCauHoi" placeholder="Số lượng câu hỏi" CssClass="box" runat="server" required></asp:TextBox>
                <asp:TextBox ID="txtThoiGianLamBai" placeholder="Thời gian làm bài (phút)" CssClass="box" runat="server" required></asp:TextBox>
                <asp:TextBox ID="txtMoTaChung" placeholder="Mô tả chung" CssClass="box" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtMaCaThi" placeholder="Mã ca thi (nếu có)" CssClass="box" runat="server"></asp:TextBox>
                <asp:Button ID="btnTaoDeThi" CssClass="btn" runat="server" Text="Tạo đề thi" OnClick="TaoDeThi" />
            </div>
        </div>
    </form>

</asp:Content>
