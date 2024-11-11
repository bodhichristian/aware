//
//  AwareTests.swift
//  AwareTests
//
//  Created by christian on 11/8/24.
//

import Testing
@testable import Aware

struct GridHelperTests {

    @Test func gridifyReturnsCorrectCapacity() async throws {
        let data: [DailyMindfulness] = []
        let capacity = 111
        
        let dataForGrid = GridHelper.gridify(data, with: capacity)
        
        #expect(dataForGrid.count == capacity)
    }

}

