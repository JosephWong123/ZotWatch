//
//  CourseTableViewCell.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    
    @IBOutlet var cnameLabel: UILabel!
    @IBOutlet var cnumLabel: UILabel!
    @IBOutlet var cdescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
