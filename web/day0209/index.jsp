<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>

<body>
<%--자바코드 사용가능 화면에는 안보인다.--%>
<%
    //jsp 에서 자바코드를 작설할 시에는 %태크를 사용하게되고 해당페이지에서 사용할 수 있는 변수를 단술출력할 시에는 %=태크를 사용하게 된다.
    int a = 3;
    int b = 7;
    int sum = a+ b;
%>
<%--출력할때는 아래와 같이 사용--%>
<%= sum %>
<form action="/day0209/login.jsp" method="post">
    <!--    % : 부모의 길의의 해당 퍼센트 만큼   rem : 1024px 1rem = 10.24 현재 길이의 1rem position: absolute 상대좌표 절대좌표-->

    <input type="text" name="username" id="username" placeholder="아이디" class="form-control"><br>

    <input type="password" name="password" id="password" placeholder="비밀번호" class="form-control"><br>
    <!--    <button style="width: 200px; height: 30px; color: green; background-color: darkseagreen; border: aliceblue">로그인
    </button>-->
    <!--    <button type="button" class="btn btn-primary btn-lg">Large button</button>-->
    <button class="btn btn-secondary btn-lg">
        로그인
    </button>
</form>
</body>
</html>
