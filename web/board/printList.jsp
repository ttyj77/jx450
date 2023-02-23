<%@ page import="model.UserDto" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbController.BoardController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="dbController.UserController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/assets/js/board/printList.js"></script>
    <%--    <link rel="stylesheet" href="/assets/js/board/printList.css">--%>
</head>
<body onload="initPage()">
<div class="container-fluid">
    <div class="row vh-100 align-items-center">
        <%
            request.setCharacterEncoding("utf-8");
            //사용자가 로그인을 안했을경울 메인으로 튕기게
            UserDto logIn = (UserDto) session.getAttribute("logIn");
            if (logIn == null) {
                response.sendRedirect("/index.jsp");
            }

            int pageNo;
            try {
                String pageStr = request.getParameter("pageNo");
                pageNo = Integer.parseInt(pageStr);
            } catch (Exception e) {
                pageNo = 1;
            }


            ConnectionMaker connectionMaker = new MysqlConnectionMaker();
            BoardController controller = new BoardController(connectionMaker);
            UserController userController = new UserController(connectionMaker);

            ArrayList<BoardDTO> list = controller.selectAll(pageNo);

            int totalPage = controller.countTotalPage();

            int startNum;
            int endNum;
            if (pageNo < 4) { //pageNo은 선택한 페이지
                startNum = 1;
                endNum = 5;
            } else if (pageNo > totalPage - 3) { // 18이상   // 16 17 18 19 20
                startNum = totalPage - 4;
                endNum = totalPage;
            } else if (totalPage <= 5) {
                startNum = 1;
                endNum = totalPage;
            } else {
                startNum = pageNo - 2;
                endNum = pageNo + 2;
            }


//          우리가 el 에서 변수를 접근하기위해 page, session 에 저장해야 불러올 수 있다.
            pageContext.setAttribute("list", list);
            pageContext.setAttribute("userController", userController);
            pageContext.setAttribute("currentPage", pageNo);
            pageContext.setAttribute("startPage", startNum);
            pageContext.setAttribute("endPage", endNum);
            pageContext.setAttribute("totalPage", totalPage);

        %>
        <c:choose>
        <c:when test="${list.isEmpty()}">
            <div class="row">
                <div class="col-6">
                    <span> 아직 등록된 글이 존재하지 않습니다.</span>
                </div>
            </div>
        </c:when>
        <c:otherwise>
        <div class="row justify-content-center">
            <div class="col-10">
                <table class="table table-primary table-hover">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>수정일</th>
                    </tr>
                    </thead>
                    <tbody>

                    <tr>
                        <td colspan="5" class="text-center">
                            <ul class="pagination">
                                <li class="page-item" style="margin-left: 38%">
                                    <a class="page-link" href="/board/printList.jsp?pageNo=${1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                            <%--laquo 왼쪽 화살표--%>
                                        <span class="sr-only"></span>
                                    </a>
                                </li>
                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="page-item active">
                                                <a class="page-link" href="/board/printList.jsp?pageNo=${i}">${i}</a>
                                            </li>
                                        </c:when>

                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link"
                                                                     href="/board/printList.jsp?pageNo=${i}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="page-item">
                                    <a class="page-link" href="/board/printList.jsp?pageNo=${totalPage}"
                                       aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only"></span>
                                    </a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>

            </div>
            </c:otherwise>
            </c:choose>


        </div>
        <div class="row">
            <div class="col-11 text-end">
                <span class="btn btn-outline-info" onclick="location.href='/board/write.jsp'">글 작성하기</span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
