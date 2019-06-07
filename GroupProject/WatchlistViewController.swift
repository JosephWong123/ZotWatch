//
//  WaitlistViewController.swift
//
//
//  Created by Garry Fanata on 6/6/19.
//
import UIKit

//need to implement remove section
class WatchlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var watched: [NSDictionary] = []
    
    //should be call every view did load or when refreshed, also needs urgent fixes
    func getCourses() {
        UserDefaults.standard.removeObject(forKey: "watchList")
        UserDefaults.standard.removeObject(forKey: "watchList1")
        let bs = UserDefaults.standard.array(forKey: "watchList2") as? [NSDictionary] ?? [NSDictionary]()
        watched = bs
        
        //reads NSUserDefaults for all the dictionaries saved in the watchlist
        //calls GetCourseInfo.findSection() for all the dictionaries and added to watched dictionary
        //displays
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCourses()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        print((UserDefaults.standard.dictionaryRepresentation() as NSDictionary).allKeys)
        print((UserDefaults.standard.dictionaryRepresentation() as NSDictionary).allValues)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watched.count
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchlistTableViewCell
        
        cell.courseName.text = self.watched[indexPath.row].object(forKey: "courseTitle") as? String
        cell.profName.text = self.watched[indexPath.row].object(forKey: "instructor") as? String
        let day: String = self.watched[indexPath.row].object(forKey: "days") as! String
        let time: String = self.watched[indexPath.row].object(forKey: "time") as! String
        cell.courseTime.text = day + " " + time
        cell.classCode.text = self.watched[indexPath.row].object(forKey: "courseCode") as? String
        cell.location.text = self.watched[indexPath.row].object(forKey: "place") as? String
        cell.status.text = self.watched[indexPath.row].object(forKey: "status") as? String
        let maxSeats : Int = self.watched[indexPath.row].object(forKey: "maxSeats") as! Int
        let takenSeats : Int = self.watched[indexPath.row].object(forKey: "seatsTaken") as! Int
        let reservedSeats : Int = self.watched[indexPath.row].object(forKey: "seatsReserved") as! Int
        cell.seatsAvail.text = String(maxSeats - takenSeats - reservedSeats)
        
        return cell
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
