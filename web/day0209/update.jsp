<%@ page import="main.java.dbConn.ConnectionMaker" %>
<%@ page import="main.java.dbConn.MysqlConnectionMaker" %>
<%@ page import="main.java.dbController.StudentController" %>
<%@ page import="main.java.model.StudentDto" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-09
  Time: 오후 4:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학생 정보 수정하기</title>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    StudentController controller = new StudentController(connectionMaker.makeConnection());
    StudentDto studentDto = controller.selectOne(id);
%>
<form action="/day0209/update_action.jsp?id=<%=studentDto.getId()%>" method="post">
    <table>
        <tr>
            <td>번호 : <%=studentDto.getId()%>
            </td>
            <td>이름 : <%=studentDto.getName()%>
            </td>
            <td>국어 : <input type="text" value="<%=studentDto.getKorean()%>" name="korean"></td>
            <td>영어 : <input type="text" value="<%=studentDto.getEnglish()%>" name="english"></td>
            <td>수학 : <input type="text" value="<%=studentDto.getMath()%>" name="math"></td>
            <td>
                <button>수정하기</button>
            </td>
        </tr>
    </table>
</form>

</body>
</html>
