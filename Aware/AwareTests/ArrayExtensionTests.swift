//
//  ArrayExtensionTests.swift
//  AwareTests
//
//  Created by christian on 11/12/24.
//

import Testing
@testable import Aware

struct ArrayExtensionTests {
    @Test func arrayAverageForInt() {
        let arr = [1, 2, 3, 4, 5]
        let expectedAverage = 3
        let average = arr.average
        #expect(average == expectedAverage)
    }
    
    @Test func arrayAverageReturnsZeroWhenEmpty() {
        let arr: [Int] = []
        let average = arr.average
        #expect(average == 0)
    }
    
    @Test func arrayAverageWhenCollectionSumIsZero() {
        let arr: [Int] = [0, 0, 0]
        let average = arr.average
        
        #expect(average == 0)
    }
}
