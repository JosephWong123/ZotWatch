//
//  ViewController.swift
//  GroupProject
//
//  Created by Kinaar Desai on 6/2/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sections = [CourseSection]()
    var courses = [Course]()
    let appRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getCourseData()
        for s in self.sections {
            print(s)
        }
        self.getCourses()
        // client.findCourses(quarter: 92, year: 2019, dept: "I&C SCI")
    }
    
    @objc func getCourseData() {
        let a = 1
        GetCourseInfo.findSection(quarter: 92, year: 2019, dept: "I&C SCI", courseNum: "46", success: { (sections) in
            for s in sections {
                // print(s)
                self.sections.append(s)
            }
            print(self.sections)
        }) { (Error) in
            print("Error: \(Error)")
        }
        
        
        let b = 2
    }
    
    func getCourses() {
        GetCourseInfo.findCourses(quarter: 92, year: 2019, dept: "I&C SCI", success: { (courses) in
            for c in courses {
                self.courses.append(c)
            }
            print(self.courses)
        }) { (Error) in
            print("Error: \(Error)")
        }
        
    }
    


}

