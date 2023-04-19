//
//  Created on 19.04.23.
//

import SwiftUI

extension TaskDetails {
    struct CoordinatorView: View {
        @StateObject
        private var object: CoordinatorObject
        
        init(taskId: Int) {
            let object = Container.shared.taskDetailsCoordinatorObjectFactory.create(taskId: taskId)
            _object = .init(wrappedValue: object)
        }
        
        var body: some View {
            TaskDetails(viewModel: object.viewModel)
        }
    }
}

extension TaskDetails {
    final class CoordinatorObject: ObservableObject {
        @Published private(set) var viewModel: ViewModel
        
        init(viewModelFactory: ViewModel.InjectedFactory, taskId: Int) {
            self.viewModel = viewModelFactory.create(taskId: taskId)
        }
    }
}
