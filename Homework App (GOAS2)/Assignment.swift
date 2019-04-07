//
//  Assignment.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 4/2/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import Foundation

class Assignment {
    var Title: String
    var DueDay: String
    var Priority: String
    var Reminder: String
    var Others: String
    
    init?(Title:String, DueDay: String, Priority: String, Reminder: String, Others: String){
        
        self.Title = Title
        self.DueDay = DueDay
        self.Priority = Priority
        self.Reminder = Reminder
        self.Others = Others
}
}
