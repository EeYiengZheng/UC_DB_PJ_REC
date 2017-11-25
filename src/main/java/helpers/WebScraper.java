package main.java.helpers;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * scrape all SJSU courses
 */
public class WebScraper {
    public static void main(String[] args) throws IOException, InterruptedException {
        List<Course> allCourses = new ArrayList<>();

        String base = "http://info.sjsu.edu";
        String homeURL = base + "/web-dbgen/catalog/departments/all-departments.html";
        Document doc = Jsoup.connect(homeURL).get();
        Elements A_Z = doc.select(".info_wrapper table tbody tr td[width] a[href]");
        for (Element A_Z_ele : A_Z) {
            Thread.sleep(10);
            String A_Z_link = A_Z_ele.attr("href");
            Document A_Z_doc = Jsoup.connect(base + A_Z_link).get();
            Elements depts = A_Z_doc.select(".content_wrapper table ~ table tr:contains(department) a");
            for (Element depts_ele : depts) {
                Thread.sleep(10);
                String dept_longName = depts_ele.text();
                String dept_courses_list_link = depts_ele.attr("href").replace(".html", "-courses.html");
                Document depts_doc = Jsoup.connect(base + dept_courses_list_link).get();
                Elements course_eles = depts_doc.select(".info_wrapper table ~ table a");
                for (Element course_ele : course_eles) {
                    Thread.sleep(100);
                    String[] course_title = course_ele.text().trim().split("\\s", 3);
                    String course_link = course_ele.attr("href");
                    Document course_info = Jsoup.connect(base + course_link).get();
                    Department newDept = new Department(dept_longName, course_title[0].trim());
                    CourseNumber newCourseNumber = new CourseNumber(course_title[1].replace(":", "").trim());
                    CourseName newCourseName = new CourseName(course_title[2].trim());
                    CourseDescription newCourseDescription = new CourseDescription(course_info.select(".info_wrapper table ~ p:contains(description)").text().replaceFirst("Description", "").trim());
                    Unit newUnit = new Unit(Integer.parseInt(course_info.select(".info_wrapper table ~ p:matches(Units [0-9])").text().replace("Units", "").trim()));

                    Course newCourse = new Course(newDept, newCourseNumber, newCourseName, newCourseDescription, newUnit);
                    System.out.println(newCourse.toString());
                    System.out.println(newCourse.courseDescription);
                    allCourses.add(newCourse);
                    break;
                }
                break;
            }
            break;
        }
        for (Course c : allCourses) {
            // what to do
        }
    }
}

class Course<Department, CourseNumber, CourseName, CourseDescription, Unit> {
    final Department department;
    final CourseNumber courseNumber;
    final CourseName courseName;
    final CourseDescription courseDescription;
    final Unit units;

    Course(Department department, CourseNumber courseNumber, CourseName courseName, CourseDescription courseDescription, Unit units) {
        this.department = department;
        this.courseNumber = courseNumber;
        this.courseName = courseName;
        this.courseDescription = courseDescription;
        this.units = units;
    }

    @Override
    public String toString() {
        return department.toString() + " " + courseNumber.toString() + ": " + courseName.toString() + " | u: " + units;
    }
}

class Department {
    final String longName;
    final String shortName;

    Department(String longName, String shortName) {
        this.longName = longName;
        this.shortName = shortName;
    }

    @Override
    public String toString() {
        return shortName;
    }
}

class CourseNumber {
    final String fullCourseNumber;

    CourseNumber(String fullCourseNumber) {
        this.fullCourseNumber = fullCourseNumber;
    }

    @Override
    public String toString() {
        return fullCourseNumber;
    }
}

class CourseName {
    final String courseName;

    CourseName(String courseName) {
        this.courseName = courseName;
    }

    @Override
    public String toString() {
        return courseName;
    }
}

class CourseDescription {
    final String courseDescription;

    CourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }

    @Override
    public String toString() {
        return courseDescription;
    }
}

class Unit {
    final int unitCount;

    Unit(int unitCount) {
        this.unitCount = unitCount;
    }

    @Override
    public String toString() {
        return String.valueOf(unitCount);
    }
}