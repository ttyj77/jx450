package servlet;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import dbController.BoardController;
import dbController.UserController;
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
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;


@WebServlet(name = "BoardPrintListServlet", value = "/board/printList")
public class BoardPrintListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDto logIn = (UserDto) session.getAttribute("logIn");

        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        BoardController boardController = new BoardController(connectionMaker);
        UserController userController = new UserController(connectionMaker);
        SimpleDateFormat sdf = new SimpleDateFormat("y/M/d");

        JsonArray array = new JsonArray();

        int pageNo = Integer.parseInt(request.getParameter("pageNo"));
        ArrayList<BoardDTO> list = boardController.selectAll(pageNo);
        for (BoardDTO b : list) {
            JsonObject object = new JsonObject();
            object.addProperty("id", b.getId());
            object.addProperty("title", b.getTitle());
//            object.addProperty("content", b.getContent());
            object.addProperty("writerNickname", userController.selectOne(b.getWriterId()).getNickname());
            object.addProperty("modifyDate", sdf.format(b.getModifyDate()));
            object.addProperty("entryDate", sdf.format(b.getEntryDate()));
            array.add(object);

        }
        JsonObject result = new JsonObject();
        result.addProperty("result", "success");
        result.addProperty("data", array.toString());


        PrintWriter writer = response.getWriter();
        writer.println(result);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
