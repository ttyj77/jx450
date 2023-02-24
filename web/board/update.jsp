<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/assets/js/board/update.js"></script>
    <script src="/assets/js%20library/build/ckeditor.js"></script>
    <%--    <script type="text/javascript" src="cke/ckeditor.js" charset="utf-8"></script>--%>


</head>

<body onload="initPage()">
<div class="container-fluid ">
    <div class="row vh-100 align-items-center" style="background-color: antiquewhite">
        <div class="col-10">
            <table class="table table-striped table-dark">
                <tr>
                    <th class="col-2">글번호</th>
                    <td class="col-10"><input type="text" id="input-id" disabled>
                    </td>
                </tr>
                <tr>
                    <th class="col-2">제목</th>
                    <td class="col-10"><input type="text" id="input-title">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="text-center">
                          <textarea name="content" id="editor">

                          </textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button class="btn btn-outline-success" onclick="updateBoard()">수정하기</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

</div>
</div>

<style>
    .ck-editor__editable {
        color: black;
        height: 400px;
    }
</style>

</body>
</html>
