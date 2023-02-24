package servlet.board;

import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import dbController.UserController;
import model.UserDto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "AuthServlet", value = "/user/auth")
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDto userDto = userController.auth(username, password);

        JsonObject result = new JsonObject();
        if (userDto != null) {
            //session 접근
            HttpSession session = request.getSession();
            session.setAttribute("logIn", userDto);
            result.addProperty("result", "success");

        } else {
            result.addProperty("result", "false");
        }
        PrintWriter writer = response.getWriter();
        writer.print(result);
    }
}
