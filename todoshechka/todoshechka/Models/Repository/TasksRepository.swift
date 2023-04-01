//
//  Created on 01.04.23.
//

import Foundation
import Combine

enum TaskRepositoryEvent {
    case added(Todo.Task)
}

protocol ITasksRepository: AnyObject {
    var eventPublisher: AnyPublisher<TaskRepositoryEvent, Never> { get }
    
    func getAll() async -> [Todo.Task]
    func createTask(name: String, description: String, deadline: Date?, boardId: Int) async
}

final class TasksRepository: ITasksRepository {
    let eventPublisher: AnyPublisher<TaskRepositoryEvent, Never>
    private let _eventPublisher: PassthroughSubject<TaskRepositoryEvent, Never>
    
    private var tasks: [Todo.Task] = []
    private var id: Int = 0
    
    init() {
        _eventPublisher = .init()
        eventPublisher = _eventPublisher.eraseToAnyPublisher()
    }
    
    func getAll() async -> [Todo.Task] {
        tasks
    }
    
    func createTask(name: String, description: String, deadline: Date?, boardId: Int) async {
        id += 1
        
        let task = Todo.Task(id: id, name: name, description: description, board: .init(id: boardId, name: ""), deadline: deadline)
        _eventPublisher.send(.added(task))
    }
}
