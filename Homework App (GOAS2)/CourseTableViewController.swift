//
//  CourseTableViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/24/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit
import Hue

class CourseTableViewController: UITableViewController {

    //MARK: Properties
    
    var courseToDisplay: Course? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return courses.count
    }

    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "CourseTableViewCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CourseTableViewCell else {
            fatalError("The dequeued cell is not an instance of CourseTableViewCell.")
        }
        // Fetches the appropriate course for the data source layout.
        let course = courses[indexPath.row]
      
        cell.nameLabel.text = course.name
        cell.nameLabel.textColor = course.colour
    
        return cell 
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        courseToDisplay = course
        performSegue(withIdentifier: "segueTocourseViewing", sender: self)
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
            courses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let courseDetailViewController = segue.destination as? CourseDetailViewController {
            // We get here when we're about go segue to a courseDetailViewController
            courseDetailViewController.course = courseToDisplay
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Actions
    @IBAction func unwindToCourseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddCourseViewController, let course = sourceViewController.course {
            
            // Add a new course.
            let newIndexPath = IndexPath(row: courses.count, section: 0)
            
            courses.append(course)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
