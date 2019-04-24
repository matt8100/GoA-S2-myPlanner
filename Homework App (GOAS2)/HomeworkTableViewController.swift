//
//  HomeworkTableViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/21/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit

class HomeworkTableViewController: UITableViewController {

    //MARK: - Properties
    var homeworkToDisplay: Homework? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white;
        
        
        // Load the sample data.
        loadSampleHomeworks()
        loadSampleCourses()
        print(homeworks)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeworks.count
    }

    
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "HomeworkTableViewCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeworkTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HomeworkTableViewCell.")
        }
        // Fetches the appropriate homework for the data source layout.
        let homework = homeworks[indexPath.row]
        
        
        cell.ClassNameLabel.text = homework.className
        cell.TitleLabel.text = homework.title
        cell.DueDayLabel.text = homework.dueDay?.trunc(length: 6)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homework = homeworks[indexPath.row]
        homeworkToDisplay = homework
        performSegue(withIdentifier: "segueToHomeworkViewing", sender: self)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             // Delete the row from the data source
            homeworks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let assignmentViewController = segue.destination as? AssignmentViewController {
            // We get here when we're about go segue to a AssignmentViewController
            assignmentViewController.homework = homeworkToDisplay
            assignmentViewController.fromCourse = false
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToHomeworkList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddHomeworkViewController, let homework = sourceViewController.homework {
            // Add a new homework.
            let newIndexPath = IndexPath(row: homeworks.count, section: 0)
            
            homeworks.append(homework)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
    }
    
    //MARK: - Private Function
    private func loadSampleHomeworks() {
        guard let homework1 = Homework(className: "Math", title: "pg 346 #3-4, 6-9", dueDay: "May 20 2019", priority: "high", others:"Test coming soon") else {
            fatalError("Unable to instantiate homework1")
        }
        guard let homework2 = Homework(className: "Chemistry", title: "Enthalpy Lab", dueDay: "May 26 2019",priority: "Medium", others:"") else {
            fatalError("Unable to instantiate homework2")
        }
        guard let homework3 = Homework(className: "Biology", title: "Protist Test", dueDay: "May 23 2019", priority: "Low",others:"Test in three weeks") else {
            fatalError("Unable to instantiate homework3")
        }
        homeworks += [homework1, homework2, homework3]
    }
    
    private func loadSampleCourses() {
        guard let course1 = Course(name: "Math", block:"1-1", colour: UIColor(hex: "#F56976"),time:"9:00 - 10:30", teacher:"Ms. Gilmer", place:"B202") else {
            fatalError("Unable to instantiate course1")
        }
        guard let course2 = Course(name: "Chemistry", block:"1-2",colour:UIColor(hex: "#FF9770"), time:"10:40 - 12:00", teacher:"Mr. Ryan", place:"B203") else {
            fatalError("Unable to instantiate course2")
        }
        guard let course3 = Course(name: "Biology", block:"2-3",colour:UIColor(hex: "#FFD670"), time:"1:00 - 2:30", teacher:"Ms. Perry", place:"C104") else {
            fatalError("Unable to instantiate course3")
        }
        courses += [course1, course2, course3]
    }
}

extension String {
    func trunc(length: Int) -> String {
        return (self.count > length) ? String(self.prefix(length)) : self
    }
}
