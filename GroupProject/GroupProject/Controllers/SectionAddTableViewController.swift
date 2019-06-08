//
//  SectionAddTableViewController.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit
import SQLite3

class SectionAddTableViewController: UITableViewController {
    
    var db: OpaquePointer?
    var sectionDict: [String:String] = [:]
    var sections: [CourseSection] = []
    var section: CourseSection? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sectionDict)
        
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
        let defaults = UserDefaults.standard
        let numTracking = defaults.integer(forKey: "numClasses")
        let numAsString = String(numTracking)
        let code = "Class" + numAsString
        
        defaults.set(sections[indexPath.row].courseCode, forKey: code)
        
        let tracking = numTracking + 1
        defaults.set(tracking, forKey: "numClasses")
        self.section = sections[indexPath.row]
        performSegue(withIdentifier: "AddToWatchlist", sender: self)
        
    
        
        //create a dictionary of select course section
        //save that dictionary into NSUserdefault
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddToWatchlist" {
            let sectionVC = segue.destination as! WatchlistViewController
            
            //Updates the dictionary in other VC to perform query
            sectionVC.watched.append(self.section!)
            
        }
        
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
