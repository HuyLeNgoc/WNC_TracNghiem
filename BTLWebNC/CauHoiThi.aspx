<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CauHoiThi.aspx.cs" MasterPageFile="~/Layout.Master" Inherits="BTLWebNC.CauHoiThi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        /*Phần css câu hỏi đề thi */

        .grid-container {
            display: grid;
            grid-template-columns: 80% 20%;
            gap: 1rem;
            padding: 2rem 10%;
        }

            .grid-container .column-questions .box-container .box {
                font-size: 1.5rem;
                border: .1rem solid #d9d9d9;
                padding: 2rem 2rem;
                margin: 3rem 0;
            }

                .grid-container .column-questions .box-container .box .question {
                    margin-bottom: 4rem;
                    word-wrap: break-word;
                    word-break: keep-all;
                }

                    .grid-container .column-questions .box-container .box .question span {
                        font-size: 2rem;
                        padding-right: 1rem;
                        font-weight: bold;
                        color: #e65c00;
                    }

                    .grid-container .column-questions .box-container .box .question img {
                        max-width: 60%;
                        object-fit: cover;
                    }

                .grid-container .column-questions .box-container .box .answers {
                    display: grid;
                    grid-template-columns: auto auto;
                    gap: 2rem;
                }

                    .grid-container .column-questions .box-container .box .answers .answer-content {
                        margin: 0rem 1rem;
                    }

            .grid-container .column-box {
                position: fixed;
                border: .1rem solid #d9d9d9;
                margin-left: 65%;
                top: 0;
                z-index: 1002;
            }

                .grid-container .column-box .header-box {
                    background-color: #fff0e6;
                    margin-bottom: .5rem;
                }

                    .grid-container .column-box .header-box .name-user {
                        background-color: #ff751a;
                        color: #fff;
                        padding: 1rem 1rem;
                        font-size: 1.8rem;
                        text-align: center;
                    }

                .grid-container .column-box .countdown {
                    font-size: 4rem;
                    text-align: center;
                    margin-top: 1rem;
                }

                    .grid-container .column-box .countdown span {
                        color: #e65c00;
                    }

                .grid-container .column-box .btnNopBai {
                    background-color: #e65c00;
                    color: #fff;
                    padding: 1.5rem 5rem;
                    font-size: 1.8rem;
                    margin: 1rem 2.5rem;
                    border-radius: .5rem;
                    cursor: pointer;
                }

                    .grid-container .column-box .btnNopBai:hover {
                        background-color: #cc5200;
                    }

                .grid-container .column-box .box-container-questions {
                    display: grid;
                    grid-template-columns: auto auto auto auto auto;
                    gap: .5rem;
                    padding: 0 .5rem;
                    margin-bottom: 1rem;
                }

                    .grid-container .column-box .box-container-questions .mini-box {
                        overflow: hidden;
                        font-size: 1.5rem;
                        background-color: #e6e6e6;
                    }

                        .grid-container .column-box .box-container-questions .mini-box p {
                            padding: .5rem;
                            text-align: center;
                            font-weight: bold;
                        }

        header {
            display: none;
        }




        /*  css phần tạo thông báo xác nhận có muốn xóa hay nộp bài không*/


        /* Float cancel and delete buttons and add an equal width */
        .cancelbtn, .deletebtn {
            float: left;
            width: 50%;
        }

        /* Add a color to the cancel button */
        .cancelbtn {
            padding: 1rem 2rem;
            border: none;
            cursor: pointer;
            width: 100%;
            background-color: #ccc;
            color: black;
        }

        /* Add a color to the delete button */
        .deletebtn {
            background-color: #3366ff;
            color: white;
            padding: 1rem 2rem;
            margin: 1.5rem 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        /* Add padding and center-align text to the container */
        .container {
            padding: 10% 15%;
            text-align: center;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1010; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background: rgba(0, 0, 0, 0.5); /* Black background with 0.5 opacity */
            padding-top: 5rem;
        }

        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 10% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
            border: .1rem solid #888;
            width: 40%; /* Could be more or less, depending on screen size */
        }

        /* Style the horizontal ruler */
        hr {
            border: .1rem solid #f1f1f1;
            margin-bottom: 3rem;
        }

        /* The Modal Close Button (x) */
        .close {
            position: absolute;
            right: 35rem;
            top: 6rem;
            font-size: 5rem;
            font-weight: bold;
            color: #f1f1f1;
        }

            .close:hover,
            .close:focus {
                color: #f44336;
                cursor: pointer;
            }

        /* Clear floats */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }

        /*  css phần tạo thông báo xác nhận có muốn xóa hay nộp bài không*/




        @media (max-width: 768px) {

            .grid-container {
                display: grid;
                grid-template-columns: 100%;
                padding: 2rem 1%;
                margin-top: 3rem;
            }

                .grid-container .column-questions {
                    padding: 2rem 1rem;
                    margin-top: 10%;
                }


                .grid-container .column-box {
                    z-index: 1002;
                    background-color: #f2f2f2;
                    position: fixed;
                    width: 100%;
                    border: .1rem solid #d9d9d9;
                    top: 0;
                    left: 0;
                    margin-left: 0;
                }

                    .grid-container .column-box .header-box .name-user {
                        display: none;
                    }

                    .grid-container .column-box .countdown {
                        font-size: 3rem;
                        text-align: center;
                        color: #e65c00;
                        margin-top: 0;
                    }

                    .grid-container .column-box .btnNopBai {
                        position: static;
                        background-color: #e65c00;
                        color: #fff;
                        width: 40%;
                        padding: 1.5rem 0;
                        margin-left: 30%;
                        font-size: 1.5rem;
                        border-radius: .5rem;
                        cursor: pointer;
                        margin-top: .5rem;
                    }

                    .grid-container .column-box .box-container-questions {
                        display: grid;
                        grid-template-columns: auto auto auto auto auto auto auto auto auto auto auto auto auto auto auto auto auto auto auto auto;
                        gap: .5rem;
                    }

                        .grid-container .column-box .box-container-questions .mini-box p {
                            padding: 1rem 0;
                            text-align: center;
                            font-weight: bold;
                            font-size: 1rem;
                        }
        }
    </style>
    <form method="post" runat="server">

        <div class="grid-container">
            <div class="column-box" id="columnBox">

                <div class="header-box" id="headerBoxExam" name="headerBoxExam" runat="server">
                </div>
                <asp:ScriptManager ID="sp" runat="server"></asp:ScriptManager>
                <asp:Timer ID="timerCountDown" runat="server" Interval="1000" OnTick="timer_tick"></asp:Timer>
                <asp:UpdatePanel ID="up" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="timerCountDown" EventName="tick" />
                    </Triggers>
                    <ContentTemplate>
                        <div class="countdown">
                            <asp:Label ID="countdown" runat="server"></asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div id="dalambai" runat="server">
                    <button id="btnNopBai" class="btnNopBai" value="" onclick="event.stopPropagation();        event.preventDefault()
