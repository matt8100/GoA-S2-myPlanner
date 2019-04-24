//
//  HomeworkTableViewCell.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/21/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit

class HomeworkTableViewCell: UITableViewCell {
    
    // Mark: Properties
    @IBOutlet weak var ClassNameLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DueDayLabel: UILabel!
    @IBOutlet weak var innerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.25)
        
        innerView.layer.cornerRadius = 10
        innerView.layer.shadowColor = shadowColor.cgColor
        innerView.layer.shadowOpacity = 1
        innerView.layer.shadowRadius = 1
        innerView.layer.shadowOffset = CGSize.init(width:0, height:1)
        innerView.backgroundColor = UIColor.white
    }
    
}

