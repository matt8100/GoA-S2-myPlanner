//
//  AssignmentViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 4/2/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit

class AssignmentViewController: UIViewController{
    
     // MARK:Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDayLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var othersLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var completionPercentage: UILabel!
    
    var homework: Homework? = nil
    var course: Course? = nil
    var fromCourse = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard (self.storyboard?.instantiateViewController(withIdentifier: "AssignmentViewController") as? AssignmentViewController) != nil else {
            return
        }
        
        // In here, I can display the homework object
        titleLabel.text = homework?.title
        dueDayLabel.text = homework?.dueDay
        priorityLabel.text = homework?.priority
        othersLabel.text = homework?.others
        
//        navigationItem.title = homework?.className
        navigationController?.navigationBar.backgroundColor = course?.colour
        
        var title: String? = String()
        
        if(fromCourse)
        {
            title = "Assignment"
        }
        else
        {
            title = homework?.className
        }
        self.title = title
        
        completionPercentage.text = String(format: "%.0f%%", sliderOutlet.value)

    }
    //Actions:
    @IBAction func sliderAction(_ sender: UISlider) {
        completionPercentage.text = String(format: "%.0f%%", sliderOutlet.value)
    }
    
    
    

//
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

