package model;

public class MovieDTO {


    private String movieName;//영화 제목
    private int movieNum; //영화 번호,
    private String movieGrade; // 영화 등급
    private String story; //영화 줄거리

    public MovieDTO() {
    }




    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public int getMovieNum() {
        return movieNum;
    }

    public void setMovieNum(int movieNum) {
        this.movieNum = movieNum;
    }

    public String getMovieGrade() {
        return movieGrade;
    }

    public void setMovieGrade(String movieGrade) {
        this.movieGrade = movieGrade;
    }

    public String getStory() {
        return story;
    }

    public void setStory(String story) {
        this.story = story;
    }

    public MovieDTO(MovieDTO origin) {
        movieName = origin.movieName;
        movieGrade = origin.movieGrade;
        movieNum = origin.movieNum;
        story = origin.story;
    }

    public MovieDTO(int movieNum) {
        this.movieNum = movieNum;
    }

    public boolean equals(Object o) {
        if (o instanceof MovieDTO) {
            MovieDTO b = (MovieDTO) o;
            return movieNum == b.movieNum;
        }
        return false;
    }

}
