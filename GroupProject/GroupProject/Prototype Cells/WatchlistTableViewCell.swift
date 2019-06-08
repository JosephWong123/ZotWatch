//
//  WatchlistTableViewCell.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit

//Need to connect all the outlets from the storyboard
class WatchlistTableViewCell: UITableViewCell {

    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var courseTime: UILabel!
    @IBOutlet weak var classCode: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var seatsAvail: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var lecture: [CourseSection]!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
   

}
