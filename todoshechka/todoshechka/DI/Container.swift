//
//  Created on 29.03.23.
//

final class Container {
    static let shared = Container()
    
    // TODO: Lookup Factory library to register shared lazy dependencies
    lazy var boardsRepository: IBoardsRepository = {
        BoardsRepository()
    }()
    
    lazy var tasksRepository: ITasksRepository = {
        TasksRepository()
    }()
    
    private init() { }
}
