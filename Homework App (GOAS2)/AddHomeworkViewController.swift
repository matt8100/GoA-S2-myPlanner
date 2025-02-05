//
//  AddHomeworkViewController.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/19/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit
import os.log

class AddHomeworkViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK:Properties
    @IBOutlet weak var AddClass: UITextField!
    @IBOutlet weak var AddTitle: UITextField!
    @IBOutlet weak var AddDueDay: UITextField!
    @IBOutlet weak var AddPriority: UITextField!
    @IBOutlet weak var AddOthers: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `HomeworkTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new Homework.
     */
    
    var homework: Homework?
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Luke screwed around here
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(updateDateField), for: .valueChanged)
        AddDueDay.inputView = datePicker
        
        let picker = UIPickerView()
//        picker.dataSource = self
        picker.delegate = self
        AddClass.inputView = picker
        
        func viewWillAppear(animated: Bool) {
            super.viewDidLoad()
            self.navigationController?.isToolbarHidden = false
            self.tabBarController?.tabBar.isHidden = true
        }
        
        guard (self.storyboard?.instantiateViewController(withIdentifier: "AddHomeworkViewController") as? AddHomeworkViewController) != nil else {
            return
        }
        
        // Handle the text field’s user input through delegate callbacks.
        AddClass?.delegate = self
        AddTitle?.delegate = self
        AddDueDay?.delegate = self
        AddPriority?.delegate = self
        AddOthers?.delegate = self
        
        
        // Enable the Save button only if the text field has valid inputs.
        updateSaveButtonState()
        
        //Hod:
    }
    
    @objc func updateDateField(_ sender: UIDatePicker) {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.locale = Locale(identifier: "en_US_POSIX")
        dateFormat.dateFormat = "MMM dd yyyy"
        AddDueDay.text = dateFormat.string(from: sender.date)
    }
    
    //MARK: - UITextFieldDelegate
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
    
    //Mark: - UIPickerView Delegates (added by Hod)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courses[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        AddClass.text = courses[row].name
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
            let priority = AddPriority.text ?? ""
            let others = AddOthers.text ?? ""
        
            // Set the homework to be passed to HomeworkTableViewController after the unwind segue.
        homework = Homework(className: className, title: title, dueDay: dueDay, priority: priority, others: others)
            

    }
    //MARK: - Custom Functions
    private func updateSaveButtonState() { // Disable the save button if the text field is empty.
        let canSave = !AddClass.text!.isEmpty && !AddTitle.text!.isEmpty
        
        if(canSave)
        {
            saveButton.isEnabled = true
        }
        else
        {
            saveButton.isEnabled = false
        }
    }
    
}

