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
    var title: String
    var dueDay: String
    
    init?(className: String, title: String, dueDay: String){
        
        // The name must not be empty
        guard !className.isEmpty else {
            return nil
        }
        guard !title.isEmpty else {
            return nil
        }
        guard !dueDay.isEmpty else {
            return nil
        }
        
         // Initialize stored properties.
        self.className = className
        self.title = title
        self.dueDay = dueDay
        
    }
}
