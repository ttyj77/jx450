<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.BoardController" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="dbController.ReplyController" %>
<%@ page import="model.ReplyDTO" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오후 2:32
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <%

        request.setCharacterEncoding("UTF-8");
        UserDto logIn = (UserDto) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }


        int id = Integer.parseInt(request.getParameter("id"));


        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        ReplyController replyController = new ReplyController(connectionMaker);
        BoardController boardController = new BoardController(connectionMaker);
//        BoardDTO boardDTO = boardController.selectOne(boardId);
        ReplyDTO r = replyController.selectOne(id);

        if (r.getWriterId() != logIn.getId()) { //작성자가 아니려면
            response.sendRedirect("/board/printList.jsp");

        }

    %>
    <title><%=r.getWriterId()%>> 댓글 수정하기</title>

</head>
<body>
<div class="row">
    <div class="col-12 text-end">
        <form class="mb-4" method="post" action="/reply/update_logic.jsp?id=<%=id%>">
            <input type="text" value= <%=r.getId()%>> 글번호 </input>
            <textarea
                    class="form-control" rows="3" name="content"
                    placeholder="댓글을 입력해주세요!"></textarea>
            <button class="btn btn-outline-success"> 댓글등록하기</button>
        </form> <!-- Comment with nested comments-->
        <%--board 아이디 보내야 되는데--%>

    </div>

</div>

</body>
</html>
