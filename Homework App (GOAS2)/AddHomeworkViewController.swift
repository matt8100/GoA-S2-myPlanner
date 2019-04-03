//
//  AddHomeworkViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/19/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit
import os.log

class AddHomeworkViewController: UIViewController,UITextFieldDelegate{
    
    // MARK:Properties
    @IBOutlet weak var AddClass: UITextField!
    @IBOutlet weak var AddTitle: UITextField!
    @IBOutlet weak var AddDueDay: UITextField!
    @IBOutlet weak var AddPriority: UITextField!
    @IBOutlet weak var AddReminder: UITextField!
    @IBOutlet weak var AddOthers: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `HomeworkTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new Homework.
     */
    var homework: Homework?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard (self.storyboard?.instantiateViewController(withIdentifier: "AddHomeworkViewController") as? AddHomeworkViewController) != nil else {
            return
        }
        
        // Handle the text field’s user input through delegate callbacks.
        AddClass?.delegate = self
        AddTitle?.delegate = self
        AddDueDay?.delegate = self
        AddPriority?.delegate = self
        AddReminder?.delegate = self
        AddOthers?.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
        
    }
   
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            // Disable the Save button while editing.
            saveButton.isEnabled = false
        
        updateSaveButtonState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
   //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
            let className = AddClass.text ?? ""
            let title = AddTitle.text ?? ""
            let dueDay = AddDueDay.text ?? ""
            
            // Set the homework to be passed to HomeworkTableViewController after the unwind segue.
            homework = Homework(className: className, title: title, dueDay: dueDay)
            

    }
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = AddClass.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}
