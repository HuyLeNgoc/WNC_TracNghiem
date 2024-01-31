<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="QuanLyCauHoiDeThi.aspx.cs" Inherits="BTLWebNC.QuanLyCauHoiDeThi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Phần css quản lý câu hỏi của đề thi admin */
        .add-questions-exam-container {
            display: grid;
            grid-template-columns: 30% 70%;
            gap: 1rem;
            padding: 8rem 10%;
        }

            .add-questions-exam-container .title-exam {
                position: relative;
                background-color: #f2f2f2;
                padding: 2rem 2rem;
                font-size: 1.5rem;
            }

                .add-questions-exam-container .title-exam h3 {
                    padding: 1rem 0;
                }

                .add-questions-exam-container .title-exam p {
                    padding: .5rem 0;
                }

            .add-questions-exam-container .add-questions {
                position: relative;
                align-items: center;
                justify-content: center;
                background-color: #f2f2f2;
            }

                .add-questions-exam-container .add-questions .form {
                    margin: 1rem;
                    padding: 1rem 1rem;
                    background-color: #f2f2f2;
                    border-radius: .5rem;
                }

                    .add-questions-exam-container .add-questions .form .box {
                        width: 100%;
                        padding: 1rem;
                        font-size: 1.5rem;
                        color: #333;
                        margin: 1rem 0;
                        border: .1rem solid rgba(0, 0, 0, .3);
                        text-transform: none;
                    }

                    .add-questions-exam-container .add-questions .form h3 {
                        font-size: 3rem;
                        color: #444;
                        text-transform: uppercase;
                        text-align: center;
                        padding: 1rem 0;
                    }

                    .add-questions-exam-container .add-questions .form .box:focus {
                        border-color: var(--orange);
                    }

                    .add-questions-exam-container .add-questions .form .btnAddQuestion {
                        display: inline-block;
                        background: #ffc04d;
                        padding: 1rem 2rem;
                        text-align: center;
                        text-decoration: none;
                        border: none;
                        cursor: pointer;
                        font-size: 1.5rem;
                    }

        .table-questions {
            padding: 0 10%;
            margin-bottom: 4rem;
        }

            .table-questions table {
                border-collapse: collapse;
                width: 100%;
                font-size: 1.5rem;
            }

                .table-questions table td,
                th {
                    border: .1rem solid #f2f2f2;
                    text-align: left;
                    padding: 1.5rem;
                }

                .table-questions table tr:nth-child(odd) {
                    background-color: #dddddd;
                }

                .table-questions table td img {
                    width: 100%;
                    max-width: 10rem;
                }

                .table-questions table td #btnXoaCauHoi {
                    background: #ff1a1a;
                    padding: 1rem 2rem;
                    color: #fff;
                    text-align: center;
                    text-decoration: none;
                    border: none;
                    cursor: pointer;
                    font-size: 1.5rem;
                    border-radius: .5rem;
                }

        @media(max-width: 768px) {
            html {
                font-size: 46%
            }

            .add-questions-exam-container {
                padding: 8rem 2%;
            }

            .table-questions {
                padding: 0 1%;
            }

                .table-questions table {
                    width: 100%;
                }
        }

       /* #toast {
            visibility: hidden;
            min-width: 300px;
            margin-left: -200px;
            background-color: white;
            box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
            text-align: center;
            border-radius: 10px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            font-size: 1.8rem;
        }

        #success {
            color: forestgreen;
        }

        #fail {
            color: red;
        }

        #toast.show {
            visibility: visible;
            -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
            animation: fadein 0.5s, fadeout 0.5s 2.5s;
        }

        @-webkit-keyframes fadein {
            from {
                bottom: 0;
                opacity: 0;
            }

            to {
                bottom: 30px;
                opacity: 1;
            }
        }

        @keyframes fadein {
            from {
                bottom: 0;
                opacity: 0;
            }

            to {
                bottom: 30px;
                opacity: 1;
            }
        }

        @-webkit-keyframes fadeout {
            from {
                bottom: 30px;
                opacity: 1;
            }

            to {
                bottom: 0;
                opacity: 0;
            }
        }

        @keyframes fadeout {
            from {
                bottom: 30px;
                opacity: 1;
            }

            to {
                bottom: 0;
                opacity: 0;
            }
        }*/
    </style>
    <form runat="server" enctype="multipart/form-data">

        <div class="add-questions-exam-container">
            <div class="title-exam" id="titleExam" name="titleExam" runat="server">
            </div>
            <div class="add-questions">
                <div class="form">
                    <h3>Câu Hỏi</h3>
                    <asp:TextBox ID="txtCauHoi" placeholder="Câu hỏi" CssClass="box" runat="server" required></asp:TextBox>
                    <asp:FileUpload ID="imgCauHoi" CssClass="box" runat="server" accept="image/*" />
                    <asp:TextBox ID="txtDapAnA" placeholder="Đáp án A" CssClass="box" runat="server" required></asp:TextBox>
                    <asp:TextBox ID="txtDapAnB" placeholder="Đáp án B" CssClass="box" runat="server" required></asp:TextBox>
                    <asp:TextBox ID="txtDapAnC" placeholder="Đáp án C" CssClass="box" runat="server" required></asp:TextBox>
                    <asp:TextBox ID="txtDapAnD" placeholder="Đáp án D" CssClass="box" runat="server" required></asp:TextBox>
                    <asp:DropDownList ID="ddlDapAnDung" runat="server" placeholder="Chọn đáp án đúng" CssClass="box" required>
                        <asp:ListItem Value="A">Đáp án A</asp:ListItem>
                        <asp:ListItem Value="B">Đáp án B</asp:ListItem>
                        <asp:ListItem Value="C">Đáp án C</asp:ListItem>
                        <asp:ListItem Value="D">Đáp án D</asp:ListItem>
                    </asp:DropDownList>

                    <asp:Button ID="btnThemCauHoi" runat="server" Text="Thêm câu hỏi" CssClass="btnAddQuestion" OnClientClick="return toastFunction()" OnClick="ThemCauHoi" />
                </div>
            </div>
        </div>
        <div class="table-questions" id="listQuestion" name="listQuestion" runat="server">
            <asp:GridView ID="gdvCauHoi" runat="server" AutoGenerateColumns="False" OnRowDeleting="XoaCauHoi">
                <Columns>
                    <asp:BoundField DataField="PK_MaCauHoi" HeaderText="Mã câu hỏi" SortExpression="PK_MaCauHoi" />
                    <asp:BoundField DataField="sCauHoi" HeaderText="Câu hỏi" SortExpression="sCauHoi" />
                    <asp:ImageField HeaderText="Ảnh" DataImageUrlField="url_img">
                    </asp:ImageField>
                    <asp:BoundField DataField="DapAn_A" HeaderText="Đáp án A" SortExpression="DapAn_A" />
                    <asp:BoundField DataField="dapAn_B" HeaderText="Đáp án B" SortExpression="dapAn_B" />
                    <asp:BoundField DataField="dapAn_C" HeaderText="Đáp án C" SortExpression="dapAn_C" />
                    <asp:BoundField DataField="dapAn_D" HeaderText="Đáp án D" SortExpression="dapAn_D" />
                    <asp:BoundField DataField="dapAn" HeaderText="Đáp án" SortExpression="dapAn" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnXoa" runat="server" OnClientClick="return confirm('Bạn có chắn muốn xóa Không?');" CausesValidation="False" CommandName="Delete" Text="Xóa"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>


   <%-- <script>
        function toastXoa() {
            if (confirm("Bạn có chắn muốn xóa Không?") == true) {
                const xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("toast").innerHTML = xhttp.responseText;
                    }
                }
                xhttp.open("GET", "QuanLyCauHoiDeThi.aspx?id=<%= Session["idDeThi"].ToString() %>", true);
                xhttp.send();
            }
            toastFunction();
        }

        function toastFunction() {
            var x = document.getElementById("toast");
            x.className = "show";
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 3000);

        }

    </script>--%>

</asp:Content>
