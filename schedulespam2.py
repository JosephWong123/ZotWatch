import requests
import time
import os
import re
import datetime
import json

data = {'Submit': 'Display Text Results', 'YearTerm': '2019-92', 'ShowComments': 'off', 'ShowFinals': 'off', 'Breadth': 'ANY', 'Dept': 'COMPSCI', 'Division': 'ANY', 'CourseNum': '121', 'FullCourses': 'SkipFull'}

# def notify(title, text):
#     os.system("""
#               osascript -e 'display notification "{}" with title "{}"'
#               """.format(text, title))

avail = False
notified = False

while not avail:
    r = requests.get('https://www.reg.uci.edu/perl/WebSoc', params=data)
    found = False

    # course_codes = ['44294', '44295']
    # check_list = [c in r.text for c in course_codes]
    for line in r.text.splitlines():
        line = line.strip()
        elements = re.split(r'\s+', line)
        print(line, "-------------\n")

        if len(elements) >= 2 and elements[0] == "34040":
            found = (elements[len(elements)-1] == "OPEN")

            if found and not notified:
                # notify("ICS 46", "Pattis Lecture available")
                print(datetime.datetime.now(), "Available", sep=': ')
                notified = True

    if not found:
        print(datetime.datetime.now(), "Not available", sep=': ')

    time.sleep(10)

    # if any(check_list):
    #     available_courses = ', '.join([c for c in course_codes if c in r.text])
    #     if not notified:
    #         notify("SCHEDULE", "DO YOUR REGISTRATION, THESE COURSES ARE OPEN: " + available_courses)
    #         notified = True
    #     print(datetime.datetime.now(), available_courses, sep=': ')
    # else:
    #     print(datetime.datetime.now(), "Not available", sep=': ')
    # time.sleep(10)




