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
    
    func testDataIsLoaded() async {
        let boardTag = BoardTag.Model(id: 1, name: "Board 1", color: .red)
        let expectedBoardTags = [boardTag]
        
        boardsRepository.boards = [
            Board(id: boardTag.id, name: boardTag.name)
        ]
        tagColorProvider.providedColor = boardTag.color
        
        sut.load()
        
        for await result in self.sut.$boardTags.values.dropFirst() {
            XCTAssertEqual(expectedBoardTags, result)
            return
        }
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
