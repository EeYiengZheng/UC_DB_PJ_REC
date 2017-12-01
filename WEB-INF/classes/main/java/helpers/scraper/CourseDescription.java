package main.java.helpers.scraper;

public class CourseDescription {
    private String courseDescription;

    public CourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }
    public CourseDescription() {}
    public String getCourseDescription() {
        return courseDescription;
    }

    public void setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }

    @Override
    public String toString() {
        return courseDescription;
    }
}
