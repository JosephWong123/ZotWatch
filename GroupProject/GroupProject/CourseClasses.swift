//
//  CourseClasses.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import Foundation

class CourseSection{
    var courseCode3: Int
    var days3: String
    var time3: String
    var instructor3: String
    var type3: String
    var section3: String
    var place3: String
    var status3: String
    
    
    init(courseCode: Int, type: String, section: String, instructor: String, days: String, time: String, place: String, status: String){
        self.courseCode3 = courseCode
        self.days3 = days
        self.time3 = time
        self.instructor3 = instructor
        self.type3 = type
        self.section3 = section
        self.place3 = place
        self.status3 = status
        
     }
}

class Course{
    var dept3: String
    var courseNum3: String
    var courseTitle3: String
    
    init(dept: String, courseNum: String, courseTitle: String){
        self.dept3 = dept
        self.courseNum3 = courseNum
        self.courseTitle3 = courseTitle
    }
}
