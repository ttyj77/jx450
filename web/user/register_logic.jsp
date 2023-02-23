<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.UserController" %>
<%@ page import="dbController.BoardController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오전 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입 로직 페이지</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String nickname = request.getParameter("nickname");

    UserDto userDto = new UserDto();
    userDto.setUsername(username);
    userDto.setPassword(password);
    userDto.setNickname(nickname);

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    Boolean result = userController.insert(userDto);

    if (result) {
        response.sendRedirect("/index.jsp");
    } else {
%>
<script>
    alert("중복된 아이디로 가입하실 수 없습니다.")
    history.go(-1); //한페이지 뒤로 (1: 다음페이지로 - 앞페이지)

</script>
<%
    }
%>
</body>
</html>
