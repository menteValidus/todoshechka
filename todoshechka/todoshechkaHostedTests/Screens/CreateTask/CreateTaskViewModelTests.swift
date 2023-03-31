//
//  Created on 28.03.23.
//

@testable import todoshechka
import XCTest

final class CreateTaskViewModelTests: XCTestCase {

    var sut: CreateTask.ViewModel!
    var boardsRepository: BoardRepositoryMock!
    var tagColorProvider: TagColorProviderMock!
    
    override func setUp() {
        boardsRepository = .init()
        tagColorProvider = .init()
        
        sut = CreateTask.ViewModel(
            boardsRepository: boardsRepository,
            tagColorProvider: tagColorProvider
        )
    }
    
    override func tearDown() {
        sut = nil
    }
    
    @MainActor
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
        
        let boardTags = await sut.boardTags
        XCTAssertEqual(expectedBoardTags, boardTags)
        let selectedBoardId = await sut.selectedBoardId
        XCTAssertEqual(boardTag.id, selectedBoardId)
        let backgroundColor = await sut.backgroundColor
        XCTAssertEqual(boardTag.color, backgroundColor)
    }
    
    func testBoardSelectionChangesSelectedId() async {
        let board1 = Board(id: 1, name: "1")
        let board2 = Board(id: 2, name: "2")

        boardsRepository.boards = [board1, board2]
        await sut.load()

        await sut.selectBoard(boardId: board2.id)

        let selectedBoardId = await sut.selectedBoardId
        XCTAssertEqual(board2.id, selectedBoardId)
    }
    
    @MainActor
    func testBoardSelectionChangesBackgroundColor() async {
        let board1 = Board(id: 1, name: "1")
        let board2 = Board(id: 2, name: "2")

        let expectedColor = tagColorProvider.providedColor

        boardsRepository.boards = [board1, board2]
        await sut.load()

        sut.selectBoard(boardId: board2.id)

        XCTAssertEqual(expectedColor, sut.backgroundColor)
    }
    
    @MainActor
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
    
    @MainActor
    func testCreateButtonEnabledWhenDataIsVaild() async {
        let board1 = Board(id: 1, name: "1")
        boardsRepository.boards = [board1]
        await sut.load()
        
        sut.taskName = "Name"
        sut.description = "Description"
        
        XCTAssertTrue(sut.createButtonEnabled)
    }
}

class BoardRepositoryMock: IBoardsRepository {
    var boards: [Board] = []
    
    func getAll() async -> [Board] {
        boards
    }
}

import SwiftUI

class TagColorProviderMock: ITagColorProvider {
    var providedColor: Color = .black
    
    func tagColorFor(index: Int) -> Color {
        providedColor
    }
}
