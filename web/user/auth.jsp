<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.UserController" %>
<%@ page import="model.UserDto" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오전 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    UserDto userDto = userController.auth(username, password);

    String address;

    if (userDto == null) { //로그인 실패
        address = "/index.jsp";
    } else { //로그인 성공
        address = "/board/printList.jsp";

        session.setAttribute("logIn",userDto); //session의 값 저장

    }

    response.sendRedirect(address);
    //서버 내장메모리 session이라는 곳에 데이터를 저장시켜줄꺼다.
    //session은 공용적인 공간이 아니라 a,b 들이 접속했을 때 각각 다른 session 을 가지게 된다.
    //일반적으로 20분정도 session이 유지가 된다.


%>

</body>
</html>


