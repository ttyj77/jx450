package servlet.reply;

import com.google.gson.JsonArray;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;


@WebServlet(name = "selectAllServlet", value = "/reply/selectAll")
public class selectAllServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JsonObject object = new JsonObject();

        try {
            int boardId = Integer.parseInt(request.getParameter("boardId"));
            ConnectionMaker connectionMaker = new MysqlConnectionMaker();
            ReplyController replyController = new ReplyController(connectionMaker);
            UserController userController = new UserController(connectionMaker);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
            HttpSession session = request.getSession();
            UserDto logIn = (UserDto) session.getAttribute("logIn");
            ArrayList<ReplyDTO> list = replyController.selectAll(boardId);
            JsonArray array = new JsonArray();
            for (ReplyDTO r : list) {
                JsonObject temp = new JsonObject();

                temp.addProperty("id", r.getId());
                temp.addProperty("content", r.getContent());
                temp.addProperty("writer", userController.selectOne(r.getWriterId()).getNickname());
                if (r.getModifyDate() != null) {
                    temp.addProperty("date", sdf.format(r.getModifyDate()));
                } else {
                    temp.addProperty("date", sdf.format(r.getEntryDate()));
                }

                temp.addProperty("isOwned", logIn.getId() == r.getWriterId());

                array.add(temp);
            }
            object.addProperty("status", "success");
            object.addProperty("list", array.toString());
        } catch (Exception e) {
            object.addProperty("status", "fail");
        }

        PrintWriter writer = response.getWriter();
        writer.println(object);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

}
