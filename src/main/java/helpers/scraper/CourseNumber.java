package main.java.helpers.scraper;

public class CourseNumber {
    private String fullCourseNumber;

    public CourseNumber(String fullCourseNumber) {
        this.fullCourseNumber = fullCourseNumber;
    }
    public CourseNumber() {}
    public String getFullCourseNumber() {
        return fullCourseNumber;
    }

    public void setFullCourseNumber(String fullCourseNumber) {
        this.fullCourseNumber = fullCourseNumber;
    }

    @Override
    public String toString() {
        return fullCourseNumber;
    }
}
