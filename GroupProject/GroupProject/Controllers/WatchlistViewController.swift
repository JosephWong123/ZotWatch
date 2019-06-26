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
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    //should be call every view did load or when refreshed
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "WatchToLogin", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadClasses()
        self.tableView.reloadData()
        refreshControl.addTarget(self, action: #selector(loadClasses), for: .valueChanged)
        tableView.refreshControl = refreshControl
            
        // Do any additional setup after loading the view.
    }

    @objc private func loadClasses() {
        let classQuery = PFQuery(className: "Course")
        classQuery.whereKey("user", equalTo: PFUser.current()!.username!)
        
        classQuery.findObjectsInBackground {
            (objects, error) -> Void in
            if (error == nil) {
                let objs = objects!
                for obj in objs {
                    GetCourseInfo.findByCode(quarter: obj["quarter"] as! String, year: obj["year"] as! String, code: obj["code"] as! String, success: { (section) in
                        let course = section[0]
                        course.courseName = obj["title"] as! String
                        if !self.watched.contains(where: { (c) -> Bool in
                            if c.courseCode == course.courseCode {
                                return true
                            }
                            return false
                        }) {
                            self.watched.append(course)
                        }
                    }, failure: { (error) in
                        print(error)
                    })
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print("Error: \(error)")
            }
        }
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
                let objs = objects!
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
                let objs = objects!
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
            object["quarter"] = index.quarter
            object["year"] = index.year
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
