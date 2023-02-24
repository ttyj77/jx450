package servlet.board;

import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import dbController.BoardController;
import model.BoardDTO;
import model.UserDto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "UpdateServlet", value = "/board/update")
public class updateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = "";
        String nextpath = "";
        String message = "";
        JsonObject object = new JsonObject();
        PrintWriter printWriter = response.getWriter();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println("update");
        try {

            HttpSession session = request.getSession();
            UserDto logIn = (UserDto) session.getAttribute("logIn");

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MysqlConnectionMaker();
            BoardController boardController = new BoardController(connectionMaker);
            BoardDTO b = boardController.selectOne(id);
            if (b == null || b.getWriterId() != logIn.getId()) {
                throw new NullPointerException();

            }
            b.setTitle(request.getParameter("title"));
            b.setContent(request.getParameter("content"));

            boardController.update(b);

            status = "success";
            nextpath = "/board/printOne.jsp?id=" + id;
            message = "성공적으로 수정되었습니다.";

        } catch (Exception e) {
            status = "error";
            nextpath = "/board/printList.jsp?id=1";
            message = "오류가 발생했습니다.";
        }

        object.addProperty("status", status);
        object.addProperty("nextPath", nextpath);

        printWriter.println(object);
    }
}
