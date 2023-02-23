<%@ page import="main.java.dbConn.ConnectionMaker" %>
<%@ page import="main.java.dbConn.MysqlConnectionMaker" %>
<%@ page import="main.java.dbController.StudentController" %>
<%@ page import="main.java.model.StudentDto" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-09
  Time: 오후 5:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    StudentController controller = new StudentController(connectionMaker.makeConnection());


%>
<form action="/day0209/insert-action.jsp" method="post">
    <table>
        <tr>

            <input type="text" name="name" id="name" placeholder="이름을 입력해주세요" class="form-control"><br>
            <input type="text" name="korean" id="korean" placeholder="국어점수룰 입력해주세요" class="form-control"><br>
            <input type="text" name="english" id="english" placeholder="영어점수를 입력해주세요" class="form-control"><br>
            <input type="text" name="math" id="math" placeholder="수학점수를 입력해주세요" class="form-control"><br>

            <td>
                <button>등록하기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
