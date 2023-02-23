package model;
public class TheaterDTO {
    //      극장 번호, 극장 이름, 극장 위치, 극장 전화번호가 존재합니다.

    private int theaterNum;
    private String theaterName;
    private String theaterLC;
    private String theaterPhoneNumber;

    public int getTheaterNum() {
        return theaterNum;
    }

    public void setTheaterNum(int theaterNum) {
        this.theaterNum = theaterNum;
    }

    public String getTheaterName() {
        return theaterName;
    }

    public void setTheaterName(String theaterName) {
        this.theaterName = theaterName;
    }

    public String getTheaterLC() {
        return theaterLC;
    }

    public void setTheaterLC(String theaterLC) {
        this.theaterLC = theaterLC;
    }

    public String getTheaterPhoneNumber() {
        return theaterPhoneNumber;
    }

    public void setTheaterPhoneNumber(String theaterPhoneNumber) {
        this.theaterPhoneNumber = theaterPhoneNumber;
    }


    public TheaterDTO(TheaterDTO origin){
        theaterLC = origin.theaterLC;
        theaterName = origin.theaterName;
        theaterNum = origin.theaterNum;
        theaterPhoneNumber = origin.theaterPhoneNumber;
    }

    public TheaterDTO(int theaterNum){
        this.theaterNum = theaterNum;
    }
    public TheaterDTO(){

    }

    public boolean equals(Object o) {
        if (o instanceof TheaterDTO) {
            TheaterDTO b = (TheaterDTO) o;
            return theaterNum == b.theaterNum;
        }
        return false;
    }

}
