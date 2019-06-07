//
//  SectionAddTableViewController.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit

class SectionAddTableViewController: UITableViewController {
    
    var sectionDict: [String:String] = [:]
    var sections: [CourseSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sectionDict)
        
        GetCourseInfo.findSection(quarter: sectionDict["quarter"]!, year: sectionDict["year"]!, dept: sectionDict["dept"]!, courseNum: sectionDict["courseNum"]!, success: { (courseSec) in
            for cs in courseSec{
                self.sections.append(cs)
                print(cs.courseCode3)
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sections.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionTableViewCell
        
        cell.titleLabel.text = sectionDict["courseTitle"]
        cell.codeLabel.text = sections[indexPath.row].courseCode3
        cell.dayLabel.text = sections[indexPath.row].days3
        cell.timeLabel.text = sections[indexPath.row].time3
        cell.instructorLabel.text = sections[indexPath.row].instructor3
        cell.typeLabel.text = sections[indexPath.row].type3
        cell.sectionLabel.text = sections[indexPath.row].section3
        cell.placeLabel.text = sections[indexPath.row].place3
        cell.statusLabel.text = sections[indexPath.row].status3

        // Configure the cell...

        return cell
    }
    
    //need to complete this
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print()
        //create a dictionary of select course section
        //save that dictionary into NSUserdefault
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
