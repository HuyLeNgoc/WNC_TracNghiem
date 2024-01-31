<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="QuanLyUser.aspx.cs" Inherits="BTLWebNC.QuanLyUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .table-users {
    padding: 9rem 10%;
    margin-bottom: 10rem;
}

    .table-users table {
        border-collapse: collapse;
        width: 100%;
        font-size: 1.5rem;
    }

        .table-users table td,
        th {
            border: .1rem solid #f2f2f2;
            text-align: left;
            padding: 1rem;
        }

        .table-users table tr:nth-child(odd) {
            background-color: #dddddd;
        }
        .table-users table .KetQuaThiUser {
            background: #3366ff;
            padding: 1rem 3rem;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 1.5rem;
            border-radius: .5rem;
        }

        @media(max-width: 768px){
    html{font-size:46%}
             .table-users {
        padding: 9rem 1%;
}
}
    </style>
    <div class="table-users" id="tableUsers" name="tableUsers" runat="server">
        
    </div>
</asp:Content>