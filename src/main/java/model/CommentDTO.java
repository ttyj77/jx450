package model;


public class CommentDTO {
    private String comment; //댓글내용
    private int commentId; //글번호랑 일치

    private int writerId; //댓글 작성자 아이디

    private int id; //댓글 고유아이디

    public CommentDTO(CommentDTO c) {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        id = id;
    }

    public int getWriterId() {
        return writerId;
    }

    public void setWriterId(int writerId) {
        this.writerId = writerId;
    }

    public CommentDTO(BoardDTO boardDTO) {
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public CommentDTO(int id) {
        this.id = id;
    }

}
