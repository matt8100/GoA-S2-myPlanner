//
//  Homework.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/21/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import Foundation

import UIKit

class Homework {
    var className: String
    var title: String?
    var dueDay: String?
    var priority: String?
    var reminder: String?
    var others: String?
    init?(className: String, title: String?, dueDay: String?, priority: String?, reminder: String?, others: String?){
        
        // The name must not be empty
        guard !className.isEmpty else {
            return nil
        }
        
        
         // Initialize stored properties.
        self.className = className
        self.title = title
        self.dueDay = dueDay
        self.priority = priority
        self.reminder = reminder
        self.others = others
    }
}
