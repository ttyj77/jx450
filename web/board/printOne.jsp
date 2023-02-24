<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%--태그 라이브러리 연동--%>
<html>
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/assets/js/board/printOne.js"></script>
    <script src="/assets/js/reply/replyUtil.js"></script>

</head>
<body onload="initPage()">
<div class="container-fluid">
    <div class="row justify-content-center vh-100 align-items-center">
        <div class="row justify-content-center">
            <div class="col-10">
                <table class="table table-striped table-info" id="table-board">
                    <tr>
                        <td>글번호</td>
                        <td id="td-id"></td>
                    </tr>
                    <tr>
                        <td>글제목</td>
                        <td id="td-title"></td>
                    </tr>
                    <tr>
                        <td>글 작성자</td>
                        <td id="td-writer"></td>
                    </tr>
                    <tr>
                        <td>글 작성일</td>
                        <td id="td-entry-date"></td>
                    </tr>
                    <tr>
                        <td>글 수정일</td>
                        <td id="td-modify-date"></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">내용</td>
                    </tr>
                    <tr>
                        <td colspan="2" id="td-content"></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">댓글</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table class="table table-light table-striped" id="table-reply">
                                <tbody id="tbody-reply">


                                <tr>
                                    <td>
                                        <input type="text" class="form-control" id="input-reply">
                                    <td>
                                        <div class="btn btn-outline-secondary w-100" onclick="writeReply()"> 등록</div>
                                    </td>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
