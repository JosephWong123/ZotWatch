//
//  CourseClasses.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import Foundation

class CourseSection {
    var courseCode: String
    var days: String
    var time: String
    var instructor: String
    var type: String
    var section: String
    var place: String
    var status: String
    var maxSeats : Int
    var seatsTaken : Int
    var seatsReserved : Int
    
    required init(courseCode: String, type: String, section: String, instructor: String, days: String, time: String, place: String, status: String, maxSeats: Int, seatsTaken: Int, seatsReserved: Int){
        self.courseCode = courseCode
        self.days = days
        self.time = time
        self.instructor = instructor
        self.type = type
        self.section = section
        self.place = place
        self.status = status
        self.maxSeats = maxSeats
        self.seatsTaken = seatsTaken
        self.seatsReserved = seatsReserved
    }
}

class Course{
    var dept: String
    var courseNum: String
    var courseTitle: String
    
    init(dept: String, courseNum: String, courseTitle: String){
        self.dept = dept
        self.courseNum = courseNum
        self.courseTitle = courseTitle
    }
}
