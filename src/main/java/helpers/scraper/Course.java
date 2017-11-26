package main.java.helpers.scraper;

public class Course<Department, CourseNumber, CourseName, CourseDescription, Unit> {
    private Department department;
    private CourseNumber courseNumber;
    private CourseName courseName;
    private CourseDescription courseDescription;
    private Unit units;

    public Course(Department department, CourseNumber courseNumber, CourseName courseName, CourseDescription courseDescription, Unit units) {
        this.department = department;
        this.courseNumber = courseNumber;
        this.courseName = courseName;
        this.courseDescription = courseDescription;
        this.units = units;
    }

    public Course() {

    }

    public CourseDescription getCourseDescription() {
        return courseDescription;
    }

    public CourseName getCourseName() {
        return courseName;
    }

    public CourseNumber getCourseNumber() {
        return courseNumber;
    }

    public Department getDepartment() {
        return department;
    }

    public Unit getUnits() {
        return units;
    }

    public void setCourseDescription(CourseDescription courseDescription) {
        this.courseDescription = courseDescription;
    }

    public void setCourseName(CourseName courseName) {
        this.courseName = courseName;
    }

    public void setCourseNumber(CourseNumber courseNumber) {
        this.courseNumber = courseNumber;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public void setUnits(Unit units) {
        this.units = units;
    }

    @Override
    public String toString() {
        return department.toString() + " " + courseNumber.toString() + ": " + courseName.toString() + " (" + units.toString() + " units)";
    }
}

