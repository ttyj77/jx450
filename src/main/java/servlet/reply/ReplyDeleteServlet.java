package servlet.reply;

import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import dbController.ReplyController;
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


@WebServlet(name = "ReplyDeleteServlet", value = "/reply/delete")
public class ReplyDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String status = "";
        JsonObject object = new JsonObject();
        PrintWriter writer = response.getWriter();


        try {
            HttpSession session = request.getSession();
            UserDto logIn = (UserDto) session.getAttribute("logIn");
            ConnectionMaker connectionMaker = new MysqlConnectionMaker();
            ReplyController replyController = new ReplyController(connectionMaker);

            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println(id);
            ReplyDTO temp = replyController.selectOne(id);
            if (temp == null || temp.getWriterId() != logIn.getId()) {
                throw new NullPointerException();
            }

            replyController.delete(id);

            status = "success";

        } catch (Exception e) {
            status = "fail";
        }

        object.addProperty("status", status);

        writer.println(object);


    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}