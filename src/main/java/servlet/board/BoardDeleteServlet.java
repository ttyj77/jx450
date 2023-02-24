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


@WebServlet(name = "DeleteServlet", value = "/board/delete")
public class BoardDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject resp = new JsonObject();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String status = "";
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
            boardController.delete(id);
            System.out.println("board Delete");
            status = "success";
        } catch (Exception e) {
            status = "fail";
        }

        resp.addProperty("status", status);
        writer.println(resp);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

    }
}
