<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.ReplyController" %>
<%@ page import="model.ReplyDTO" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-13
  Time: 오전 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    UserDto logIn = (UserDto) session.getAttribute("logIn");


    int id = Integer.parseInt(request.getParameter("id"));

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    ReplyController replyController = new ReplyController(connectionMaker);
    ReplyDTO replyDTO = replyController.selectOne(id);


    if (replyDTO.getWriterId() != logIn.getId()) {
        response.sendRedirect("/board/printList.jsp");
    }

    replyDTO.setContent(request.getParameter("content"));

    replyController.update(replyDTO);
    response.sendRedirect("/board/printList.jsp");
%>

</body>
</html>
