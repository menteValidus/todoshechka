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
        let testDate = Calendar.current.today(hour: 8, minute: 0)
        sut = .init(
            dateGenerator: {
                return testDate!
            }
        )
        
        sut.start()
        
        XCTAssertEqual(R.string.localizable.welcome_good_morning(), sut.welcomeMessage)
    }
}

private extension Calendar {
    func today(hour: Int, minute: Int) -> Date? {
        date(from: DateComponents(year: 2023, month: 3, day: 24, hour: hour, minute: minute))
    }
}
