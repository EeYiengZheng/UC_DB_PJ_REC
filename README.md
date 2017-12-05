# UC_DB_PJ_REC
UC_DB_PJ_REC stands for University Database Project, Raymond, Ee, Christine. 

See proposal for project information (located under /Documentation/Proposal).

## Project Design

## Live Demo
Live demo located at: https://ucdb-rec.herokuapp.com/
(may not be up all the time)

## Requirements for Use
This project requires Apache Tomcat as a web server to run.
If on Windows: Tomcat is automatically installed when installing XAMPP. Install XAMPP here: https://www.apachefriends.org/download.html/ Pick 7.1.11 with PHP 7.1.11 for Windows.
If on Mac: To use Tomcat, you need XAMPP server and MySQL running in the background. Download XAMPP here: https://www.apachefriends.org/download.html/ for OS X 7.1.11 with PHP 7.1.11. Download Tomcat separately here: https://tomcat.apache.org/download-90.cgi/
Unzip the file.

## Instructions
Please feel free to skip to where you feel comfortable.

### Setting up the Server
##### Windows:
Open up XAMPP control maanger and start up XAMPP's Apache Web Server, MySQL Database, and Tomcat Web Server. Open up your favorite web browser and type in: localhost:8080. You should see the Tomcat welcome page.

##### Mac:
Open up XAMPP control manager and start Apache Web Server and MySQL Database. There is an additional step to setting up Tomcat. Open the Terminal and navigate to the apache-tomcat-9.0.1, specifically the bin file. Type in "./startup.sh" and if it works, you will see "Tomcat started" as the last line. Open up your favorite web browser and type in: localhost:8080. You should see the Tomcat welcome page.

### Getting the Github Code
Create a new file in apache-tomcat-9.0.1/webapps/ named "cs157a_sec3_team5".
1. Download the ZIP file. Unzip and place into apache-tomcat-9.0.1/webapps/cs157a_sec3_team5
2. Pull it from command line.
3. Use Github Desktop.

### Setting up the Database
In your web browser, navigate to localhost/phpmyAdmin and create a new database named "cs157a_sec3_team5". Click Import at the top of the page and upload the file "cs157a_schema.sql", located from the Github code. Make sure to have foreign key checks unselected! After this, import "cs157a_data.sql". You now have a complete database of users and courses.

## How the Project Works
Since the project has a prefilled database, the natural flow of the website starts with the Head of Department hiring a lecturer, who will then teach classes within that department, who will have students taking their class and the lecturer can then set their grades.

## Features
Listed below are some of the functionalities we have completed for the project.

### Home page
The home page is a simple splash page with a blue gradient, with some proposal information pertinent to the project. At the top are the option to login or register.

### Register
To register for an account, click "Register" tab on the top right. The following fields are required: First Name, Last Name, Date of Birth, Username, Password, and confirm Password. There are the optional Nickname, Email Address, and if you are a Student, Lecturer, or VIP (Head of Department). This will trigger an error message if these are unfulfilled.

### Login
After registering, you will be redirected to Login, where you can enter in your new account and password. This page will trigger an error message if the passwords do not match or if you have an account that doesn't exist. If you'd like to use a preset from the database, here is the account info:

##### Student
U/N: 1
P/W: 1

##### Lecturer
U/N: 951
P/W: 951

##### Head of Department
U/N: EE
P/W: powerful

### Dashboard
The dashboard welcomes you by name back to your account, and declares what type of account you're using. It lists the functionalities you can do on your account. Lastly, it states which department you're in, if any.

### MyInfo
In the MyInfo tab, your information is preloaded into the fields. The first name, last name, and birthday are unchangable. The second section allows the change of password, and will trigger error messages if the password doesn't match. The third section of this page is personal information which can be changed by pressing the 'Edit' button. There is an optional 'Save' button which will save your progress, but otherwise you can click 'Update Info' to save the changed information.

### Search Courses
On the search for courses page, there are three fields that can be filled for to search for courses: Subject, Course Number, and GE Area. Leaving all of these blank will bring up all the classes available. 

##### Student
However, as a Student, you'll see only the classes where a lecturer has already enrolled to teach it. Below the search functionalities, you can see a list of courses that are currently being taken by you with the option of dropping that class.

##### Lecturer
For lecturers, the search results will be of the classes you can teach based on your department. Opting to teach a class will make it visible to other students. On the search courses page, we can see the courses currently being taught by the lecturer with the option of dropping.

### Grades
Depending on the type of account being used, it will display different text on the top navigator.

##### Student
Students will see "My Grades" and a list of their current classes and the grades from their previous class.

##### Lecturer
Lecturers will see "Gradebook" which will show them a page where they can update students grades. Based on the classes they're teaching, they can click submit to see a list of students taking their class. There is the option to set their student's grade and also Drop student for each student they have.

### Head of Department Special Features
In a Head account, we can search for employees by their First Name or Last Name, and we're able to Hire them in the search results. Back at the Employee tab, we can also see a list of our employees and if we want to fire them.

### Logout
Upon clicking this, you will be logged out back to the home page and have to sign in again.

***

Thanks, that's all, folks!
Made with ♥ Team 5