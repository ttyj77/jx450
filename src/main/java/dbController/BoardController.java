package dbController;

import dbConn.ConnectionMaker;
import model.BoardDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardController {
    private Connection connection;
    private final int PAGE_SIZE = 10;

    public BoardController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(BoardDTO boardDTO) {
        String query = "insert into board(title,content,writerId, entry_date, modify_date) values (?,?,?,NOW(),NOW())";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, boardDTO.getTitle());
            pstmt.setString(2, boardDTO.getContent());
            pstmt.setInt(3, boardDTO.getWriterId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<BoardDTO> selectAll(int pageNo) {
        ArrayList<BoardDTO> list = new ArrayList<>();
        String query = "select * from board order by id desc limit ?,?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, (pageNo - 1) * PAGE_SIZE);
            pstmt.setInt(2, PAGE_SIZE); //총 몇페이지 출력 되는지
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                BoardDTO b = new BoardDTO();
                b.setId(resultSet.getInt("id"));
                b.setTitle(resultSet.getString("title"));
                b.setContent(resultSet.getString("content"));
                b.setWriterId(resultSet.getInt("writerId"));
                b.setEntryDate(resultSet.getTimestamp("entry_date"));
                b.setModifyDate(resultSet.getTimestamp("modify_date"));
                list.add(b);
            }

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    public BoardDTO selectOne(int id) {
        BoardDTO boardDTO = null;
        String query = "select * from board where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                boardDTO = new BoardDTO();
                boardDTO.setId(resultSet.getInt("id"));
                boardDTO.setTitle(resultSet.getString("title"));
                boardDTO.setContent(resultSet.getString("content"));
                boardDTO.setWriterId(resultSet.getInt("writerId"));
                boardDTO.setEntryDate(resultSet.getTimestamp("entry_date"));
                boardDTO.setModifyDate(resultSet.getTimestamp("modify_date"));

            }
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return boardDTO;

    }

    public void update(BoardDTO boardDTO) {
        String query = "update board set title = ?, content = ?, modify_date = NOW() where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, boardDTO.getTitle());
            pstmt.setString(2, boardDTO.getContent());
            pstmt.setInt(3, boardDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "delete from board where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public int countTotalPage() {
        int totalPage = 0;
        String query = "select count(*) from board";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            int count = 0;

            if (resultSet.next()){
                count = resultSet.getInt(1); //총 게시물 개수

            }
            totalPage = count/PAGE_SIZE;
            if (count % PAGE_SIZE !=0){
                totalPage ++; //게시물이 105개 라면 11페이지가 필요하다.
            }


            pstmt.close();
            resultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPage;
    }
}
