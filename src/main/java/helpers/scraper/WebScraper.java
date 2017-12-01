package main.java.helpers.scraper;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.beans.XMLEncoder;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * scrape all SJSU courses
 */
public class WebScraper {
    public static void main(String[] args) throws IOException, InterruptedException {
        List<Course<Department, CourseNumber, CourseName, CourseDescription, Unit>> allCourses = new ArrayList<>();

        String base = "http://info.sjsu.edu";
        String homeURL = base + "/web-dbgen/catalog/departments/all-departments.html";
        Document doc = Jsoup.connect(homeURL).get();
        Thread.sleep(200);
        Elements A_Z = doc.select(".info_wrapper table tbody tr td[width] a[href]");
        for (Element A_Z_ele : A_Z) {
            String A_Z_link = A_Z_ele.attr("href");
            Document A_Z_doc = Jsoup.connect(base + A_Z_link).get();
            Thread.sleep(200);
            Elements depts = A_Z_doc.select(".content_wrapper table ~ table tr:contains(department) a");
            for (Element depts_ele : depts) {
                String dept_courses_list_link = depts_ele.attr("href").replace(".html", "-courses.html");
                Document depts_doc = Jsoup.connect(base + dept_courses_list_link).get();
                Thread.sleep(200);
                Elements sub_dept_eles = depts_doc.select(".info_wrapper table ~ table h3");
                List<String> sub_dept_list = new ArrayList<>();
                sub_dept_eles.forEach(element -> sub_dept_list.add(element.text().trim()));
                Elements course_eles = depts_doc.select(".info_wrapper table ~ table tr td");
                String dept_longName = null;
                String[] course_title = null;
                Department newDept = null;
                boolean dept_name_changed = false;
                for (Element course_ele : course_eles) {
                    if (course_ele.text().isEmpty()) {
                        continue;
                    }
                    if (sub_dept_list.contains(course_ele.text().trim())) {
                        dept_longName = course_ele.text().trim();
                        dept_name_changed = true;
                        continue;
                    } else {
                        course_title = course_ele.text().trim().split("\\s", 3);
                    }
                    String course_link = course_ele.getElementsByTag("a").attr("href");
                    Document course_info = Jsoup.connect(base + course_link).get();
                    Thread.sleep(200);
                    CourseNumber newCourseNumber = new CourseNumber(course_title[1].replace(":", "").trim());
                    CourseName newCourseName = new CourseName(course_title[2].trim());
                    CourseDescription newCourseDescription = new CourseDescription(course_info.select(".info_wrapper table ~ p:contains(description)").text().replaceFirst("Description", "").trim());
                    Unit newUnit = new Unit(course_info.select(".info_wrapper table ~ p:matches(Units)").text().replace("Units", "").trim());

                    Course<Department, CourseNumber, CourseName, CourseDescription, Unit> newCourse = new Course<>(newDept, newCourseNumber, newCourseName, newCourseDescription, newUnit);
//                    System.out.println(newCourse.toString());
//                    System.out.println(newCourse.courseDescription);
                    allCourses.add(newCourse);
                    if (dept_name_changed) {
                        newDept = new Department(dept_longName, course_title[0].trim());
                        System.out.printf("INSERT IGNORE INTO departments(dept_id, dept_short_name, dept_name) VALUE(NULL, '%s', '%s');\n",
                                course_title[0].trim(),
                                dept_longName.replace("'", "\\'"));
                        dept_name_changed = false;
                    }
                    System.out.printf("INSERT IGNORE INTO courses(course_id, dept_id, course_number, course_name, course_description) VALUE(NULL, (SELECT dept_id FROM departments WHERE dept_short_name='%s'), '%s', '%s', '%s');\n",
                            course_title[0].trim(),
                            newCourseNumber.toString().replace("'", "\\'").trim(),
                            newCourseName.toString().replace("'", "\\'"),
                            newCourseDescription.toString().replace("'", "\\'"));
                }
            }
        }
        XMLEncoder e = new XMLEncoder(new BufferedOutputStream(
                new FileOutputStream("all_courses.xml")));
        e.writeObject(allCourses);
        e.close();
    }
}
