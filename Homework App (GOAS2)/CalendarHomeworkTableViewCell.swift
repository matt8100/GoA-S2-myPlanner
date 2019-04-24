//
//  CalendarHomeworkTableViewCell.swift
//  Homework App (GOAS2)
//
//  Created by Talia Babecoff-Kimhi on 2019-04-23.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit

class CalendarHomeworkTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var homeworkTitle: UILabel!
    @IBOutlet weak var homeworkCourse: UILabel!
    
    //MARK: - TableViewCell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
