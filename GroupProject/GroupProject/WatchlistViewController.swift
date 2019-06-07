//
//  WaitlistViewController.swift
//  
//
//  Created by Garry Fanata on 6/6/19.
//

import UIKit

//need to implement remove section
class WatchlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var watched: [CourseSection] = []
    
    //should be call every view did load or when refreshed
    func getCourses(){
        //reads NSUserDefaults for all the dictionaries saved in the watchlist
        //calls GetCourseInfo.findSection() for all the dictionaries and added to watched dictionary
        //displays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchlistTableViewCell
        
        return cell
    }
    

    @IBOutlet var tableVieww: UITableView!
    
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
