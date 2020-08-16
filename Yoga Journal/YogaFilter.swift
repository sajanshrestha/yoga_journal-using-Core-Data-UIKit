//
//  YogaFilter.swift
//  Yoga Journal
//
//  Created by Sajan Shrestha on 8/15/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation

enum YogaFilter {
    
    case yogasOverMinuteDuration
    case all
    
    var filteringPredicate: NSPredicate? {
        
        switch self {
            
        case .yogasOverMinuteDuration:
            return NSPredicate(format: "duration > '60'")
        case .all:
            return nil
        }
    }
}
