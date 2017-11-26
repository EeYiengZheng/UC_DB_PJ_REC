package main.java.helpers.scraper;

public class CourseName {
    private String courseName;

    public CourseName(String courseName) {
        this.courseName = courseName;
    }
    public CourseName() {}
    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    @Override
    public String toString() {
        return courseName;
    }
}
