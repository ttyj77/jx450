<%@ page import="java.util.ArrayList" %>
<%@ page import="main.java.dbController.StudentController" %>
<%@ page import="main.java.model.StudentDto" %>
<%@ page import="main.java.dbConn.MysqlConnectionMaker" %>
<%@ page import="main.java.dbConn.ConnectionMaker" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학생목록</title>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    StudentController controller = new StudentController(connectionMaker.makeConnection());
    ArrayList<StudentDto> list = controller.selectAll();
%>
<table>
    <tr>
        <td>번호</td>
        <td>이름</td>
    </tr>
    <%
        for(StudentDto s : list) {
    %>
    <tr>
        <td><%=s.getId()%></td>
        <td><a href="/day0209/printOne.jsp?id=<%=s.getId()%>"><%=s.getName()%></a></td>
    </tr>
    <%
        }
    %>

</table>
<form method="post" action="/day0209/insert.jsp">
    <button class="btn btn-secondary btn-lg">
        학생추가하기
    </button>
</form>

</body>
</html>
