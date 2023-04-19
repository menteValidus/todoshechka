//
//  Created on 29.03.23.
//

extension Container {
    var createTaskCoordinatorObject: CreateTask.CoordinatorObject {
        .init(viewModel: createTaskViewModel)
    }
    
    var taskDetailsCoordinatorObjectFactory: TaskDetails.CoordinatorObject.InjectedFactory {
        .init()
    }
    
    var mainScreenCoordinatorObject: MainScreen.CoordinatorObject {
        .init(viewModelFactory: mainScreenViewModelFactory)
    }
}


extension TaskDetails.CoordinatorObject {
    final class InjectedFactory {
        func create(taskId: Int) -> TaskDetails.CoordinatorObject {
            .init(viewModelFactory: Container.shared.taskDetailsViewModelFactory, taskId: taskId)
        }
    }
}
