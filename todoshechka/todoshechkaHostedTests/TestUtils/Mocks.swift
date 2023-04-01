//
//  Created on 01.04.23.
//

@testable import todoshechka
import SwiftUI
import Combine

class BoardRepositoryMock: IBoardsRepository {
    var boards: [Board] = []
    
    func getAll() async -> [Board] {
        boards
    }
}

class TagColorProviderMock: ITagColorProvider {
    var providedColor: Color = .black
    
    func tagColorFor(index: Int) -> Color {
        providedColor
    }
}

class TasksRepositoryMock: ITasksRepository {
    typealias CreatedTaskInfo = (name: String, description: String, deadline: Date?, boardId: Int)
    var eventPublisher: AnyPublisher<TaskRepositoryEvent, Never> = PassthroughSubject().eraseToAnyPublisher()
    
    func getAll() async -> [Todo.Task] {
        []
    }
    
    var createdTaskInfo: CreatedTaskInfo?
    func createTask(name: String, description: String, deadline: Date?, boardId: Int) async {
        createdTaskInfo = (name: name, description: description, deadline: deadline, boardId: boardId)
    }
}
