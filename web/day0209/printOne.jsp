<%@ page import="main.java.dbConn.MysqlConnectionMaker" %>
<%@ page import="main.java.dbController.StudentController" %>
<%@ page import="main.java.model.StudentDto" %>
<%@ page import="main.java.dbConn.ConnectionMaker" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-09
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
    %>
    <title>개별학생보기</title>
    <script>
        function showConfirm() {
            let result = confirm("정말로 삭제하시겠습니까?")
            if (result) {
                //주소를 가지고 놀 수있다.
                location.href = "/day0209/delete.jsp?id=" +
                <%=id%>
            } else {

            }
        }
    </script>

    <style>
        /*selector 특정 아이디,클래스를 가진 태그를 가진 선택자를 셀렉터라고 부른다.*/
        /*

        */
        table {
            border: solid 2px black;
        }

        /*table tr{*/
        /*    border-bottom: greenyellow;*/
        /*}*/
        /*    클래스 선택하기   "." 붙이기 */
        .info_row {
            font-size: 20px;
            color: mediumpurple;
        }

        /*    id로 지정하기  해당페이지에서 해당아이디를 가진 친구는 하나만 존재해야된다.   "#"붙이기  */
        #a-update{
            font-size: 25px;
            color: cornflowerblue;
            border: solid 2px lightpink;
        }
        /*tr태그안에 info-row가 아닌 */
        tr.selection_row{
            font-size: 25px;
            color: darkslategrey;
        }

        /*특정 태그 안에 특정 태그 선택하기*/
        tr td{
            border: dotted 1px yellowgreen;
        }

    </style>


</head>
<body>
<%
    id = Integer.parseInt(request.getParameter("id"));
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    StudentController controller = new StudentController(connectionMaker.makeConnection());
    StudentDto studentDto = controller.selectOne(id);
    int sum = studentDto.getKorean() + studentDto.getEnglish() + studentDto.getMath();
    double average = (double) sum / 3.0;
%>

<table>
    <tr class="info_row">
        <td>번호 : <%=studentDto.getId()%> 번</td>
        <td>이름 : <%=studentDto.getName()%>
        </td>
    </tr>
    <tr class="info_row">
        <td>국어 : <%=studentDto.getKorean()%> 점</td>
        <td>영어 : <%=studentDto.getEnglish()%> 점</td>
        <td>수학 : <%=studentDto.getMath()%> 점</td>
    </tr>

    <tr class="info_row">
        <td>총점 : <%=sum%> 점</td>
        <td>평균 : <%=average%> 점</td>
    </tr>

    <tr class="selection_row">
        <td><a href="/day0209/update.jsp?id=<%=studentDto.getId()%>" id="a-update">수정</a></td>
        <td><a onclick="showConfirm();">삭제</a></td>
    </tr>
</table>

</body>
</html>
