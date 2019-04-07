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
 
    
    init?(name: String){
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
       
        // Initialize stored properties.
        self.name = name
    }
}
