package dbController;

import dbConn.ConnectionMaker;
import model.ReplyDTO;

import java.sql.*;
import java.util.ArrayList;

public class ReplyController {

    private Connection connection;

    public ReplyController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(ReplyDTO replyDTO) {
        String query = "insert into reply (content, boardId,writerId, entry_date) values ( ?,?,?,NOW())";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, replyDTO.getContent());
            pstmt.setInt(2, replyDTO.getBoardId());
            pstmt.setInt(3, replyDTO.getWriterId());

            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<ReplyDTO> selectAll(int boardId) {
        ArrayList<ReplyDTO> temp = new ArrayList<>();
        String query = "select * from reply where boardId = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, boardId);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                ReplyDTO r = new ReplyDTO();
                r.setId(resultSet.getInt("id"));
                r.setContent(resultSet.getString("content"));
                r.setBoardId(resultSet.getInt("boardId"));
                r.setWriterId(resultSet.getInt("writerId"));
                r.setEntryDate(resultSet.getTimestamp("entry_date"));
                r.setModifyDate(resultSet.getTimestamp("modify_date"));
                temp.add(r);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    public ReplyDTO selectOne(int id) {
        ReplyDTO r = null;
        String query = "select * from reply where id =?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                r = new ReplyDTO();
                r.setId(resultSet.getInt("id"));
                r.setContent(resultSet.getString("content"));
                r.setBoardId(resultSet.getInt("boardId"));
                r.setWriterId(resultSet.getInt("writerId"));
                r.setEntryDate(resultSet.getTimestamp("entry_date"));
                r.setModifyDate(resultSet.getTimestamp("modify_date"));
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }

    public void update(ReplyDTO replyDTO) {
        String query = "update reply set content = ?, modify_date = NOW() where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, replyDTO.getContent());
            pstmt.setInt(2, replyDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "delete from reply where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}

