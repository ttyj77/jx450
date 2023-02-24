<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.ReplyController" %>
<%@ page import="model.ReplyDTO" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-13
  Time: 오전 10:57
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


    int id = Integer.parseInt(request.getParameter("id")); //댓글삭제 눌렀으면 replyID
    System.out.println(id + "=================================");
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    ReplyController replyController = new ReplyController(connectionMaker);


    ReplyDTO r = replyController.selectOne(id);
    if (r.getWriterId() == logIn.getId()) { //댓글 작성자
        replyController.delete(id);
    }
    response.sendRedirect("/board/printList.jsp");


%>
</body>
</html>
