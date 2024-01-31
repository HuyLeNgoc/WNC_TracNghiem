<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="QuanLyKetQuaThiUser.aspx.cs" Inherits="BTLWebNC.QuanLyKetQuaThuUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Phần css quản lý kết quả thi của người dùng */
        .result-user-container .name-user {
            text-align: center;
            margin-bottom: 3rem;
            font-size: 2rem;
        }

        .result-user-container {
            padding: 9rem 10%;
            margin-bottom: 20rem;
        }

            .result-user-container .table-result-user table {
                border-collapse: collapse;
                width: 100%;
                font-size: 1.5rem;
                border: .1rem solid #f2f2f2;
            }

                .result-user-container .table-result-user table th {
                    background-color: #4d79ff;
                    text-align: center;
                    padding: 1.5rem;
                    color: #fff;
                    border: .1rem solid #cccccc;
                }

                .result-user-container .table-result-user table td {
                    text-align: left;
                    padding: 1rem;
                    border: .1rem solid #cccccc;
                }

                .result-user-container .table-result-user table a {
                    color: #3366ff;
                }

        @media(max-width: 768px) {
            html {
                font-size: 46%
            }

            .result-user-container {
                padding: 9rem 1%;
            }
        }
    </style>
    <div class="result-user-container" id="resultUser" name="resultUser" runat="server">
    </div>
</asp:Content>