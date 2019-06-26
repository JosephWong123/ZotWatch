//
//  WaitlistViewController.swift
//  
//
//  Created by Garry Fanata on 6/6/19.
//

import UIKit
import Parse

//need to implement remove section
class WatchlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var watched = [CourseSection]()
    
    @IBOutlet weak var tableView: WatchlistTableView!
    //should be call every view did load or when refreshed
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "WatchToLogin", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let classQuery = PFQuery(className: "Course")
        classQuery.whereKey("user", equalTo: PFUser.current()!.username!)
        
        classQuery.findObjectsInBackground {
            (objects, error) -> Void in
            if (error == nil) {
                let objs = objects as! [PFObject]
                for obj in objs {
                    let course = CourseSection(courseCode: obj["code"] as! String, type: obj["type"] as! String, section: obj["section"] as! String, instructor: obj["instructor"] as! String, days: obj["days"] as! String, time: obj["time"] as! String, place: obj["place"] as! String, status: obj["status"] as! String, maxSeats: obj["maxSeats"] as! Int, seatsTaken: obj["seatsTaken"] as! Int, seatsReserved: obj["seatsReserved"] as! Int)
                    course.courseName = obj["title"] as! String
                    if !self.watched.contains(where: { (c) -> Bool in
                        if c.courseCode == course.courseCode {
                            return true
                        }
                        return false
                    }) {
                        self.watched.append(course)
                    }
                }
                self.tableView.reloadData()
            } else {
                print("Error: \(error)")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watched.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WatchToSearch" {
            let courseVC = segue.destination as! CourseSearchViewController
            courseVC.passingCourseList = self.watched
            
        }
        
    }
    @IBAction func clearList(_ sender: Any) {
        self.watched = [CourseSection]()
        let classQuery = PFQuery(className: "Course")
        classQuery.whereKey("user", equalTo: PFUser.current()!.username!)
        
        classQuery.findObjectsInBackground {
            (objects, error) -> Void in
            if (error == nil) {
                let objs = objects as! [PFObject]
                for obj in objs {
                    obj.deleteInBackground()
                }
            } else {
                print("Error: \(error)")
            }
        }
        tableView.reloadData()
    }

    // need to reconnect later
    @IBAction func remove(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview?.superview as? WatchlistTableViewCell
            else {
                return // or fatalError() or whatever
            }
        self.watched = self.watched.filter(){$0.courseCode != cell.classCode.text!}
        let classQuery = PFQuery(className: "Course")
        classQuery.whereKey("user", equalTo: PFUser.current()!.username!)
        classQuery.findObjectsInBackground {
            (objects, error) -> Void in
            if (error == nil) {
                let objs = objects as! [PFObject]
                for obj in objs {
                    obj.deleteInBackground()
                }
            } else {
                print("Error: \(error)")
            }
        }
        
        for index in self.watched {
            let object = PFObject(className: "Course")
            object["code"] = index.courseCode
            object["user"] = PFUser.current()!.username
            object["title"] = index.courseName
            object["code"] = index.courseCode
            object["days"] = index.days
            object["time"] = index.time
            object["instructor"] = index.instructor
            object["type"] = index.type
            object["place"] = index.place
            object["status"] = index.status
            object["maxSeats"] = index.maxSeats
            object["seatsTaken"] = index.seatsTaken
            object["seatsReserved"] = index.seatsReserved
            object["section"] = index.section
            object.saveInBackground()
        }
        
        tableView.reloadData()
    
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchlistTableViewCell
        cell.courseName.text = watched[indexPath.row].courseName
        cell.profName.text = watched[indexPath.row].instructor
        cell.courseTime.text = watched[indexPath.row].days + " " + watched[indexPath.row].time
        cell.classCode.text = watched[indexPath.row].courseCode
        cell.location.text = watched[indexPath.row].place
        let seatsAvail = watched[indexPath.row].maxSeats - watched[indexPath.row].seatsTaken - watched[indexPath.row].seatsReserved
        cell.seatsAvail.text = String(seatsAvail)
        cell.status.text = watched[indexPath.row].status
        switch (watched[indexPath.row].status.lowercased()) {
        case "newonly":
            cell.backgroundColor = .blue
        case "full":
            cell.backgroundColor = .red
        case "open":
            cell.backgroundColor = .green
        case "waitl":
            cell.backgroundColor = .yellow
        default:
            cell.backgroundColor = .white
        }
        return cell
    }

}
