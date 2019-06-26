//
//  SectionAddTableViewController.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit
import Parse

class SectionAddTableViewController: UITableViewController {
    
    var sectionDict: [String:String] = [:]
    var sections: [CourseSection] = []
    var section: CourseSection? = nil
    var watchList = [CourseSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetCourseInfo.findSection(quarter: sectionDict["quarter"]!, year: sectionDict["year"]!, dept: sectionDict["dept"]!, courseNum: sectionDict["courseNum"]!, success: { (courseSec) in
            for cs in courseSec{
                self.sections.append(cs)
                cs.courseName = self.sectionDict["courseTitle"]!
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        UserDefaults.standard.set(sectionDict["quarter"], forKey: "quarter")
        UserDefaults.standard.set(sectionDict["year"], forKey: "year")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionTableViewCell
        
        
        cell.titleLabel.text = sectionDict["courseTitle"]
        cell.codeLabel.text = sections[indexPath.row].courseCode
        cell.dayLabel.text = sections[indexPath.row].days
        cell.timeLabel.text = sections[indexPath.row].time
        cell.instructorLabel.text = sections[indexPath.row].instructor
        cell.typeLabel.text = sections[indexPath.row].type
        cell.sectionLabel.text = sections[indexPath.row].section
        cell.placeLabel.text = sections[indexPath.row].place
        cell.statusLabel.text = sections[indexPath.row].status
        
        // let current = sections[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    // urgent need to fix!! -Joseph
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.section = sections[indexPath.row]
        performSegue(withIdentifier: "AddToWatchlist", sender: self)
        
    
        
        //create a dictionary of select course section
        //save that dictionary into NSUserdefault
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddToWatchlist" {
            let watchVC = segue.destination as! WatchlistViewController
            self.watchList.append(self.section!)
            
            // saves in Parse
            let user = PFUser.current()!
            for index in watchList {
                let object = PFObject(className: "Course")
                object["code"] = index.courseCode
                object["user"] = user.username
                object["title"] = index.courseName
//                object["code"] = index.courseCode
//                object["days"] = index.days
//                object["time"] = index.time
//                object["instructor"] = index.instructor
//                object["type"] = index.type
//                object["place"] = index.place
//                object["status"] = index.status
//                object["maxSeats"] = index.maxSeats
//                object["seatsTaken"] = index.seatsTaken
//                object["seatsReserved"] = index.seatsReserved
//                object["section"] = index.section
                object["quarter"] = sectionDict["quarter"]
                object["year"] = sectionDict["year"]
                object.saveInBackground()
            }
            
            //Updates the dictionary in other VC to perform query
            watchVC.watched = self.watchList
            
        }
        
    }

}
