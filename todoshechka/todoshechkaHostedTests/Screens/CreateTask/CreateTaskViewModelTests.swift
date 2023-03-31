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
    
    func testDefaultDataIsLoaded() async {
        await sut.load()

        let deadlineModel = await sut.deadlineModel
        XCTAssertNil(deadlineModel)
        let taskName = await sut.taskName
        XCTAssertTrue(taskName.isEmpty, "\(taskName) is not empty")
        let description = await sut.description
        XCTAssertTrue(description.isEmpty, "\(description) is not empty")
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
    
    func testBoardSelectionChangesBackgroundColor() async {
        let board1 = Board(id: 1, name: "1")
        let board2 = Board(id: 2, name: "2")

        let expectedColor = tagColorProvider.providedColor

        boardsRepository.boards = [board1, board2]
        await sut.load()

        await sut.selectBoard(boardId: board2.id)

        let backgroundColor = await sut.backgroundColor
        XCTAssertEqual(expectedColor, backgroundColor)
    }
    func testDeadlineSelected() async {
        let date = Calendar.current.date(year: 2023, month: 3, day: 30, hour: 13, minute: 44)!
        let expectedResult = DeadlinePicker.Model(
            rawDate: date,
            formattedTime: "1:44 PM",
            formattedDate: "Mar 30, 2023"
        )

        await sut.selectDate(date: date)

        let deadlineModel = await sut.deadlineModel
        XCTAssertEqual(expectedResult, deadlineModel)
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
