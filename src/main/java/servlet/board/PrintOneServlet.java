package servlet.board;

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
import java.text.SimpleDateFormat;


@WebServlet(name = "PrintOneServlet", value = "/board/printOne")
public class PrintOneServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        BoardController boardController = new BoardController(connectionMaker);
        UserController userController = new UserController(connectionMaker);
        String message = "";
        String nextPath = "";


        try {
            UserDto logIn = (UserDto) session.getAttribute("logIn");



            int id = Integer.parseInt(request.getParameter("id"));

            BoardDTO boardDTO = boardController.selectOne(id);
            if (boardDTO == null) {
                message = "유효하지 않ㅅ은 글번호 입니다.";
                nextPath = "/board/printList.jsp?pageNo=1";
                throw new NullPointerException();
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");
            JsonObject boardJson = new JsonObject();
            boardJson.addProperty("id", boardDTO.getId());
            boardJson.addProperty("title", boardDTO.getTitle());
            boardJson.addProperty("writerNickname", userController.selectOne(boardDTO.getWriterId()).getNickname());
            boardJson.addProperty("entryDate", sdf.format(boardDTO.getEntryDate()));
            boardJson.addProperty("modifyDate", sdf.format(boardDTO.getModifyDate()));
            boardJson.addProperty("content", boardDTO.getContent());

            boardJson.addProperty("isOwned", boardDTO.getWriterId() == logIn.getId()); //작성자와 로그인중인 사용자 일치여부 확인!
            object.addProperty("status", "success");
            object.addProperty("data", boardJson.toString());
        } catch (NullPointerException e) {
            System.out.println("에러 페이지");
            object.addProperty("status", "fail");
            object.addProperty("message", message);
            object.addProperty("nextPath", nextPath);


        } catch (Exception e) {
            //integet Parse int 못하거나 완전 다른 오류가 발생했을 때 빠질 수 있게
            message = "오류가 발생했습니다.";
            nextPath = "/board/printList.jsp?pageNo=1";
            object.addProperty("status", "fail");
            object.addProperty("message", message);
            object.addProperty("nextPath", nextPath);
        }
        writer.println(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        ConnectionMaker connectionMaker = new MysqlConnectionMaker();

    }
}
