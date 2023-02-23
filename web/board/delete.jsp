<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="dbController.BoardController" %>
<%@ page import="java.lang.invoke.VolatileCallSite" %>
<%@ page import="model.ReplyDTO" %>
<%@ page import="dbController.ReplyController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오후 2:15
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
    if (logIn == null) {
        response.sendRedirect("/index.jsp"); //로그인을 안한경우
    }

    int id = Integer.parseInt(request.getParameter("id")); //글삭제 눌렀으면 boardId 댓글삭제 눌렀으면 replyID
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    BoardController boardController = new BoardController(connectionMaker);


    BoardDTO b = boardController.selectOne(id);
    if (b.getWriterId() == logIn.getId()) {
        boardController.delete(id);
    }


    response.sendRedirect("/board/printList.jsp");


%>
</body>
</html>
