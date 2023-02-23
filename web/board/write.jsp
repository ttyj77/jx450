<%@ page import="model.UserDto" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-10
  Time: 오후 3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
<script src="/assets/js%20library/build/ckeditor.js"></script>
<%
    UserDto logIn = (UserDto) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    }
%>
<title> 글 작성하기</title>

</head>
<body>
<div class="container-fluid ">
    <div class="row vh-100 align-items-center" style="background-color: antiquewhite">
        <div class="row justify-content-center ">
            <div class="col-10">
                <form action="/board/write_logic.jsp" method="post">
                    <table class="table table-striped table-dark">
                        <tr>
                            <th class="col-2">제목</th>
                            <td><input type="text" name="title" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                <textarea id="editor" name="content"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button class="btn btn-outline-success">작성하기</button>
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


</script>

<style>
    .ck-editor__editable_inline {
        min-height: 300px;
        color: black;
    }
</style>
</body>
</html>
