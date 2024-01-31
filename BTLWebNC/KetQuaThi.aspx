<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="KetQuaThi.aspx.cs" Inherits="BTLWebNC.KetQuaThi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Phần css kết quả bài thi */
        .title-result-exam {
            text-align:center;
            margin-top: 12rem;
            font-size: 2rem;
            color: #000;
            font-weight: bold;
        }

        .result-exam {
            width: 25%;
            height: 20rem;
            border: .1rem solid rgba(0, 0, 0, .3);
            font-size: 1.5rem;
            margin: 0 40%;
            margin-top: 4rem;
        }

            .result-exam h3 {
                font-size: 1.6rem;
                text-transform: uppercase;
                text-align: center;
                padding: 2rem 0;
            }

            .result-exam .scores-exam {
                color: red;
                font-size: 4rem;
                text-align: center;
                margin-bottom: 3rem;
            }

            .result-exam p {
                margin: 1rem 1.5rem;
                font-weight: bold;
            }

            .result-exam span {
                padding-left: 2rem;
            }

        .btnExitExam {
            background-color: #ffc966;
            color: #000;
            padding: 1rem 2rem;
            border-radius: .5rem;
            margin-top: 1rem;
            margin-left: 40%;
            margin-bottom: 12rem;
            cursor: pointer;
        }

@media (max-width: 768px){
    .title-result-exam {
    margin:0 10%;
    margin-top:6rem;
}

    .result-exam {
    width: 50%;
    height: 20rem;
    border: .1rem solid rgba(0, 0, 0, .3);
    font-size: 1.5rem;
    margin: 0 25%;
    margin-top: 4rem;
}

.result-exam .scores-exam {
    color: red;
    font-size: 4rem;
    text-align: center;
    margin-bottom: 2rem;
}

.btnExitExam {
    margin-left: 25%;
}
}
    </style>
    <div id="ketQuaThi" name="ketQuaThi" runat="server">
    </div>
    <form method="post">
        <button class="btnExitExam" id="btnThoatBaiThi" name="btnThoatBaiThi" value="Thoát bài thi">Thoát bài thi</button>
    </form>
</asp:Content>