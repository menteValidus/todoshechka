//
//  Created on 24.03.2023.
//

@testable import todoshechka
import XCTest

final class MainScreenViewModelTests: XCTestCase {
    
    var sut: MainScreenViewModel!
    
    override func setUp() {
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testStart() throws {
        let testDate = Calendar.current.date(year: 2023, month: 3, day: 20, hour: 8, minute: 0)
        sut = .init(
            dateGenerator: {
                return testDate!
            }
        )
        
        sut.start()
        
        XCTAssertEqual(R.string.localizable.welcome_good_morning(), sut.welcomeMessage)
        XCTAssertEqual("Mar 20, 2023", sut.selectedFormattedDate)
    }
    
    func testRelativeDateIsAssigned() {
        sut.start()
        
        XCTAssertTrue(sut.selectedRelativeDate.contains("Today"))
    }
}

private extension Calendar {
    func date(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date? {
        date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute))
    }
}
