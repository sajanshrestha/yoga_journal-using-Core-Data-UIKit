//
//  Extensions.swift
//  Yoga Journal
//
//  Created by Sajan Shrestha on 8/16/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func getMediumFormatString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}


extension String {
    
    func capitalize() -> String {
        
        let splittedString = self.split(separator: " ")
        let capitalizedStrings = splittedString.map { $0.capitalized }
        return capitalizedStrings.joined(separator: " ")
    }
}


extension Int {
    
    func getHourMinSec() -> String {
        
        let (hours, minutes, seconds) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        
        let totalHours = hours == 0 ? "" : "\(hours)h "
        
        let totalMinutes = minutes == 0 ? "" : "\(minutes)m "
        
        let totalSeconds = seconds == 0 ? "" : "\(seconds)s"
        
        return "\(totalHours)\(totalMinutes)\(totalSeconds)"
    }
}
