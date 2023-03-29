//
//  Created on 28.03.23.
//

@testable import todoshechka
import XCTest

final class CreateTaskViewModelTests: XCTestCase {

    var sut: CreateTask.ViewModel!
    
    override func setUp() {
        sut = CreateTask.ViewModel(
            boardsRepository: Container.shared.boardRepository,
            tagColorProvider: Container.shared.tagColorProvider
        )
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testDataIsLoaded() {
        sut.load()
    }
}
