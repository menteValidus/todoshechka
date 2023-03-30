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
        sut.load()
        
        XCTAssertNil(sut.deadlineModel)
        XCTAssertTrue(sut.taskName.isEmpty, "\(sut.taskName) is not empty")
        XCTAssertTrue(sut.description.isEmpty, "\(sut.description) is not empty")
    }
    
    func testBoardTagsAreLoaded()  {
        let boardTagsExpectation = XCTestExpectation(description: "Failed to load board tags")
        let boardIdExpectation = XCTestExpectation(description: "Failed to set selected board id")
        let backgroundColorExpectation = XCTestExpectation(description: "Failed to set bg color")
        
        let boardTag = BoardTag.Model(id: 1, name: "Board 1", color: .red)
        let expectedBoardTags = [boardTag]
        
        boardsRepository.boards = [
            Board(id: boardTag.id, name: boardTag.name)
        ]
        tagColorProvider.providedColor = boardTag.color
        
        sut.load()
        
        let task1 = Task.detached {
            for await result in self.sut.$boardTags.values.dropFirst() {
                XCTAssertEqual(expectedBoardTags, result)
                boardTagsExpectation.fulfill()
                break
            }
        }
        
        let task2 = Task.detached {
            for await result in self.sut.$selectedBoardId.values.dropFirst() {
                XCTAssertEqual(boardTag.id, result)
                boardIdExpectation.fulfill()
                break
            }
        }
        
        let task3 = Task.detached {
            for await result in self.sut.$backgroundColor.values.dropFirst() {
                XCTAssertEqual(boardTag.color, result)
                backgroundColorExpectation.fulfill()
                break
            }
        }
        
        wait(for: [boardTagsExpectation, boardIdExpectation, backgroundColorExpectation], timeout: 0.1)
        task1.cancel()
        task2.cancel()
        task3.cancel()
    }
    
    func testBoardSelectedChangesSelectedId() {
        let expectation = XCTestExpectation()
        let board1 = Board(id: 1, name: "1")
        let board2 = Board(id: 2, name: "2")
        
        let expectedBoardTags = [
            BoardTag.Model(id: board1.id, name: board1.name, color: tagColorProvider.providedColor),
            BoardTag.Model(id: board2.id, name: board2.name, color: tagColorProvider.providedColor)
        ]
        
        boardsRepository.boards = [board1, board2]
        sut.load()
        
        sut.selectBoard(boardId: board2.id)
        
        XCTAssertEqual(board2.id, sut.selectedBoardId)
        let task = Task.detached {
            for await result in self.sut.$boardTags.values.dropFirst() {
                XCTAssertEqual(expectedBoardTags, result)
                expectation.fulfill()
                return
            }
        }
        
        wait(for: [expectation], timeout: 0.01)
        task.cancel()
    }
    
    func testBoardSelectedChangesBackground() {
        let expectation = XCTestExpectation()
        let board = Board(id: 1, name: "1")
        
        let expectedColor = Color.red
        
        boardsRepository.boards = [board]
        tagColorProvider.providedColor = expectedColor
        sut.load()
        
        sut.selectBoard(boardId: board.id)
        
        let task = Task.detached {
            for await result in self.sut.$backgroundColor.values.dropFirst() {
                XCTAssertEqual(expectedColor, result)
                expectation.fulfill()
                return
            }
        }

        wait(for: [expectation], timeout: 0.01)
        task.cancel()
    }
    
    func testDeadlineSelected() async {
        let expectation = XCTestExpectation()
        let date = Calendar.current.date(year: 2023, month: 3, day: 30, hour: 13, minute: 44)!
        let expectedResult = DeadlinePicker.Model(
            rawDate: date,
            formattedTime: "1:44 PM",
            formattedDate: "Mar 30, 2023"
        )
        
        sut.selectDate(date: date)
        
        let task = Task.detached {
            for await result in self.sut.$deadlineModel.values {
                XCTAssertEqual(expectedResult, result)
                expectation.fulfill()
                return
            }
        }
        
        wait(for: [expectation], timeout: 0.001)
        task.cancel()
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
