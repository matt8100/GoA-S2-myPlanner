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

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    var calendarDataSource: [String:[String]] = [:]
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        return formatter
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        populateDataSource()
    }
    func populateDataSource() {
        calendarDataSource = [
            "May 23 2019": ["Protist Test"],
            "May 20 2019": ["pg 346 #3-4, 6-9"],
            "May 26 2019": ["Enthalpy Lab"]
        ]
        for homework in homeworks {
            calendarDataSource[homework.dueDay!, default: []] += [homework.title!]
        }
        calendarView.reloadData()
        print(calendarDataSource)
        print(homeworks)
    }
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
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
    let startDate = formatter.date(from: "Jan 01 2019")!
    let endDate = formatter.date(from: "Dec 31 2019")!
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
