//
//  WaitlistViewController.swift
//  
//
//  Created by Garry Fanata on 6/6/19.
//

import UIKit

//need to implement remove section
class WatchlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var watchCodes = [String]()
    var watched = [CourseSection]()
    
    
    //should be call every view did load or when refreshed
    func getCourses(){
        let defaults = UserDefaults.standard
        let numTracking = defaults.integer(forKey: "numClasses")
        
        
        for x in 0...numTracking {
            let numAsString = String(x)
            let code = "Class" + numAsString
            let courseCode = defaults.string(forKey: code)!
            watchCodes.append(courseCode)
        }
        for c in watchCodes {
            GetCourseInfo.findByCode(quarter: defaults.string(forKey: "quarter")!, year: defaults.string(forKey: "year")!, code: c, success: { (section) in
                self.watched.append(section)
            }) { (Error) in
                print(Error)
            }
        }
        tableView.reloadData()
        //reads NSUserDefaults for all the dictionaries saved in the watchlist
        //calls GetCourseInfo.findSection() for all the dictionaries and added to watched dictionary
        //displays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchlistTableViewCell
        cell.profName.text = watched[indexPath.row].instructor
        cell.courseTime.text = watched[indexPath.row].time
        cell.classCode.text = watched[indexPath.row].courseCode
        cell.location.text = watched[indexPath.row].place
        let seatsAvail = watched[indexPath.row].maxSeats - watched[indexPath.row].seatsTaken - watched[indexPath.row].seatsReserved
        cell.seatsAvail.text = String(seatsAvail)
        cell.status.text = watched[indexPath.row].status
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
