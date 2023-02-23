package model;

public class ReviewDTO {
//      평점 번호, 작성 회원 번호, 영화 번호, 평점, 평론이 존재합니다.
//      평론의 경우, 작성하는 회원이 전문 평론가일 경우에만 작성 가능하고,
//      일반 회원은 평점만 등록 가능합니다.

    private int reviewNum; //평점 번호,
    private int userNum; //회원번호
    private int movieNum; //영화 번호
    private int rating; //평점
    private String review; //평론


    public int getReviewNum() {
        return reviewNum;
    }

    public void setReviewNum(int reviewNum) {
        this.reviewNum = reviewNum;
    }

    public int getUserNum() {
        return userNum;
    }

    public void setUserNum(int userNum) {
        this.userNum = userNum;
    }

    public int getMovieNum() {
        return movieNum;
    }

    public void setMovieNum(int movieNum) {
        this.movieNum = movieNum;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public ReviewDTO(ReviewDTO origin){
        review = origin.review;
        rating = origin.rating;
        userNum = origin.userNum;
        movieNum = origin.movieNum;
        reviewNum = origin.reviewNum;
    }
    public ReviewDTO(){

    }

    public boolean equals(Object o) {
        if (o instanceof ReviewDTO) {
            ReviewDTO b = (ReviewDTO) o;
            return reviewNum == b.reviewNum;
        }
        return false;
    }
    public ReviewDTO(int reviewNum){
        this.reviewNum = reviewNum;
    }



}
