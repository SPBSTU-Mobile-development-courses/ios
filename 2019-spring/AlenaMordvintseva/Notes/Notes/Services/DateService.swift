//
//  DateService.swift
//  Notes
//
//  Created by Mordvintseva Alena on 13/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

class DateService {
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let dateString = formatter.string(from: Date())
        return dateString
    }
}
