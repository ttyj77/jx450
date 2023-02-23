<%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오전 10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

    <script>

        let result = false;

        function validateUsername(username) {
            var data = {
                "username": username
            };

            if (username.length >= 5) {
                return true;
            }

            $.ajax({
                url: "/user/validate",
                type: "get",
                data: data,
                success: function (message) {
                    let jsonResult = JSON.parse(message) //json 객체로 만들어주기
                    let result = message.message;
                    console.log(typeof jsonResult);
                    if (!jsonResult.result) {
                        Swal.fire({title:'error', text:jsonResult.message});
                    }
                }
            });

            return false;
        }

        function validatePassword(password) {
            if (password.includes('!')) {
                return true;

            }
            return false;
        }

        function validateInput() {
            let username = document.getElementById("username").value
            let password = document.getElementById("password").value
            result = validateUsername(username) && validatePassword(password)

            if (result) {
                document.forms[0].submit();
            } else {
                Swal.fire({title: "!!!오류다 !!!.", text: "잘못입력하셨습니다.", icon: 'error'});
            }
        }
    </script>

</head>

<body>
<div class="container-fluid">
    <div class="row vh-100 align-items-center text-center" style="background-color: cornflowerblue;">
        <!--    -div 태그는 일종의 역역을 지정하는 것이다. 화면 전체를 이 디브태그로 지정할꺼야-->
        <div class="row justify-content-center">
            <form action="/user/register_logic.jsp" method="post">
                <div class="row justify-content-center" style="margin-bottom: 2%">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" id="username" name="username" class="form-control" placeholder="아이디"
                            >
                            <label for="username">아이디</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" id="password" name="password" class="form-control" placeholder="비밀번호"
                            >
                            <label for="password">비밀번호</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" id="nickname" name="nickname" class="form-control" placeholder="닉네임">
                            <label for="nickname">닉네임</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center" style="margin-top: 2%">
                    <div class="btn btn-outline-primary col-6 m-1" onclick="validateInput()">회원가입</div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
