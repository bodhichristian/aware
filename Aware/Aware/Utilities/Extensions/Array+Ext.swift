//
//  Array+Ext.swift
//  Aware
//
//  Created by christian on 11/1/24.
//

import Foundation

extension Array where Element == Int {
    /// Return the average value for an array of ``Int``
    var average: Int {
        guard !self.isEmpty else { return 0 } // guard against an empty array
        let total = self.reduce(0, +) // get the sum of element values
        return total/self.count // divide by the number of elements
    }
}




