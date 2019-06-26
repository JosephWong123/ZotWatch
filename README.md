# ZotWatch

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Keeps track of classes that a user is interested in enrolling in at UCI. Makes it easier to keep track of multiple classes at once.

### App Evaluation

- **Category:** Utility/Education
- **Mobile:** This app is primarily for mobile, as it gives users a quick and easy way to track the status of classes that they want from the convenience of their mobile device.
- **Story:** Helps users keep track of classes they are trying to enroll in at UCI. Once a class is added to their track list, every time the user opens the app, each class will be a different color based on how full the class in. This will help a user keep track of all their classes at the same time, without having to keep refreshing on Schedule of Classes.
- **Market:** This app is targeted towards UCI students.
- **Habit:** This app is primarily going to be used during class registration season - the usage will depend on the importance keeping track of classes a user is trying to enroll in.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* Login screen with Parse database to keep track of a user's classes
* Screen that keeps track of all the classes a user is tracking 
* Screen that allows a user to search UCI's catalogue in order to add it to their track list
* Ability to add/remove classes from a user's watch list

**Optional Nice-to-have Stories**

* The background for each course the user is tracking matches the status of the course. (Green for OPEN, Yellow for waitlist, Red for FULL, Blue for NewOnly)
* User can sort/filter through their watch list courses
* User can remove a watch list course
* User can rearrange the order of their watch list course

### 2. Screen Archetypes
* Login Screen
   * User can log in or register for a new account
   * An error message is displayed if something goes wrong with logging in
* Watch List Screen
   * User can view the list of classes they are tracking
   * User can add a class to their tracking list
   * User can remove a class from their tracking list
   * User can entirely clear the list of classes they are tracking
* Find Course Screen
   * User can pick a department, year, and quarter to choose a course from
* Course List Screen
    * Lists all the different courses for that specified department, year, and quarter
    * User can choose a course to choose from
* Lecture/Discussion/Lab List Screen
    * Lists all the lectures, discussion, and lab sections for the corresponding course
    * User can choose a section to add to their watch list


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Watch list Feed <br> <img src="https://i.imgur.com/uKQp8Sv.png" width=250>
* Find Course <br> <img src="https://i.imgur.com/jGUfcjd.png" width=250>
* Choose Course <br> <img src="https://i.imgur.com/jgEOJGq.png" width=250>
* Choose Section <br> <img src="https://i.imgur.com/JUYVB6V.png" width=250>

**Flow Navigation** (Screen to Screen)
* Login Screen
    => Watch List
* Watch List Feed
    => Find Course
    => Login Screen (through Log Out button)
* Find Course Screen
    => Choose Course
* Choose Course Screen
    => Choose Section
* Choose Section Screen
    => Watch List Feed

**App Demo** <br>
<img src="http://g.recordit.co/kOSKU8oaY3.gif" width=250>

## Wireframes
<img src="https://i.imgur.com/l3K9ick.jpg" width=600>

## Schema
### Models
Course

| Property | Type  | Description |
| -------- | -------- | -------- |
| dept | String | The department that the course is in
| courseNum | String | The department's designation for an approved course
| courseTitle | String | The title of the course, describing what the course is about

CourseSection

| Property | Type  | Description |
| -------- | -------- | -------- |
|courseName|String|The course's title from the UCI Registrar.|
|courseCode|Int|The section's unique course code, used for adding and dropping from WebReg|
|type|String|The type of instruction for the course|
|section|String|The Section number or letter identifier for an individual class|
|instructor|String|The name of the instructor teaching the class|
|days|String|The days on which the class meets.|
|time|String|The meeting time of the class.|
|place|String|The location of where the class meets.|
|status|String|	For the fall, winter and spring terms, this column specifies the current enrollment status for a class: <br>OPEN: The class has not yet reached maximum enrollment capacity. <br> NewOnly: This course only has openings for new students (but the waiting list may still have space for continuing students).<br>Waitl: The class has reached maximum capacity, but there is space on the Waiting List<br>FULL: The class has reached maximum capacity and the Waiting List is either full or not an option.|
|maxSeats|Int|The total number of seats available for that section.|
|seatsTaken|Int|The number of seats that have already been taken in that section.|
|seatsReserved|Int|The number of seats that are reserved for new students; cannot currently be enrolled in.|
