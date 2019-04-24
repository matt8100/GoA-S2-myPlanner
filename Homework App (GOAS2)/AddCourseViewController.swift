//
//  AddCourseViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/24/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit
import os.log

class AddCourseViewController: UIViewController,UITextFieldDelegate {
    

    
    // MARK:Properties
    @IBOutlet weak var AddCourse: UITextField!
    @IBOutlet weak var AddBlock: UITextField!
    @IBOutlet weak var AddColour: UITextField!
    @IBOutlet weak var AddTime: UITextField!
    @IBOutlet weak var AddTeacher: UITextField!
    @IBOutlet weak var AddPlace: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    /*
     This value is either passed by `AddCourseTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new Course.
     */
    
    var course: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard (self.storyboard?.instantiateViewController(withIdentifier: "AddCourseViewController") as? AddCourseViewController) != nil else {
            return
        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "#FF5941")
        
        // Handle the text field’s user input through delegate callbacks.
        AddCourse?.delegate = self
        AddBlock?.delegate = self
        AddColour?.delegate = self
        AddTime?.delegate = self
        AddTeacher?.delegate = self
        AddPlace?.delegate = self
        
        // Enable the Save button only if the text field has a valid Course name.
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

    
    // MARK: - Navigation

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
        let name = AddCourse.text ?? ""
        let block = AddBlock.text ?? ""
        let colour = AddColour.textColor
        let time = AddTime.text ?? ""
        let teacher = AddTeacher.text ?? ""
        let place = AddPlace.text ?? ""
        
        // Set the course to be passed to CourseTableViewController after the unwind segue.
        course = Course(name: name, block: block, colour: colour, time: time, teacher: teacher, place: place)

    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = AddCourse.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
