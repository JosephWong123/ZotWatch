//
//  SectionTableViewCell.swift
//  GroupProject
//
//  Created by Garry Fanata on 6/6/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit


class SectionTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var instructorLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
