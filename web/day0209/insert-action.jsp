<%@ page import="main.java.dbConn.MysqlConnectionMaker" %>
<%@ page import="main.java.dbController.StudentController" %>
<%@ page import="main.java.model.StudentDto" %>
Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-09
  Time: 오후 5:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String name = request.getParameter("name");
    int korean = Integer.parseInt(request.getParameter("korean"));
    int english = Integer.parseInt(request.getParameter("english"));
    int math = Integer.parseInt(request.getParameter("math"));

    main.java.dbConn.ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    main.java.dbController.StudentController controller = new StudentController(connectionMaker.makeConnection());
    main.java.model.StudentDto studentDto = new StudentDto();

    studentDto.setName(name);
    studentDto.setKorean(korean);
    studentDto.setEnglish(english);
    studentDto.setMath(math);
    controller.insert(studentDto);

    response.sendRedirect("/day0209/printList.jsp");
%>
</body>
</html>
