//
//  Created on 24.03.2023.
//

@testable import todoshechka
import XCTest

final class MainScreenViewModelTests: XCTestCase {
    
    var sut: MainScreen.ViewModel!
    
    override func setUp() {
        sut = .init(createTaskButtonTapped: {})
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testDataIsLoaded() async {
        let testDate = Calendar.current.date(year: 2023, month: 3, day: 20, hour: 8, minute: 0)
        sut = .init(
            dateGenerator: {
                return testDate!
            },
            createTaskButtonTapped: {}
        )
        
        await sut.load()
        
        let welcomeMessage = await sut.welcomeMessage
        let selectedFormattedDate = await sut.selectedFormattedDate
        XCTAssertEqual(R.string.localizable.welcome_good_morning(), welcomeMessage)
        XCTAssertEqual("Mar 20, 2023", selectedFormattedDate)
    }
    
    func testRelativeDateIsAssigned() async {
        await sut.load()
        
        let selectedRelativeDate = await sut.selectedRelativeDate
        XCTAssertTrue(selectedRelativeDate.contains("Today"))
    }
    
    func testCreateTaskActionIsTriggered() async {
        let expectation = XCTestExpectation()
        sut = .init(
            createTaskButtonTapped: {
                expectation.fulfill()
            }
        )
        
        await sut.createTask()
        
        wait(for: [expectation], timeout: 0.001)
    }
}
