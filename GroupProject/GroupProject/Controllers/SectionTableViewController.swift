//
//  SectionTableViewController.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit

class SectionTableViewController: UITableViewController {
    
    var coursesDict: [String:String] = [:]
    var courses: [Course] = []
    var passingCourses = [CourseSection]()
    var secDict: [String:String] = [
        "dept" : "Default Dept",
        "year" : "Default Year",
        "quarter" : "Default Quarter",
        "courseNum" : "Default Course Number",
        "courseTitle" : "Default Course Title"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Finds all the courses in that dept, quarter and year
        GetCourseInfo.findCourses(quarter: coursesDict["quarter"]!, year: coursesDict["year"]!, dept: coursesDict["dept"]!, success: { (cour) in
            for c in cour{
                self.courses.append(c)
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
        return self.courses.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseTableViewCell
        cell.cnameLabel.text = courses[indexPath.row].dept
        cell.cnumLabel.text = courses[indexPath.row].courseNum
        cell.cdescLabel.text = courses[indexPath.row].courseTitle

        // Configure the cell...

        return cell
    }
    
    //Expands course into all sections of it
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secDict["dept"] = courses[indexPath.row].dept
        secDict["year"] = coursesDict["year"]
        secDict["quarter"] = coursesDict["quarter"]
        secDict["courseNum"] = courses[indexPath.row].courseNum
        secDict["courseTitle"] = courses[indexPath.row].courseTitle
        performSegue(withIdentifier: "addSectionSegue", sender: secDict)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSectionSegue" {
            let sectionAddTVC = segue.destination as! SectionAddTableViewController
            
            //Updates the dictionary in other VC to perform query
            sectionAddTVC.sectionDict = self.secDict
            sectionAddTVC.watchList = self.passingCourses
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
