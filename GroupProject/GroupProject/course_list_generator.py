import requests
import re


class CourseSection:
    def __init__(self, course_code, type, section, instructor, days, time, place, status):
        self.course_code = course_code
        self.days = days
        self.time = time
        self.instructor = instructor
        self.type = type
        self.section = section
        self.place = place
        self.status = status
        if self.instructor[len(self.instructor)-1:] == ",":
            self.instructor = self.instructor[0:len(self.instructor)-1]

    def __repr__(self):
        return "CourseSection(" + str(self.course_code) + " " + self.days + " " + self.time + " " + self.instructor + " " + self.type + " " + self.section + " " + self.place + ")"


class Course:
    def __init__(self, dept, course_num, course_title):
        self.dept = dept
        self.course_num = course_num
        self.course_title = course_title

    def __repr__(self):
        return "Course(" + self.dept + " " + self.course_num + self.course_title + ")"


class CourseFinder:
    @classmethod
    def find_sections(quarter : int, year : int, dept : str, course_num : str) -> [CourseSection]:
        data = {'Submit': 'Display Text Results', 'YearTerm': str(year) + "-" + str(quarter),
                'Breadth': 'ANY', 'Dept': dept, 'Division': 'ANY', 'CourseNum': course_num}
        r = requests.get('https://www.reg.uci.edu/perl/WebSoc', params=data)

        courses = []
        for line in r.text.splitlines():
            line = line.strip()
            elements = re.split(r'\s+', line)

            try:
                elements[0] = int(elements[0])
                print(elements)

                courses.append(CourseSection(elements[0], elements[1], elements[2], elements[4], elements[len(elements)-12],
                                      elements[len(elements)-11] + elements[len(elements)-10], elements[len(elements)-9] + " " +
                                      elements[len(elements)-8], elements[len(elements)-1]))
            except ValueError:
                pass

        return courses
    
    @classmethod
    def find_courses(quarter : int, year : int, dept : str) -> [Course]:
        data = {'Submit': 'Display Text Results', 'YearTerm': str(year) + "-" + str(quarter),
                'Breadth': 'ANY', 'Dept': dept, 'Division': 'ANY'}
        r = requests.get('https://www.reg.uci.edu/perl/WebSoc', params=data)

        courses = []
        for line in r.text.splitlines():
            line = line.strip()
            elements = re.split(r'\s{2,}', line)

            if elements[0].lower() == dept.lower():
                print(elements)
                courses.append(Course(dept, elements[1], elements[2]))

        return courses

