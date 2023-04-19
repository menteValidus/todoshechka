//
//  Created on 24.03.2023.
//

@testable import todoshechka
import XCTest

@MainActor
final class MainScreenViewModelTests: XCTestCase {
    
    var sut: MainScreen.ViewModel!
    var tasksRepository: TasksRepositoryMock!
    var boardsRepository: BoardsRepositoryMock!
    var tagColorProvider: TagColorProviderMock!
    
    override func setUp() {
        tasksRepository = TasksRepositoryMock()
        boardsRepository = BoardsRepositoryMock()
        tagColorProvider = TagColorProviderMock()
        sut = createSut()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testDataIsLoaded() async {
        let testDate = Calendar.current.date(year: 2023, month: 3, day: 20, hour: 8, minute: 0)
        sut = createSut(
            dateGenerator: {
                return testDate!
            }
        )
        
        await sut.load()
        
        XCTAssertEqual(R.string.localizable.main_welcome_good_morning(), sut.welcomeMessage)
        XCTAssertEqual("Mar 20, 2023", sut.selectedFormattedDate)
        XCTAssertNil(sut.completedTaskPercentage)
    }
    
    func testRelativeDateIsAssigned() async {
        await sut.load()
        
        XCTAssertTrue(sut.selectedRelativeDate.contains("Today"))
    }
    
    func testCreateTaskActionIsTriggered() async {
        let expectation = XCTestExpectation()
        sut = createSut(
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
    
    func testTasksNumberCalculatedCorrectly() async {
        tasksRepository.tasks = [
            .init(id: 1, name: "", description: "", board: .init(id: 1, name: ""))
        ]
        
        await sut.load()
        
        XCTAssertEqual(sut.tasksNumber, 1)
    }
    
    func testBoardsNumberCalculatedCorrectly() async {
        boardsRepository.boards = [.init(id: 1, name: "")]
        
        await sut.load()
        
        XCTAssertEqual(sut.boardsNumber, 1)
    }
    
    func testTaskCreatedOutside() async {
        tasksRepository.tasks = []
        await sut.load()
        
        let expectedTask = TaskCard(
            id: 1, name: "", boardName: "", remainingTime: nil, completed: false, tagColor: tagColorProvider.providedColor
        )
        let task = Todo.Task(
            id: expectedTask.id, name: expectedTask.name, description: "", board: .init(id: 1, name: expectedTask.boardName)
        )
        tasksRepository._eventPublisher.send(.added(task))
        await Task.yield()
        
        XCTAssertEqual([expectedTask], sut.taskCards)
    }
    
    private func createSut(
        dateGenerator: @escaping DateGenerator = Date.init,
        createTaskButtonTapped: @escaping VoidCallback = {}
    ) -> MainScreen.ViewModel {
        .init(
            tasksRepository: tasksRepository,
            boardsRepository: boardsRepository,
            tagColorProvider: tagColorProvider,
            dateGenerator: dateGenerator,
            createTaskButtonTapped: createTaskButtonTapped,
            taskTapped: { _ in }
        )
    }
}
