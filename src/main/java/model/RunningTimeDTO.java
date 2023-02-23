package model;
public class RunningTimeDTO {
//    상영정보 번호, 영화 번호, 극장 번호, 상영 시간이 존재합니다.
//      단, 상영 시간의 경우, String을 사용하여 해당 영화가 몇시부터
//      몇시까지 상영되는지를 보여줍니다.(시간 관련 클래스 객체 사용할 필요 없음)

    private int RTNUmber; //상영번호
    private int movieNum;//영화 번호
    private int theaterNum; // 극장번호
    private String RTime; //상영시간

    public int getRTNUmber() {
        return RTNUmber;
    }

    public void setRTNUmber(int RTNUmber) {
        this.RTNUmber = RTNUmber;
    }

    public int getMovieNum() {
        return movieNum;
    }

    public void setMovieNum(int movieNum) {
        this.movieNum = movieNum;
    }

    public int getTheaterNum() {
        return theaterNum;
    }

    public void setTheaterNum(int theaterNum) {
        this.theaterNum = theaterNum;
    }

    public String getRTime() {
        return RTime;
    }

    public void setRTime(String RTime) {
        this.RTime = RTime;
    }

    public RunningTimeDTO(int RTNUmber){
        this.RTNUmber = RTNUmber;
    }

    public RunningTimeDTO(RunningTimeDTO origin){
        RTime = origin.RTime;
        RTNUmber = origin.RTNUmber;
        movieNum = origin.movieNum;
        theaterNum = origin.theaterNum;
    }

    public RunningTimeDTO(){

    }

    public boolean equals(Object o) {
        if (o instanceof RunningTimeDTO) {
            RunningTimeDTO b = (RunningTimeDTO) o;
            return RTNUmber == b.RTNUmber;
        }
        return false;
    }

}
