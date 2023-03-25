//
//  Created on 25.03.2023.
//

@testable import todoshechka
import XCTest

final class RelativeWeekDayFormatterTests: XCTestCase {
    
    let todayTuesday = Calendar.current.date(year: 2023, month: 3, day: 21, hour: 12, minute: 0)!
    var sut: RelativeWeekDayFormatter!
    
    override func setUp() {
        sut = .init(todayGenerator: { self.todayTuesday })
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testTodayDateIsRelative() {
        let result = sut.string(from: todayTuesday)
        
        XCTAssertEqual("Today's Tuesday", result)
    }
    
    func testYesterdayDateIsRelative() {
        let yesterdayMonday = Calendar.current.date(year: 2023, month: 3, day: 20, hour: 12, minute: 0)!
        
        let result = sut.string(from: yesterdayMonday)
        
        XCTAssertEqual("Yesterday's Monday", result)
    }
    
    func testTomorrowDateIsRelative() {
        let tomorrowWednesday = Calendar.current.date(year: 2023, month: 3, day: 22, hour: 12, minute: 0)!
        
        let result = sut.string(from: tomorrowWednesday)
        
        XCTAssertEqual("Tomorrow's Wednesday", result)
    }
}
