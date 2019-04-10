//
//  Course.swift
//  Homework App (GOAS2)
//
//  Created by Cathy Chen on 3/24/19.
//  Copyright © 2019 Fortune Cookies. All rights reserved.
//

import Foundation
import UIKit

class Course{
    var name: String
    var block: String?
    var colour: String?
    var time: String?
    var teacher: String?
    var place: String?
    
    init?(name: String,block: String?,colour: String?, time: String?, teacher: String?, place: String?){
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
       
        // Initialize stored properties.
        self.name = name
        self.block = block
        self.colour = colour
        self.time = time
        self.teacher = teacher
        self.place = place
        
    }
}
