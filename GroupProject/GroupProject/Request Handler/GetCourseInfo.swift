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
    
    static func findSection(quarter: String, year: String, dept: String, courseNum: String, success: @escaping (([CourseSection]) -> ()), failure: @escaping (Error) -> ()) {
        let data = ["Submit": "Display Text Results", "YearTerm": year + "-" + quarter,
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
                        let dayRange = line.range(of: #"(?<!STAF|STA)(M|Tu|W|Th|F)+"#, options: .regularExpression)
                        let days = String(line[dayRange!])
                        var time : String
                        if let timeRange = line.range(of: #"\d{1,2}:\d{2}-[\s\d]\d:\d{2}(p?)"#, options: .regularExpression) {
                            time = String(line[timeRange])
                        }
                        else {
                            time = "TBA"
                        }
                        var place : String
                        if let placeRange = line.range(of: #"[A-Z]{3,5}\s\d{3,4}"#, options: .regularExpression) {
                            place = String(line[placeRange])
                        }
                        else {
                            place = "TBA"
                        }
                        let status = elements[elements.count-1]
                        var seatString : String
                        let seatsRange = line.range(of: #"(?<!\d)(\d{1,3}\s+)((\d{1,3}\s+)|(\d{1,3}\/\d{1,3}\s+))(\d{1,3}|n\/a)\s+(\d{1,3}\s+){2}"#, options: .regularExpression)
                        seatString = String(line[seatsRange!]).trimmingCharacters(in: .whitespaces)
                        
                        var seatArray : [String] = seatString.components(separatedBy: .whitespaces)
                        let maxSeats = Int(seatArray[0]) ?? 0
                        if seatArray[1].count > 3 {
                            let index = seatArray[1].index(of: "/")
                            seatArray[1] = String(seatArray[1].substring(from: index!))
                            let offset1 = seatArray[1].index(seatArray[1].startIndex, offsetBy: 1)
                            seatArray[1] = String(seatArray[1].substring(from: offset1))
                        }
                        let seatsTaken = Int(seatArray[1]) ?? 0
                        let seatsReserved = Int(seatArray[seatArray.count-1]) ?? 0
                        sections.append(CourseSection(courseCode: code, type: type, section: section, instructor: instructor, days: days, time: time, place: place, status: status, maxSeats: maxSeats, seatsTaken: seatsTaken, seatsReserved: seatsReserved))
                    }
                }
                
                success(sections)
            }
        }
        task.resume()
    }
    
    
    static func findCourses(quarter: String, year: String, dept: String, success: @escaping (([Course]) -> ()),
                            failure: @escaping ((Error) -> ())) {
        let data = ["Submit": "Display Text Results", "YearTerm": year + "-" + quarter,
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
                    if (elements[0].lowercased() == dept.lowercased()) && (elements.count >= 3) {
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
