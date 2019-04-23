//
//  CourseDetailViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 4/9/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit
import os.log
class CourseDetailViewController: UIViewController {

    // MARK:Properties
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    
    var course: Course? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard (self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailViewController") as? CourseDetailViewController) != nil else {
            return
        }
        // In here, I can display the course object
        
        blockLabel.text = course?.block
        timeLabel.text = course?.time
        teacherLabel.text = course?.teacher
        placeLabel.text = course?.place
        navigationItem.title = course?.name
    }
    

}

