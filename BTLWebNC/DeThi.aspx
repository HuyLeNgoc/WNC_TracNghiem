<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="DeThi.aspx.cs" Inherits="BTLWebNC.DeThi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /*Phần css đề thi */
        .exam {
            background-color: #f2f2f2;
            padding: 2rem 3rem;
            margin: 8rem 20%;
        }

            .exam .title {
                font-size: 1.8rem;
            }

                .exam .title .border-bottom {
                    font-size: 1.5rem;
                    padding: 1rem 0;
                    border-bottom: .1rem solid #cccccc;
                }

            .exam .rules {
                margin: 1rem 0rem;
            }

                .exam .rules h3 {
                    color: #3366ff;
                    font-size: 1.5rem;
                    margin-top: 2rem;
                }

                .exam .rules ul {
                    margin-left: 1.5rem;
                    font-size: 1.5rem;
                }

                    .exam .rules ul li {
                        padding: .5rem 0;
                    }

            .exam .button {
                text-align: center;
                margin: 3rem 0;
            }

                .exam .button .btnBatDau {
                    background-color: #ff751a;
                    width: 20%;
                    padding: 1rem 1rem;
                    margin-right: 2rem;
                    border-radius: 2rem;
                    color: #fff;
                    cursor: pointer;
                }

                .exam .button .btnQuayLai {
                    background-color: #ff751a;
                    width: 20%;
                    padding: 1rem 1rem;
                    border-radius: 2rem;
                    color: #fff;
                    cursor: pointer;
                }

                .exam .button .btnBatDau:hover {
                    background-color: #e65c00;
                }

                .exam .button .btnQuayLai:hover {
                    background-color: #e65c00;
                }

            .exam .exam-code .box {
                width: 30%;
                padding: 1rem;
                font-size: 1.5rem;
                color: #333;
                margin: 1rem 0;
                border: .1rem solid rgba(0, 0, 0, .3);
                text-transform: none;
            }

                .exam .exam-code .box:focus {
                    border-color: var(--orange);
                }

        @media (max-width: 768px) {

            .exam {
                padding: 2rem 2rem;
                margin: 8rem 10%;
            }

                .exam form .button #btnBatDauLamBai {
                    width: 100%;
                    margin-bottom: 2rem;
                }

                .exam form .button #btnQuayLai {
                    width: 100%;
                }
        }
    </style>
    <form runat="server">
        <div class="exam">
            <div class="title" id="title" name="title" runat="server">
            </div>
            <div class="rules">
                <h3>Thời gian làm bài:</h3>
                <ul>
                    <li>Thời gian sẽ bắt đầu tính khi bạn nhấn nút "Bắt đầu làm bài"</li>
                    <li>Nếu hệ thống yêu cầu nhập mã ca thi, thời gian thi sẽ bắt đầu tính sau khi bạn nhập mã ca thi và
                    chọn nút "Làm bài"</li>
                </ul>
                <h3>Trong khi làm bài:</h3>
                <ul>
                    <li>Nếu ảnh và công thức không hiển thị, học sinh có thể tải lại trang làm bài</li>
                    <li>Khi hết thời gian làm bài, hệ thống sẽ tự động nộp bài và tính điểm cho học sinh</li>
                </ul>
                <h3>Các trường hợp vi phạm quy chế thi:</h3>
                <ul>
                    <li>Đăng nhập một tài khoản trên hai thiết bị hoặc hai trình duyệt khác nhau và thi cùng một thời điểm
                    </li>
                    <li>Mở nhiều cửa sổ thi vào thi cùng một lúc</li>
                </ul>
                <h3>Các trường hợp cố tình vi phạm sẽ bị hệ thống ghi nhận và thông báo cho nhà trường!</h3>
            </div>
            <div class="exam-code" id="examCode" runat="server">
            </div>

            <div class="button" id="btnDeThi" name="btnDeThi" runat="server">
                <asp:Button ID="btnBatDauLamBai" CssClass="btnBatDau" runat="server" Text="Bắt đầu làm bài" OnClick="BatDauThi" />
                <asp:Button ID="btnQuayLai" CssClass="btnQuayLai" runat="server" Text="Quay lại" OnClick="QuayLai" />
            </div>
        </div>
    </form>

</asp:Content>
