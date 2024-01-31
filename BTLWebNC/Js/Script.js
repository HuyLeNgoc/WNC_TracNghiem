let searchBtn = document.querySelector("#search-btn");
let searchBar = document.querySelector(".search-bar-container");

let formBtn = document.querySelector("#login-btn");
let loginForm = document.querySelector(".login-form-container");
//let formClose = document.querySelector("#form-close");

let btnAddExam = document.querySelector("#btnThemDeThi");
let btnCancelAddExam = document.querySelector("#btnHuyThemDeThi");
let formAddExam = document.querySelector(".add-exam-box");

var menu = document.querySelector("#menu-bar");
var navbar = document.querySelector(".navbar");

//  ẩn thanh navbar khi người dùng bắt đầu cuộn trang.

var prevScrollpos = window.pageYOffset;
window.addEventListener("scroll", () => {
    var currentScrollPos = window.pageYOffset;
    if (prevScrollpos > currentScrollPos) {
        document.getElementById("header").style.top = "0";
    } else {
        document.getElementById("header").style.top = "-70px";
    }
    prevScrollpos = currentScrollPos;
});

menu.addEventListener("click", () => {
    menu.classList.toggle("fa-times");
    navbar.classList.toggle("active");
});

// Đóng menu thả xuống nếu người dùng nhấp vào bên ngoài
window.addEventListener("click", (event) => {
    if (!event.target.matches(".drop-btn")) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains("show")) {
                openDropdown.classList.remove("show");
            }
        }
    }
});

window.addEventListener("scroll", () => {
    searchBtn.classList.remove("fa-times");
    searchBar.classList.remove("active");
    menu.classList.remove("fa-times");
    navbar.classList.remove("active");
    loginForm.classList.remove("active");
});

btnAddExam.addEventListener("click", () => {
    formAddExam.style.display = "block";
    btnAddExam.style.display = "none";
});

function search() {
    searchBtn.classList.toggle("fa-times");
    searchBar.classList.toggle("active");
}

formBtn.addEventListener("click", () => {
    loginForm.classList.add("active");
});

//formClose.addEventListener("click", () => {
//    loginForm.classList.remove("active");
//});

function dropContentAccount() {
    document
        .getElementById("dropDownContentAccount")
        .classList.toggle("show-account");
};

// Khi người dùng nhấp vào nút, chuyển đổi giữa ẩn và hiển thị nội dung thả xuống
function dropContent() {
    document.getElementById("dropDownContent").classList.toggle("show");
};




