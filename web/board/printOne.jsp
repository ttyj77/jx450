<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.BoardController" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="dbController.UserController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dbController.ReplyController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ReplyDTO" %>
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

    <%
        request.setCharacterEncoding("UTF-8");
        UserDto logIn = (UserDto) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        BoardController boardController = new BoardController(connectionMaker);
        UserController userController = new UserController(connectionMaker);
        ReplyController replyController = new ReplyController(connectionMaker);
        SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");
        BoardDTO b = boardController.selectOne(id); //여기서 id는 boardId
//        ReplyDTO r = replyController.selectOne(id); //여기서 아이디는 댓글아이디가 필요하다.


        ArrayList<ReplyDTO> list = replyController.selectAll(b.getId()); //댓글리스트

    %>
    <%--    <c:set var="loginId" value="<%=logIn.getId()%>"/>--%>
    <%--    <c:set var="writerId" value="<%=b.getWriterId()%>"/>--%>
    <%--변수선언--%>
    <c:set var="b" value="<%=b%>"/>
    <%--    <c:set var="r" value="<%=r%>"/>--%>
    <c:set var="logIn" value="<%=logIn%>"/>
    <c:set var="selectOne" value="<%=userController.selectOne(b.getWriterId())%>"/>
    <c:set var="list" value="<%=list%>"/>

    <script>
        function confirmDelete() {
            let result = confirm("삭제하시겠습니까?");
            if (result) {
                location.href = "/board/delete.jsp?id=" +
                <%=b.getId()%>
            }
        }

        function confirmDeleteReply(id) {

            let result = confirm("삭제하시겠습니까?");
            console.log(id)
            if (result) {
                location.href = "/reply/delete.jsp?id=" + id
            }
        }

    </script>
    <title><%=b.getTitle()%>></title>
</head>
<body>
<div class="container-fluid ">
    <div class="row vh-100 align-items-center" style="background-color: antiquewhite">
        <div class="row justify-content-center ">
            <div class="col-10">
                <table class="table table-striped table-dark" id="boardTable">
                    <tr>
                        <th class="col-2">글번호</th>
                        <td class="col-10">
                            ${b.id}
                        </td>
                    </tr>
                    <tr>
                        <th class="col-2">제목</th>
                        <td>${b.title}
                        </td>
                    </tr>
                    <tr>
                        <th class="col-2">작성자</th>
                        <td>${selectOne.nickname}
                        </td>
                    </tr>
                    <tr>
                        <th class="col-2">작성일</th>
                        <td><fmt:formatDate value="${b.entryDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/>
                        </td>
                    </tr>
                    <tr class="mb-2">
                        <th class="col-2">수정일</th>
                        <td><fmt:formatDate value="${b.modifyDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">
                            ${b.content}
                        </td>
                    </tr>

                    <c:if test="${b.writerId eq logIn.id}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <div class="btn btn-outline-success"
                                     onclick="location.href='/board/update.jsp?id=<%=b.getId()%>'">수정하기
                                </div>
                                <div class="btn btn-outline-danger" onclick="confirmDelete()">삭제하기</div>
                            </td>
                        </tr>
                    </c:if>
                    <tr id="tr-new-row">
                        <td colspan="2" class="text-end" onclick="addNewRow()">
                            새 줄 추가하기
                        </td>
                    </tr>
                </table>

                <section class="mb-5; mt-4">
                    <div class="card-body">
                        <c:forEach var="r" items="${list}">
                            <div class="d-flex mb-4" style="justify-content: space-between;">
                                <div><!-- Parent comment -->
                                    <div class="flex-shrink-0" style="float: left"><img
                                            class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
                                            alt="..."></div>
                                    <div class="ms-3" style="float: left">
                                        <div>
                                            <h6 style="float: left">작성자 ID : </h6>
                                            <div><h6> ${r.writerId}</h6></div>
                                                ${r.content}
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <c:if test="${r.writerId eq logIn.id}">
                                        <div class="btn btn-outline-success" style="float: right; margin-left: 10px"
                                             onclick="location.href='/reply/update.jsp?id=${r.id}'">수정하기
                                                <%--                                            <input type="hidden" name="boardId" value="<%=b.getId()%>">--%>
                                        </div>
                                        <div class="btn btn-outline-danger" style="float:right;"
                                             onclick=" location.href='/reply/delete.jsp?id=${r.id}'">삭제하기
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                        </c:forEach>
                        <!-- Comment form-->

                        <div class="row">
                            <div class="col-12 text-end">
                                <form class="mb-4" method="post" action="/board/reply_logic.jsp">
                                    <textarea
                                            class="form-control" rows="3" name="content"
                                            placeholder="댓글을 입력해주세요!"></textarea>
                                    <%--                                    <input type="text" name="boardId"    value="<%=b.getId()%>">--%>
                                    <input type="hidden" name="boardId" value="<%=b.getId()%>" class="form-control">
                                    <button class="btn btn-outline-success" style="margin-top: 15px "> 댓글등록하기</button>
                                </form> <!-- Comment with nested comments-->
                                <%--board 아이디 보내야 되는데--%>

                            </div>

                        </div>
                    </div>
                </section>
            </div>
        </div>

    </div>
</div>
<script>
    let addNewRow = () => { //arrow function expression
        let table = document.getElementById("boardTable")
        let newRow = document.getElementById("tr-new-row")
        table.children[0].removeChild(newRow)

        console.log(table.children)
        console.log(table.children[0].children)
        //     children[0] == tbody
        let tr = document.createElement("tr");
        let td = document.createElement("td");
        td.colSpan = 2;
        tr.appendChild(td);
        table.children[0].appendChild(tr)
        table.children[0].appendChild(newRow); //코드로 추가됨

        // let newTr = "<tr><td>새로 추가된 줄 ! </td></tr>"
        // table.children[0].append(newTr); //text 로 추가됨
        table.children[0].appendChild(newRow); //코드로 추가됨
    }

</script>
</body>
</html>
