package servlet.reply;

import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import dbController.ReplyController;
import dbController.UserController;
import model.ReplyDTO;
import model.UserDto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "ReplyServlet", value = "/reply/write")
public class ReplyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserDto logIn = (UserDto) session.getAttribute("logIn");
        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        ReplyController replyController = new ReplyController(connectionMaker);
        JsonObject object = new JsonObject();

        try {
            int boardId = Integer.parseInt(request.getParameter("boardId"));
            int writerId = logIn.getId();
            String content = request.getParameter("content");

            ReplyDTO r = new ReplyDTO();
            r.setWriterId(writerId);
            r.setBoardId(boardId);
            r.setContent(content);


            replyController.insert(r);

            object.addProperty("status", "success");
        } catch (Exception e) {
            object.addProperty("status", "fail");
        }


        PrintWriter writer = response.getWriter();
        writer.println(object);


    }

}
