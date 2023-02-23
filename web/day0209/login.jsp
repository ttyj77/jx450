<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.UserController" %>
<%@ page import="model.UserDto" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-09
  Time: 오후 2:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    System.out.println(username);
    System.out.println(password);

    MysqlConnectionMaker connectionMaker = new MysqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    UserDto userDto = userController.auth(username, password);

    System.out.println(userDto);

    if (userDto == null){
        //특정 주소로 다시 이동하는 방법
        response.sendRedirect("/day0209/index.jsp");
    }else{
        response.sendRedirect("/day0209/printList.jsp");
    }
%>

</body>
</html>
