//
//  Created on 28.03.23.
//

@testable import todoshechka
import XCTest

@MainActor
final class CreateTaskViewModelTests: XCTestCase {

    var sut: CreateTask.ViewModel!
    var boardsRepository: BoardRepositoryMock!
    var tasksRepository: TasksRepositoryMock!
    var tagColorProvider: TagColorProviderMock!
    
    override func setUp() {
        boardsRepository = .init()
        tasksRepository = .init()
        tagColorProvider = .init()
        
        sut = CreateTask.ViewModel(
            boardsRepository: boardsRepository,
            tasksRepository: tasksRepository,
            tagColorProvider: tagColorProvider
        )
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testDefaultDataIsLoaded() async {
        await sut.load()

        XCTAssertNil(sut.deadlineModel)
        XCTAssertTrue(sut.taskName.isEmpty, "\(sut.taskName) is not empty")
        XCTAssertTrue(sut.description.isEmpty, "\(sut.description) is not empty")
        XCTAssertFalse(sut.createButtonEnabled)
    }
    
    func testBoardTagsAreLoaded() async {
        let boardTag = BoardTag.Model(id: 1, name: "Board 1", color: .red)
        let expectedBoardTags = [boardTag]
        
        boardsRepository.boards = [
            Board(id: boardTag.id, name: boardTag.name)
        ]
        tagColorProvider.providedColor = boardTag.color
        
        await sut.load()
        
        XCTAssertEqual(expectedBoardTags, sut.boardTags)
        XCTAssertEqual(boardTag.id, sut.selectedBoardId)
        XCTAssertEqual(boardTag.color, sut.backgroundColor)
    }
    
    func testBoardSelectionChangesSelectedId() async {
        let board1 = Board(id: 1, name: "1")
        let board2 = Board(id: 2, name: "2")

        boardsRepository.boards = [board1, board2]
        await sut.load()

        sut.selectBoard(boardId: board2.id)

        XCTAssertEqual(board2.id, sut.selectedBoardId)
    }
    
    func testBoardSelectionChangesBackgroundColor() async {
        let board1 = Board(id: 1, name: "1")
        let board2 = Board(id: 2, name: "2")

        let expectedColor = tagColorProvider.providedColor

        boardsRepository.boards = [board1, board2]
        await sut.load()

        sut.selectBoard(boardId: board2.id)

        XCTAssertEqual(expectedColor, sut.backgroundColor)
    }
    
    func testDeadlineSelected() async {
        let date = Calendar.current.date(year: 2023, month: 3, day: 30, hour: 13, minute: 44)!
        let expectedResult = DeadlinePicker.Model(
            rawDate: date,
            formattedTime: "1:44 PM",
            formattedDate: "Mar 30, 2023"
        )

        sut.selectDate(date: date)

        XCTAssertEqual(expectedResult, sut.deadlineModel)
    }
    
    func testCreateButtonEnabledWhenDataIsVaild() async {
        let board1 = Board(id: 1, name: "1")
        boardsRepository.boards = [board1]
        await sut.load()
        
        sut.taskName = "Name"
        sut.description = "Description"
        
        XCTAssertTrue(sut.createButtonEnabled)
    }
    
    func testCreateTaskTriggersRepository() async {
        let expectedName = "Name"
        let expectedDescription = "Description"
        let expectedDeadline = Date()
        let expectedBoardId = 1
        
        let board1 = Board(id: expectedBoardId, name: "1")
        boardsRepository.boards = [board1]
        await sut.load()
        
        sut.taskName = expectedName
        sut.description = expectedDescription
        sut.selectDate(date: expectedDeadline)
        
        await sut.createTask()
        
        XCTAssertEqual(expectedName, tasksRepository.createdTaskInfo?.name)
        XCTAssertEqual(expectedDescription, tasksRepository.createdTaskInfo?.description)
        XCTAssertEqual(expectedDeadline, tasksRepository.createdTaskInfo?.deadline)
        XCTAssertEqual(expectedBoardId, tasksRepository.createdTaskInfo?.boardId)
    }
}
