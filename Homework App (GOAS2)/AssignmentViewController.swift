//
//  AssignmentViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 4/2/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit

class AssignmentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    var homeworks = [Homework]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    let cellIdentifier = "AssignmentTableViewCell"
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AssignmentTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AssignmentTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let homework = homeworks[indexPath.row]
        
        cell.TitleLabel.text = homework.title
        cell.DueDayLabel.text = homework.dueday
        cell.PriorityLabel.text = homework.Priority
        
        return cell
    
    

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
}
