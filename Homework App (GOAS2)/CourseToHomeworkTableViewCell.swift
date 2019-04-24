//
//  CourseToHomeworkTableViewCell.swift
//  Homework App (GOAS2)
//
//  Created by Hod on 2019-04-23.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit

class CourseToHomeworkTableViewCell: UITableViewCell {

    //MARK: - IBoutlets
    @IBOutlet weak var homeworkTitle: UILabel!
    @IBOutlet weak var homeworkDueDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
