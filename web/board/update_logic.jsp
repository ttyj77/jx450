<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.BoardController" %>
<%@ page import="model.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오후 3:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    UserDto logIn = (UserDto) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    }
    int id = Integer.parseInt(request.getParameter("id"));

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    BoardController boardController = new BoardController(connectionMaker);
    BoardDTO b = boardController.selectOne(id);


    if (b.getWriterId() != logIn.getId()) {
        response.sendRedirect("/board/printOne.jsp?id=" + id);
    }

    //정보 넘겨받는 부분
    b.setTitle(request.getParameter("title"));
    b.setContent(request.getParameter("content"));

    boardController.update(b);
    response.sendRedirect("/board/printOne.jsp?id=" + id);

%>
</body>
</html>