;document.getElementById('idBox').style.display='block'">
                        Nộp bài</button>
                </div>


                <div class="box-container-questions" id="listMiniBoxQuestions" name="listMiniBoxQuestions" runat="server">
                </div>

            </div>
            <div class="column-questions">


                <div class="box-container" id="listQuestionExamHtml" name="listQuestionExamHtml" runat="server">
                </div>

            </div>

        </div>


        <div id="idBox" class="modal">
            <span onclick="document.getElementById('idBox').style.display='none'" class="close" title="Close Modal">×</span>
            <div class="modal-content">
                <div class="container" id="XacNhanNopBai">
                    <h1>Bạn có chắc muốn nộp bài không ?</h1>

                    <div class="clearfix">
                        <button type="submit" name="btnNopBai" class="deletebtn" value="Nộp bài">Nộp bài</button>
                        <button type="button" onclick="document.getElementById('idBox').style.display='none'" class="cancelbtn">Hủy</button>
                    </div>
                </div>
            </div>
        </div>

    </form>


    <script>
        //Phần js câu hỏi thi

        let answer1 = document.querySelectorAll('input[name="question1"]');
        let answer2 = document.querySelectorAll('input[name="question2"]');
        let answer3 = document.querySelectorAll('input[name="question3"]');
        let answer4 = document.querySelectorAll('input[name="question4"]');
        let answer5 = document.querySelectorAll('input[name="question5"]');
        let answer6 = document.querySelectorAll('input[name="question6"]');
        let answer7 = document.querySelectorAll('input[name="question7"]');
        let answer8 = document.querySelectorAll('input[name="question8"]');
        let answer9 = document.querySelectorAll('input[name="question9"]');
        let answer10 = document.querySelectorAll('input[name="question10"]');
        let answer11 = document.querySelectorAll('input[name="question11"]');
        let answer12 = document.querySelectorAll('input[name="question12"]');
        let answer13 = document.querySelectorAll('input[name="question13"]');
        let answer14 = document.querySelectorAll('input[name="question14"]');
        let answer15 = document.querySelectorAll('input[name="question15"]');
        let answer16 = document.querySelectorAll('input[name="question16"]');
        let answer17 = document.querySelectorAll('input[name="question17"]');
        let answer18 = document.querySelectorAll('input[name="question18"]');
        let answer19 = document.querySelectorAll('input[name="question19"]');
        let answer20 = document.querySelectorAll('input[name="question20"]');
        let answer21 = document.querySelectorAll('input[name="question21"]');
        let answer22 = document.querySelectorAll('input[name="question22"]');
        let answer23 = document.querySelectorAll('input[name="question23"]');
        let answer24 = document.querySelectorAll('input[name="question24"]');
        let answer25 = document.querySelectorAll('input[name="question25"]');
        let answer26 = document.querySelectorAll('input[name="question26"]');
        let answer27 = document.querySelectorAll('input[name="question27"]');
        let answer28 = document.querySelectorAll('input[name="question28"]');
        let answer29 = document.querySelectorAll('input[name="question29"]');
        let answer30 = document.querySelectorAll('input[name="question30"]');
        let answer31 = document.querySelectorAll('input[name="question31"]');
        let answer32 = document.querySelectorAll('input[name="question32"]');
        let answer33 = document.querySelectorAll('input[name="question33"]');
        let answer34 = document.querySelectorAll('input[name="question34"]');
        let answer35 = document.querySelectorAll('input[name="question35"]');
        let answer36 = document.querySelectorAll('input[name="question36"]');
        let answer37 = document.querySelectorAll('input[name="question37"]');
        let answer38 = document.querySelectorAll('input[name="question38"]');
        let answer39 = document.querySelectorAll('input[name="question39"]');
        let answer40 = document.querySelectorAll('input[name="question40"]');
        let answer41 = document.querySelectorAll('input[name="question41"]');
        let answer42 = document.querySelectorAll('input[name="question42"]');
        let answer43 = document.querySelectorAll('input[name="question43"]');
        let answer44 = document.querySelectorAll('input[name="question44"]');
        let answer45 = document.querySelectorAll('input[name="question45"]');
        let answer46 = document.querySelectorAll('input[name="question46"]');
        let answer47 = document.querySelectorAll('input[name="question47"]');
        let answer48 = document.querySelectorAll('input[name="question48"]');
        let answer49 = document.querySelectorAll('input[name="question49"]');
        let answer50 = document.querySelectorAll('input[name="question50"]');

        // Khi màn chiều rồng màn hình thu nhỏ về kích thước 768px thì script được kích hoạt
        //let mediaQuery = window.matchMedia('(max-width: 768px)');
        ////  ẩn thanh navbar khi người dùng bắt đầu cuộn trang.
        //if (mediaQuery.matches) {
        //    var prevScrollpos1 = window.pageYOffset;
        //    window.addEventListener("scroll", () => {
        //        var currentScrollPos1 = window.pageYOffset;
        //        if (prevScrollpos1 > currentScrollPos1) {
        //            document.getElementById("columnBox").style.top = "0";
        //        } else {
        //            document.getElementById("columnBox").style.top = "-30rem";
        //        }
        //        prevScrollpos1 = currentScrollPos1;
        //    });
        //}

        let question1 = document.getElementById("box1");
        question1.addEventListener("click", function () {
            for (let i = 0; i < answer1.length; i++) {
                if (answer1[i].checked) {
                    document.getElementById("mini-box-question1").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question1").style.color = "#fff";
                    question1.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question2 = document.getElementById("box2");
        question2.addEventListener("click", function () {
            for (let i = 0; i < answer2.length; i++) {
                if (answer2[i].checked) {
                    document.getElementById("mini-box-question2").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question2").style.color = "#fff";
                    question2.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question3 = document.getElementById("box3");
        question3.addEventListener("click", function () {
            for (let i = 0; i < answer3.length; i++) {
                if (answer3[i].checked) {
                    document.getElementById("mini-box-question3").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question3").style.color = "#fff";
                    question3.style.backgroundColor = "#e6f2ff";

                }
            }
        });

        let question4 = document.getElementById("box4");
        question4.addEventListener("click", function () {
            for (let i = 0; i < answer4.length; i++) {
                if (answer4[i].checked) {
                    document.getElementById("mini-box-question4").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question4").style.color = "#fff";
                    question4.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question5 = document.getElementById("box5");
        question5.addEventListener("click", function () {
            for (let i = 0; i < answer5.length; i++) {
                if (answer5[i].checked) {
                    document.getElementById("mini-box-question5").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question5").style.color = "#fff";
                    question5.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question6 = document.getElementById("box6");
        question6.addEventListener("click", function () {
            for (let i = 0; i < answer6.length; i++) {
                if (answer6[i].checked) {
                    document.getElementById("mini-box-question6").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question6").style.color = "#fff";
                    question6.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question7 = document.getElementById("box7");
        question7.addEventListener("click", function () {
            for (let i = 0; i < answer7.length; i++) {
                if (answer7[i].checked) {
                    document.getElementById("mini-box-question7").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question7").style.color = "#fff";
                    question7.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question8 = document.getElementById("box8");
        question8.addEventListener("click", function () {
            for (let i = 0; i < answer8.length; i++) {
                if (answer8[i].checked) {
                    document.getElementById("mini-box-question8").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question8").style.color = "#fff";
                    question8.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question9 = document.getElementById("box9");
        question9.addEventListener("click", function () {
            for (let i = 0; i < answer9.length; i++) {
                if (answer9[i].checked) {
                    document.getElementById("mini-box-question9").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question9").style.color = "#fff";
                    question9.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question10 = document.getElementById("box10");
        question10.addEventListener("click", function () {
            for (let i = 0; i < answer10.length; i++) {
                if (answer10[i].checked) {
                    document.getElementById("mini-box-question10").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question10").style.color = "#fff";
                    question10.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question11 = document.getElementById("box11");
        question11.addEventListener("click", function () {
            for (let i = 0; i < answer11.length; i++) {
                if (answer11[i].checked) {
                    document.getElementById("mini-box-question11").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question11").style.color = "#fff";
                    question11.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question12 = document.getElementById("box12");
        question12.addEventListener("click", function () {
            for (let i = 0; i < answer12.length; i++) {
                if (answer12[i].checked) {
                    document.getElementById("mini-box-question12").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question12").style.color = "#fff";
                    question12.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question13 = document.getElementById("box13");
        question13.addEventListener("click", function () {
            for (let i = 0; i < answer13.length; i++) {
                if (answer13[i].checked) {
                    document.getElementById("mini-box-question13").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question13").style.color = "#fff";
                    question13.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question14 = document.getElementById("box14");
        question14.addEventListener("click", function () {
            for (let i = 0; i < answer14.length; i++) {
                if (answer14[i].checked) {
                    document.getElementById("mini-box-question14").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question14").style.color = "#fff";
                    question14.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question15 = document.getElementById("box15");
        question15.addEventListener("click", function () {
            for (let i = 0; i < answer15.length; i++) {
                if (answer15[i].checked) {
                    document.getElementById("mini-box-question15").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question15").style.color = "#fff";
                    question15.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question16 = document.getElementById("box16");
        question16.addEventListener("click", function () {
            for (let i = 0; i < answer16.length; i++) {
                if (answer16[i].checked) {
                    document.getElementById("mini-box-question16").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question16").style.color = "#fff";
                    question16.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question17 = document.getElementById("box17");
        question17.addEventListener("click", function () {
            for (let i = 0; i < answer17.length; i++) {
                if (answer17[i].checked) {
                    document.getElementById("mini-box-question17").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question17").style.color = "#fff";
                    question17.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question18 = document.getElementById("box18");
        question18.addEventListener("click", function () {
            for (let i = 0; i < answer18.length; i++) {
                if (answer18[i].checked) {
                    document.getElementById("mini-box-question18").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question18").style.color = "#fff";
                    question18.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question19 = document.getElementById("box19");
        question19.addEventListener("click", function () {
            for (let i = 0; i < answer19.length; i++) {
                if (answer19[i].checked) {
                    document.getElementById("mini-box-question19").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question19").style.color = "#fff";
                    question19.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question20 = document.getElementById("box20");
        question20.addEventListener("click", function () {
            for (let i = 0; i < answer20.length; i++) {
                if (answer20[i].checked) {
                    document.getElementById("mini-box-question20").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question20").style.color = "#fff";
                    question20.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question21 = document.getElementById("box21");
        question21.addEventListener("click", function () {
            for (let i = 0; i < answer21.length; i++) {
                if (answer21[i].checked) {
                    document.getElementById("mini-box-question21").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question21").style.color = "#fff";
                    question21.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question22 = document.getElementById("box22");
        question22.addEventListener("click", function () {
            for (let i = 0; i < answer22.length; i++) {
                if (answer22[i].checked) {
                    document.getElementById("mini-box-question22").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question22").style.color = "#fff";
                    question22.style.backgroundColor = "#e6f2ff";


                }
            }
        });

        let question23 = document.getElementById("box23");
        question23.addEventListener("click", function () {
            for (let i = 0; i < answer23.length; i++) {
                if (answer23[i].checked) {
                    document.getElementById("mini-box-question23").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question23").style.color = "#fff";
                    question23.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question24 = document.getElementById("box24");
        question24.addEventListener("click", function () {
            for (let i = 0; i < answer24.length; i++) {
                if (answer22[i].checked) {
                    document.getElementById("mini-box-question24").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question24").style.color = "#fff";
                    question24.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question26 = document.getElementById("box26");
        question26.addEventListener("click", function () {
            for (let i = 0; i < answer26.length; i++) {
                if (answer26[i].checked) {
                    document.getElementById("mini-box-question26").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question26").style.color = "#fff";
                    question26.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question27 = document.getElementById("box27");
        question27.addEventListener("click", function () {
            for (let i = 0; i < answer27.length; i++) {
                if (answer27[i].checked) {
                    document.getElementById("mini-box-question27").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question27").style.color = "#fff";
                    question27.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question28 = document.getElementById("box28");
        question28.addEventListener("click", function () {
            for (let i = 0; i < answer28.length; i++) {
                if (answer28[i].checked) {
                    document.getElementById("mini-box-question28").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question28").style.color = "#fff";
                    question28.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question29 = document.getElementById("box29");
        question29.addEventListener("click", function () {
            for (let i = 0; i < answer29.length; i++) {
                if (answer29[i].checked) {
                    document.getElementById("mini-box-question29").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question29").style.color = "#fff";
                    question29.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question30 = document.getElementById("box30");
        question30.addEventListener("click", function () {
            for (let i = 0; i < answer30.length; i++) {
                if (answer30[i].checked) {
                    document.getElementById("mini-box-question30").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question30").style.color = "#fff";
                    question30.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question31 = document.getElementById("box31");
        question31.addEventListener("click", function () {
            for (let i = 0; i < answer31.length; i++) {
                if (answer31[i].checked) {
                    document.getElementById("mini-box-question31").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question31").style.color = "#fff";
                    question31.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question32 = document.getElementById("box32");
        question32.addEventListener("click", function () {
            for (let i = 0; i < answer32.length; i++) {
                if (answer32[i].checked) {
                    document.getElementById("mini-box-question32").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question32").style.color = "#fff";
                    question32.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question34 = document.getElementById("box34");
        question34.addEventListener("click", function () {
            for (let i = 0; i < answer34.length; i++) {
                if (answer34[i].checked) {
                    document.getElementById("mini-box-question34").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question34").style.color = "#fff";
                    question34.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question35 = document.getElementById("box35");
        question35.addEventListener("click", function () {
            for (let i = 0; i < answer35.length; i++) {
                if (answer35[i].checked) {
                    document.getElementById("mini-box-question35").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question35").style.color = "#fff";
                    question35.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question36 = document.getElementById("box36");
        question36.addEventListener("click", function () {
            for (let i = 0; i < answer36.length; i++) {
                if (answer22[i].checked) {
                    document.getElementById("mini-box-question36").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question36").style.color = "#fff";
                    question36.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question37 = document.getElementById("box37");
        question37.addEventListener("click", function () {
            for (let i = 0; i < answer37.length; i++) {
                if (answer37[i].checked) {
                    document.getElementById("mini-box-question37").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question37").style.color = "#fff";
                    question37.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question38 = document.getElementById("box38");
        question38.addEventListener("click", function () {
            for (let i = 0; i < answer38.length; i++) {
                if (answer38[i].checked) {
                    document.getElementById("mini-box-question38").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question38").style.color = "#fff";
                    question38.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question39 = document.getElementById("box39");
        question39.addEventListener("click", function () {
            for (let i = 0; i < answer39.length; i++) {
                if (answer39[i].checked) {
                    document.getElementById("mini-box-question39").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question39").style.color = "#fff";
                    question39.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question40 = document.getElementById("box40");
        question40.addEventListener("click", function () {
            for (let i = 0; i < answer40.length; i++) {
                if (answer40[i].checked) {
                    document.getElementById("mini-box-question40").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question40").style.color = "#fff";
                    question40.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question41 = document.getElementById("box41");
        question41.addEventListener("click", function () {
            for (let i = 0; i < answer41.length; i++) {
                if (answer41[i].checked) {
                    document.getElementById("mini-box-question41").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question41").style.color = "#fff";
                    question41.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question42 = document.getElementById("box42");
        question42.addEventListener("click", function () {
            for (let i = 0; i < answer39.length; i++) {
                if (answer42[i].checked) {
                    document.getElementById("mini-box-question42").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question42").style.color = "#fff";
                    question42.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question43 = document.getElementById("box43");
        question43.addEventListener("click", function () {
            for (let i = 0; i < answer43.length; i++) {
                if (answer43[i].checked) {
                    document.getElementById("mini-box-question43").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question43").style.color = "#fff";
                    question43.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question44 = document.getElementById("box44");
        question44.addEventListener("click", function () {
            for (let i = 0; i < answer44.length; i++) {
                if (answer44[i].checked) {
                    document.getElementById("mini-box-question44").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question44").style.color = "#fff";
                    question44.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question45 = document.getElementById("bo45");
        question45.addEventListener("click", function () {
            for (let i = 0; i < answer45.length; i++) {
                if (answer45[i].checked) {
                    document.getElementById("mini-box-question45").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question45").style.color = "#fff";
                    question45.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question46 = document.getElementById("box46");
        question46.addEventListener("click", function () {
            for (let i = 0; i < answer46.length; i++) {
                if (answer46[i].checked) {
                    document.getElementById("mini-box-question46").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question46").style.color = "#fff";
                    question46.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question47 = document.getElementById("box47");
        question47.addEventListener("click", function () {
            for (let i = 0; i < answer47.length; i++) {
                if (answer47[i].checked) {
                    document.getElementById("mini-box-question47").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question47").style.color = "#fff";
                    question47.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question48 = document.getElementById("box48");
        question48.addEventListener("click", function () {
            for (let i = 0; i < answer48.length; i++) {
                if (answer48[i].checked) {
                    document.getElementById("mini-box-question48").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question48").style.color = "#fff";
                    question48.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question49 = document.getElementById("box49");
        question49.addEventListener("click", function () {
            for (let i = 0; i < answer49.length; i++) {
                if (answer49[i].checked) {
                    document.getElementById("mini-box-question49").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question49").style.color = "#fff";
                    question49.style.backgroundColor = "#e6f2ff";
                }
            }
        });

        let question50 = document.getElementById("box50");
        question50.addEventListener("click", function () {
            for (let i = 0; i < answer50.length; i++) {
                if (answer50[i].checked) {
                    document.getElementById("mini-box-question50").style.backgroundColor = "#ff751a";
                    document.getElementById("mini-box-question50").style.color = "#fff";
                    question50.style.backgroundColor = "#e6f2ff";
                }
            }
        });
    </script>
</asp:Content>
