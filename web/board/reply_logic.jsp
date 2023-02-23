<%@ page import="model.BoardDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.BoardController" %>
<%@ page import="model.UserDto" %>
<%@ page import="model.ReplyDTO" %>
<%@ page import="dbController.ReplyController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오후 3:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <title>글 작성 로직</title>

</head>
<body>
<%
    UserDto logIn = (UserDto) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    }

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    ReplyController replyController = new ReplyController(connectionMaker);

    ReplyDTO r = new ReplyDTO();
    r.setWriterId(logIn.getId());
    r.setBoardId(Integer.parseInt(request.getParameter("boardId")));
    r.setContent(request.getParameter("content"));

    replyController.insert(r);
    response.sendRedirect("/board/printList.jsp");

%>

</body>
</html>
