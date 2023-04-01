//
//  Created on 24.03.2023.
//

@testable import todoshechka
import XCTest

@MainActor
final class MainScreenViewModelTests: XCTestCase {
    
    var sut: MainScreen.ViewModel!
    var tasksRepository: TasksRepositoryMock!
    
    override func setUp() {
        tasksRepository = TasksRepositoryMock()
        sut = .init(
            tasksRepository: tasksRepository,
            createTaskButtonTapped: {}
        )
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testDataIsLoaded() async {
        let testDate = Calendar.current.date(year: 2023, month: 3, day: 20, hour: 8, minute: 0)
        sut = .init(
            tasksRepository: TasksRepositoryMock(),
            dateGenerator: {
                return testDate!
            },
            createTaskButtonTapped: {}
        )
        
        await sut.load()
        
        XCTAssertEqual(R.string.localizable.main_welcome_good_morning(), sut.welcomeMessage)
        XCTAssertEqual("Mar 20, 2023", sut.selectedFormattedDate)
    }
    
    func testRelativeDateIsAssigned() async {
        await sut.load()
        
        XCTAssertTrue(sut.selectedRelativeDate.contains("Today"))
    }
    
    func testCreateTaskActionIsTriggered() async {
        let expectation = XCTestExpectation()
        sut = .init(
            tasksRepository: TasksRepositoryMock(),
            createTaskButtonTapped: {
                expectation.fulfill()
            }
        )
        
        sut.createTask()
        
        wait(for: [expectation], timeout: 0.001)
    }
    
    func testDoneTasksPercentageIsCalculatedCorrectly() async {
        tasksRepository.tasks = [
            .init(id: 1, name: "", description: "", board: .init(id: 1, name: ""), completed: true),
            .init(id: 1, name: "", description: "", board: .init(id: 1, name: ""), completed: false),
        ]
        
        await sut.load()
        
        XCTAssertEqual("50% Done", sut.completedTaskPercentage)
    }
}
