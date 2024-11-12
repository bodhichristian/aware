//
//  AwareTests.swift
//  AwareTests
//
//  Created by christian on 11/8/24.
//

import Testing
@testable import Aware

struct GridHelperTests {

    @Test func gridifyEmptyCollection() {
        let data: [DailyMindfulness] = []
        let capacity = 111
        
        let dataForGrid = GridHelper.gridify(data, with: capacity)
        
        #expect(dataForGrid.count == capacity)
    }
    
    @Test func gridifyCollectionSmallerThanCapacity() {
        let session = DailyMindfulness(date: .now, minutes: 10)
        let sessionCount = 20
        let data: [DailyMindfulness] = Array(repeating: session, count: sessionCount)
        
        let capacity = 111
        let dataForGrid = GridHelper.gridify(data, with: capacity)
        
        #expect(dataForGrid.count > sessionCount)
        #expect(dataForGrid.count == capacity)
    }
    
    @Test func gridifyCollectionLargerThanCapacity() {
        let session = DailyMindfulness(date: .now, minutes: 10)
        let sessionCount = 200
        let data: [DailyMindfulness] = Array(repeating: session, count: sessionCount)
        
        let capacity = 111
        let dataForGrid = GridHelper.gridify(data, with: capacity)
        
        #expect(dataForGrid.count < sessionCount)
        #expect(dataForGrid.count == capacity)
    }
}

