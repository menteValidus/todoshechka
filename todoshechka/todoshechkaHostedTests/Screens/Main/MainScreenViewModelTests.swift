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
    
    func testDataIsLoaded() {
        let testDate = Calendar.current.date(year: 2023, month: 3, day: 20, hour: 8, minute: 0)
        sut = .init(
            dateGenerator: {
                return testDate!
            }
        )
        
        sut.load()
        
        XCTAssertEqual(R.string.localizable.welcome_good_morning(), sut.welcomeMessage)
        XCTAssertEqual("Mar 20, 2023", sut.selectedFormattedDate)
    }
    
    func testRelativeDateIsAssigned() {
        sut.load()
        
        XCTAssertTrue(sut.selectedRelativeDate.contains("Today"))
    }
}
