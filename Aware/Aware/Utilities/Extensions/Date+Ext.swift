//
//  Date+Ext.swift
//  Aware
//
//  Created by christian on 11/1/24.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
}
