//
//  HomeworkTableViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/21/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit

class HomeworkTableViewController: UITableViewController {

    //MARK: Properties
    
    var homeworks = [Homework]()
    var homeworkToDisplay: Homework? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.blue;
        
        // Load the sample data.
        loadSampleHomeworks()
        
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
        cell.DueDayLabel.text = homework.dueDay
        
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
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    @IBAction func unwindToHomeworkList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddHomeworkViewController, let homework = sourceViewController.homework {
            // Add a new homework.
            let newIndexPath = IndexPath(row: homeworks.count, section: 0)
            
            homeworks.append(homework)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
    }
    
    //Mark: Private Function
    private func loadSampleHomeworks() {
        guard let homework1 = Homework(className: "Math", title: "Pre-calculus 12", dueDay: "May 20", priority: "high", reminder:"Two days before",others:"Test coming soon") else {
            fatalError("Unable to instantiate homework1")
        }
        guard let homework2 = Homework(className: "Chemistry", title: "Lab 11", dueDay: "May 26",priority: "Medium", reminder:"One week before",others:"") else {
            fatalError("Unable to instantiate homework2")
        }
        guard let homework3 = Homework(className: "Biology", title: "Protist Test", dueDay: "Apr 23", priority: "Low", reminder:"One day before",others:"Test in three weeks") else {
            fatalError("Unable to instantiate homework3")
        }
        homeworks += [homework1, homework2, homework3]
    }
}
