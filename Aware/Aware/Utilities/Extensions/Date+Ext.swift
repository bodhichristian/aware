//
//  Date+Ext.swift
//  Aware
//
//  Created by christian on 11/1/24.
//

import Foundation

extension Date {
    /// A representation of the day of the week where 1 is Sunday
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
}
