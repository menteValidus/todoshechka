//
//  Created on 26.03.2023.
//

import SwiftUI

extension MainScreen {
    struct CoordinatorView: View {
        @StateObject
        private var object = Container.shared.mainScreenCoordinatorObject
        
        var body: some View {
            MainScreen(viewModel: object.viewModel)
                .fullScreenCover(
                    isPresented: $object.createTaskAppears,
                    content: {
                        CreateTask.CoordinatorView()
                    }
                )
                .fullScreenCover(
                    isPresented: $object.taskDetailsAppears,
                    content: {
                        TaskDetails()
                    }
                )
        }
    }
    
    final class CoordinatorObject: ObservableObject {
        @Published private(set) var viewModel: ViewModel!
        
        @Published var createTaskAppears = false
        @Published var taskDetailsAppears = false
        
        init(viewModelFactory: ViewModel.InjectedFactory) {
            viewModel = viewModelFactory.create(
                createTaskButtonTapped: navigateToCreateTask,
                taskTapped: navigateToTaskDetails
            )
        }
        
        private func navigateToCreateTask() {
            createTaskAppears = true
        }
        
        private func navigateToTaskDetails(taskId: Int) {
            taskDetailsAppears = true
        }
    }
}
