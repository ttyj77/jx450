package servlet.board;

import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import dbController.UserController;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "UserValidate", value = "/user/validate")
public class UserValidateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);

        String username = request.getParameter("username");
        boolean result = userController.ValidateUsername(username);
        String message;
        if (result) {
            message = "회원가입 가능";
        } else {
            message = "중복 된 아이디 입니다.";
        }
        PrintWriter writer = response.getWriter();

        //json 형식으로 만들어서 넣어줘야 된다.
        JsonObject object = new JsonObject();
        object.addProperty("status", "200");
        object.addProperty("result", result);
        object.addProperty("message", message);

        writer.print(object);

    }

}
