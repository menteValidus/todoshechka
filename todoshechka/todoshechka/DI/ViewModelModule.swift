//
//  Created on 29.03.23.
//

extension Container {
    var createTaskViewModel: CreateTask.ViewModel {
        .init(
            boardsRepository: self.boardsRepository,
            tasksRepository: self.tasksRepository,
            tagColorProvider: self.tagColorProvider
        )
    }
    
    var taskDetailsViewModelFactory: TaskDetails.ViewModel.InjectedFactory {
        .init()
    }
    
    var mainScreenViewModelFactory: MainScreen.ViewModel.InjectedFactory {
        .init()
    }
}

extension MainScreen.ViewModel {
    final class InjectedFactory {
        func create(
            createTaskButtonTapped: @escaping VoidCallback,
            taskTapped: @escaping (Int) -> Void
        ) -> MainScreen.ViewModel {
            .init(
                tasksRepository: Container.shared.tasksRepository,
                boardsRepository: Container.shared.boardsRepository,
                tagColorProvider: Container.shared.tagColorProvider,
                createTaskButtonTapped: createTaskButtonTapped,
                taskTapped: taskTapped
            )
        }
    }
}

extension TaskDetails.ViewModel {
    final class InjectedFactory {
        func create(taskId: Int) -> TaskDetails.ViewModel {
            .init(tasksRepository: Container.shared.tasksRepository, taskId: taskId)
        }
    }
}
