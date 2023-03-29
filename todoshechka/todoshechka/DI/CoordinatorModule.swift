//
//  Created on 29.03.23.
//

extension Container {
    var createTaskCoordinatorObject: CreateTask.CoordinatorObject {
        .init(viewModel: createTaskViewModel)
    }
}
