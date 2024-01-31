<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="QuanLyDeThi.aspx.cs" Inherits="BTLWebNC.QuanLyDeThi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<button class="btnThemMoiDeThi" id="btnThemDeThi" name="btnThemDeThi" value="">--%><a class="btnThemMoiDeThi" id="btnThemDeThi" href="ThemBaiThi.aspx">Thêm đề thi mới</a><%--</button>--%>
    <form id="formDeThi" runat="server">
        <div class="table-exams" id="listExam" name="listExam" runat="server">
            <%-- <asp:GridView ID="gdvBaiThi" runat="server" AutoGenerateColumns="False" OnRowDeleting="XoaBaiThi" OnRowCommand="gdvBaiThi_RowCommand">
                <Columns>
                    <asp:BoundField DataField="PK_MaBaiThi" HeaderText="Mã bài thi" SortExpression="PK_MaBaiThi" />
                    <asp:BoundField DataField="sTieuDe" HeaderText="Tiêu đề" SortExpression="sTieuDe" />
                    <asp:BoundField DataField="dNgayTao" HeaderText="Ngày tạo" SortExpression="dNgayTao" />
                    <asp:BoundField DataField="iSoLuongCauHoi" HeaderText="Số lượng câu hỏi" SortExpression="iSoLuongCauHoi" />
                    <asp:BoundField DataField="iThoiGianLamBai" HeaderText="iThoiGianLamBai" SortExpression="iThoiGianLamBai" />
                    <asp:BoundField DataField="sMoTaChung" HeaderText="Mô tả chung" SortExpression="sMoTaChung" />
                    <asp:BoundField DataField="sMaCaThi" HeaderText="Mã ca thi" SortExpression="sMaCaThi" />

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="chiTiet" runat="server" NavigateUrl='<%# "~/QuanLyCauHoiDeThi.aspx?id=" + Eval("PK_MaBaiThi") %>' ValidateRequestMode="Inherit">Chi tiết</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
    
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return confirm('Bạn có chắn muốn xóa Không?');" CausesValidation="False" CommandName="Delete" Text="Xóa"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

    
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" CommandName="dalambai" CommandArgument='<%# Eval("PK_MaBaiThi") %>' Text="Những người đã làm"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
    
                </Columns>
            </asp:GridView>--%>
        </div>
        <div id="toast">
            <%--            <p id='success'>Xóa thành công</p>--%>
        </div>

    </form>


    <script>

        function toastXoa(id) {
            if (confirm("Bạn có chắn muốn xóa Không?") == true) {
                const xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        hienDuLieu(xhttp.responseText);

                    }
                }
                xhttp.open("GET", "QuanLyDeThi.aspx?xoaid=" + id, true);
                xhttp.send();
            }
        }


        function toastFunction() {
            var x = document.getElementById("toast");
            x.className = "show";
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 3000);
        }

        function hienDuLieu(data) {
            const objectMH = JSON.parse(data);
            let html = "";
            if (objectMH != null) {

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

                let stt = 1;

                for (let i in objectMH) {
                    html += "<tr>";
                    html += "<td> " + stt + " </td>";
                    html += "<td> " + objectMH[i].sTieuDe + " </td>";
                    html += "<td> " + objectMH[i].dNgayTao + " </td>";
                    html += "<td> " + objectMH[i].iSoLuongCauHoi + " </td>";
                    if (objectMH[i].iSoLuongCauHoi == objectMH[i].iSoCauHoiDaThem) {
                        html += "<td style='color:green;'> " + objectMH[i].iSoCauHoiDaThem + "/" + objectMH[i].iSoLuongCauHoi + " </td>";
                    }
                    else {
                        html += "<td style='color:red;'> " + objectMH[i].iSoCauHoiDaThem + "/" + objectMH[i].iSoLuongCauHoi + "</td>";
                    }
                    html += "<td> " + objectMH[i].iThoiGianLamBai + " </td>";
                    html += "<td> " + objectMH[i].sMoTaChung + " </td>";
                    html += "<td> " + objectMH[i].sMaCaThi + " </td>";
                    //html += "<form method='post'>";
                    html += "<td>";
                    html += "<button id='btnDaLamBai' name='btnDaLamBai' value='" + objectMH[i].PK_MaBaiThi + "'>Những người đã làm</button></td>";
                    html += "<td>";
                    html += "<a id='btnChiTiet' name='btnChiTiet' href='QuanLyCauHoiDeThi.aspx?id=" + objectMH[i].PK_MaBaiThi + "'>Chi tiết</a></td>";
                    html += "<td>";
                    html += "<button id='btnXoaDeThi' type='button' onclick='return toastXoa(" + objectMH[i].PK_MaBaiThi + ")' name='btnXoaDeThi' value='" + objectMH[i].PK_MaBaiThi + "'>Xóa</button></td>";
                    //html += "<form>";
                    html += "</tr>";

                    stt++;
                }
                html += "</table>";
            }
            document.getElementById("<%= listExam.ClientID %>").innerHTML = html;
        }

    </script>

    <style>
        /*        Css Toast*/
        #toast {
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
        }

        /*         Phần css của tạo đề thi admin 
*/
        .add-exam-box {
            position: relative;
            padding: 6rem 30%;
        }

        .add-exam-box {
            position: relative;
            align-items: center;
            justify-content: center;
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

        .add-exam-box {
            display: none;
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

        .table-exams {
            padding: 0 1%;
            margin-bottom: 3rem;
        }

            .table-exams table {
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 100%;
                font-size: 1.5rem;
            }

                .table-exams table td,
                th {
                    border: .1rem solid #f2f2f2;
                    text-align: left;
                    padding: 1rem;
                }


                .table-exams table tr:nth-child(odd) {
                    background-color: #dddddd;
                }

                .table-exams table td #btnDaLamBai {
                    background-color: #ffc04d;
                    padding: 1rem .5rem;
                    color: #000;
                    text-decoration: none;
                    border: none;
                    cursor: pointer;
                    font-size: 1.5rem;
                    border-radius: .5rem;
                }

                .table-exams table td #btnChiTiet {
                    background: #3366ff;
                    padding: 1rem .1rem;
                    color: #fff;
                    text-decoration: none;
                    border: none;
                    cursor: pointer;
                    font-size: 1.5rem;
                    border-radius: .5rem;
                }

                .table-exams table td #btnXoaDeThi {
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

            .add-exam-box {
                padding: 6rem 2%;
            }

            .table-exams {
                padding: 0 1%;
            }
        }
    </style>
</asp:Content>

