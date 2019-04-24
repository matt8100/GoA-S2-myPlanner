//
//  CalendarViewController.swift
//  Homework App (GOAS2)
//
//  Created by Matthew Mao on 2019-04-02.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Hue

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var homeworkTableView: UITableView!
    
    //MARK: - Variables
    var calendarDataSource: [String:[Homework]] = [:]
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        return formatter
    }
    var homeworksToShow: [Homework] = []
    var homeworkToSegue: Homework?
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeworkTableView.delegate = self
        homeworkTableView.dataSource = self
        
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        let currentDate = Date()
        calendarView.scrollToDate(currentDate)
        calendarView.selectDates([currentDate])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        populateDataSource()
    }
    
    //MARK: - Custom Functions
    func populateDataSource() {
        for homework in homeworks
        {
            calendarDataSource[homework.dueDay!] = [homework]
        }
        
        calendarView.reloadData()
    }
    
    //MARK: - TableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworksToShow.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Homework:"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarHomework", for: indexPath) as! CalendarHomeworkTableViewCell
        
        cell.homeworkTitle.text = homeworksToShow[indexPath.row].title
        cell.homeworkCourse.text = homeworksToShow[indexPath.row].className
        
        return cell
    }
    
    //MARK: - Calendar Delegates
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? CalendarCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: CalendarCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor(hex: "#2A2626")
        } else {
            cell.dateLabel.textColor = UIColor(hex: "#B5B5B5")
        }
    }
    
    func handleCellSelected(cell: CalendarCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  20
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }
    
    func handleCellEvents(cell: CalendarCell, cellState: CellState) {
        let dateString = formatter.string(from: cellState.date)
        if calendarDataSource[dateString] == nil {
            cell.dotView.isHidden = true
        } else {
            cell.dotView.isHidden = false
        }
    }
    
    //MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeworkToSegue = homeworksToShow[indexPath.row]
        performSegue(withIdentifier: "calendarToHomeworkDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let assignmentViewController = segue.destination as? AssignmentViewController {
            assignmentViewController.homework = homeworkToSegue
            assignmentViewController.fromCourse = false
        }
    }
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
    let startDate = formatter.date(from: "Jan 01 2019")!
    let endDate = formatter.date(from: "Dec 31 2025")!
    return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
    let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
    return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
        
        let dateAsString = formatter.string(from: date)
        
        homeworksToShow.removeAll()
        
        for homework in homeworks
        {
            if (homework.dueDay == dateAsString)
            {
                homeworksToShow += [homework]
            }
        }
        
        homeworkTableView.reloadData()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMMM"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "CalendarHeader", for: indexPath) as! CalendarHeader
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
}
