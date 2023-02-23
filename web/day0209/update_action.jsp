<%@ page import="main.java.dbConn.ConnectionMaker" %>
<%@ page import="main.java.dbConn.MysqlConnectionMaker" %>
<%@ page import="main.java.dbController.StudentController" %>
<%@ page import="main.java.model.StudentDto" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-09
  Time: 오후 4:16
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
  int korean = Integer.parseInt(request.getParameter("korean"));
  int english = Integer.parseInt(request.getParameter("english"));
  int math = Integer.parseInt(request.getParameter("math"));
  ConnectionMaker connectionMaker = new MysqlConnectionMaker();
  StudentController controller = new StudentController(connectionMaker.makeConnection());
  StudentDto studentDto = controller.selectOne(id);
  studentDto.setKorean(korean);
  studentDto.setEnglish(english);
  studentDto.setMath(math);
  controller.update(studentDto);

  response.sendRedirect("/day0209/printOne.jsp?id="+id);
%>

</body>

</html>
