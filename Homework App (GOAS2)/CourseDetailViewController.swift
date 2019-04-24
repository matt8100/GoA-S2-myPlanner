//
//  CourseDetailViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 4/9/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit
import os.log
class CourseDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var homeworkTableView: UITableView!
    
    //MARK: - Variables
    var course: Course? = nil
    var homeworkToShow: [Homework] = []
    var homeworkToSegue: Homework?
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        guard (self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailViewController") as? CourseDetailViewController) != nil else {
            return
        }
        // In here, I can display the course object
        
        homeworkTableView.delegate = self
        homeworkTableView.dataSource = self
        
        blockLabel.text = course?.block
        timeLabel.text = course?.time
        teacherLabel.text = course?.teacher
        placeLabel.text = course?.place
        navigationItem.title = course?.name
    }
    
    //Hod:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        for homework in homeworks
        {
            if(homework.className == course?.name)
            {
                homeworkToShow += [homework]
            }
        }
        
    }
    
    //MARK: - Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeworkOnCategory", for: indexPath) as! CourseToHomeworkTableViewCell
        
        let currentIndex = indexPath.row
        
        cell.homeworkTitle.text = homeworkToShow[currentIndex].title
        cell.homeworkDueDay.text = homeworkToShow[currentIndex].dueDay
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeworkToSegue = homeworkToShow[indexPath.row]
        performSegue(withIdentifier: "courseToHomeworkDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Homework:"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let assignmentViewController = segue.destination as? AssignmentViewController {
            assignmentViewController.homework = homeworkToSegue
            assignmentViewController.fromCourse = true
        }
    }
    

}

