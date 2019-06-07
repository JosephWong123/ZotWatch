//
//  GetCourseInfo.swift
//  GroupProject
//
//  Created by Joseph Wong on 6/4/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import Foundation

class GetCourseInfo {
    static var url = URLComponents(string: "https://www.reg.uci.edu/perl/WebSoc")!
    
    // var courses = [Course]()
    
    static func findSection(quarter: Int, year: Int, dept: String, courseNum: String, success: @escaping (([CourseSection]) -> ()), failure: @escaping (Error) -> ()) {
        let data = ["Submit": "Display Text Results", "YearTerm": String(year) + "-" + String(quarter),
            "Breadth": "ANY", "Dept": dept, "Division": "ANY", "CourseNum": courseNum]
        var sections = [CourseSection]()
        url.queryItems = data.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        let task = URLSession.shared.dataTask(with: url.url!) { data, response, error in
            var lines = [String]()
            if let error = error {
                failure(error)
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    return
            }

            if let data = data {
                let string = String(data: data, encoding: .utf8)
                string!.enumerateLines { line, _ in
                    lines.append(line)
                }
                for var line in lines {
                    line = line.trimmingCharacters(in: .whitespacesAndNewlines)
                    var elements : [String] = line.components(separatedBy: " ")
                    
                    if (Int(elements[0]) != nil) {
                        elements = elements.filter { $0 != "" }

                        if (elements[4].last! == ",") {
                            elements[4] = String(elements[4].dropLast())
                        }
                        let code = elements[0]
                        let type = elements[1]
                        let section = elements[2]
                        let instructor = elements[4]
                        let days = elements[elements.count-12]
                        let time = elements[elements.count-11] + elements[elements.count-10]
                        let place = elements[elements.count-9] + " " + elements[elements.count-8]
                        let status = elements[elements.count-1]
                        let maxSeats = Int(elements[elements.count-7])!
                        let seatsTaken = Int(elements[elements.count-6])!
                        let seatsReserved = Int(elements[elements.count-3])!
                        sections.append(CourseSection(courseCode: code, type: type, section: section, instructor: instructor, days: days, time: time, place: place, status: status, maxSeats: maxSeats, seatsTaken: seatsTaken, seatsReserved: seatsReserved))
                    }
                }
                
                success(sections)
            }
        }
        task.resume()
    }
    
    static func findCourses(quarter: Int, year: Int, dept: String, success: @escaping (([Course]) -> ()),
                            failure: @escaping ((Error) -> ())) {
        let data = ["Submit": "Display Text Results", "YearTerm": String(year) + "-" + String(quarter),
                    "Breadth": "ANY", "Dept": dept, "Division": "ANY"]
        
        url.queryItems = data.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let task = URLSession.shared.dataTask(with: url.url!) { data, response, error in
            var lines = [String]()
            var courses = [Course]()
            if let error = error {
                failure(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    return
            }
            if let data = data {
                let string = String(data: data, encoding: .utf8)
                string!.enumerateLines { line, _ in
                    lines.append(line)
                }
                for var line in lines {
                    line = line.trimmingCharacters(in: .whitespacesAndNewlines)
                    var elements : [String] = line.components(separatedBy: "  ")
                    if (elements[0].lowercased() == dept.lowercased()) {
                        elements = elements.filter { $0 != "" }
                        courses.append(Course(dept: elements[0], courseNum: elements[1], courseTitle: elements[2]))
                    }
                }
            }
            success(courses)
        }
        task.resume()
    }
}
