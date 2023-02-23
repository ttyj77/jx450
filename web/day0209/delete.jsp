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
    <title>Title</title>
</head>
<body>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    StudentController controller = new StudentController(connectionMaker.makeConnection());
    controller.deleteId(id);

    response.sendRedirect("/day0209/printList.jsp");

%>

</body>
</html>
