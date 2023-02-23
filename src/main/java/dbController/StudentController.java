package dbController;

import model.StudentDto;

import java.sql.*;
import java.util.ArrayList;

public class StudentController {

    private ArrayList<StudentDto> list;

    static PreparedStatement pstmt = null;
    static Connection connection = null;
    static ResultSet resultSet = null;

    public StudentController(Connection connection) {
        list = new ArrayList<>();
        this.connection = connection;
    }

    public void terminate() throws SQLException {
        if (resultSet != null) {
            resultSet.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }

        if (connection != null) {
            connection.close();
        }

//        SCANNER.close();
    }

    //데이터 삽입
    public void insert(StudentDto s) {

        String query = "insert into student (name, korean, english, math) values(?,?,?,?)";

        try {
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, s.getName());
            pstmt.setInt(2, s.getKorean());
            pstmt.setInt(3, s.getEnglish());
            pstmt.setInt(4, s.getMath());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void update(StudentDto s) {
        String query = "UPDATE `student` SET `korean` = ?, `english` = ?, `math` = ? WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, s.getKorean());
            pstmt.setInt(2, s.getEnglish());
            pstmt.setInt(3, s.getMath());
            pstmt.setInt(4, s.getId());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            System.out.println("UPDATE ERROR!!!");
            e.printStackTrace();
        }
    }

    //데이터 업데이트
    public void updateId(int korean, int english, int math, int id) {
        String query = "update student set korean = ?, english = ?, math = ? where id = ?";

        try {
            pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, korean);
            pstmt.setInt(2, english);
            pstmt.setInt(3, math);
            pstmt.setInt(4, id);

            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void deleteId(int id) {

        String query = "delete from student  where id = ?";
        try {
            pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
            printList();
        } catch (SQLException e) {
            throw new RuntimeException();
        }
    }


    public ArrayList<StudentDto> printList() {
        String query = "select * from student";
        try {
            pstmt = connection.prepareStatement(query);
            resultSet = pstmt.executeQuery();

            list = selectAll(); //담긴다.
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            System.out.println(e);
            throw new RuntimeException();
        }
        return list;
    }

    public ArrayList<StudentDto> selectAll() {
        ArrayList<StudentDto> list = new ArrayList<>();

        String query = "SELECT * FROM `student`";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                StudentDto s = new StudentDto();
                s.setId(resultSet.getInt("id"));
                s.setName(resultSet.getString("name"));
                s.setKorean(resultSet.getInt("korean"));
                s.setEnglish(resultSet.getInt("english"));
                s.setMath(resultSet.getInt("math"));

                list.add(s);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            System.out.println("SELECTALL ERROR!!!");
            e.printStackTrace();
        }

        return list;
    }

    public StudentDto selectOne(int id) {
        String query = "select * from student where id = ?";

        try {
            pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                StudentDto s = new StudentDto();
                s.setId(resultSet.getInt("id"));
                s.setName(resultSet.getString("name"));
                s.setKorean(resultSet.getInt("korean"));
                s.setEnglish(resultSet.getInt("english"));
                s.setMath(resultSet.getInt("math"));

                return s;
            }

            resultSet.close();
            connection.close();

        } catch (SQLException e) {
            throw new RuntimeException();
        }

        return null;
    }





}
