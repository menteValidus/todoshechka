//
//  Created on 29.03.23.
//

extension Container {
    var boardsRepository: IBoardsRepository {
        BoardsRepository()
    }
    
    var tasksRepository: ITasksRepository {
        TasksRepository()
    }
}
