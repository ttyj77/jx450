<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.BoardController" %>
<%@ page import="model.BoardDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="/assets/js%20library/build/ckeditor.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <%
        UserDto logIn = (UserDto) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }
        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        BoardController boardController = new BoardController(connectionMaker);
        BoardDTO b = boardController.selectOne(id);

        if (b.getWriterId() != logIn.getId()) { //작성자가 아니려면
            response.sendRedirect("/board/printOne.jsp?id=" + id);

        }

    %>
    <title><%=b.getTitle()%>> 글 수정하기</title>

</head>
<body>
<div class="container-fluid ">
    <div class="row vh-100 align-items-center" style="background-color: antiquewhite">
        <div class="row justify-content-center ">
            <div class="col-10">
                <form action="/board/update_logic.jsp?id=<%=id%>" method="post">
                    <table class="table table-striped table-dark">
                        <tr>
                            <th class="col-2">글번호</th>
                            <td><%=b.getId()%>
                            </td>
                        </tr>
                        <tr>
                            <th class="col-2">제목</th>
                            <td><input id="title" type="text" name="title" value="<%=b.getTitle()%>" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                          <textarea name="content" class="form-control" id="editor">
                                <%=b.getContent()%>
                          </textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button class="btn btn-outline-success">수정하기</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

    </div>
</div>
<script>
    ClassicEditor.create(document.querySelector('#editor')).catch(error => {
        console.log(error)

    })
    // let tag = document.querySelector(".form-control");
    let tag = document.getElementsByTagName("td");

    // tag[0].setAttribute("disabled","");
    // tag[0].removeAttribute("disabled")

    console.log(tag)

    console.log($('td').children(2))
    $('td').children(2).text("주희 ")
    $(('td')[0]).text("정후 ")
    $('input[name="title"]'.val("바꾼다"))

</script>

<style>
    .ck-editor__editable_inline {
        min-height: 300px;
        color: black;
    }


</style>
</body>
</html>
