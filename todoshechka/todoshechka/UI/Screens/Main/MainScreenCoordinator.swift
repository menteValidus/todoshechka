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
                    $object.taskDetailsId,
                    content: { id in
                        TaskDetails.CoordinatorView(taskId: id)
                    }
                )
        }
    }
    
    final class CoordinatorObject: ObservableObject {
        @Published private(set) var viewModel: ViewModel!
        
        @Published var createTaskAppears = false
        @Published var taskDetailsId: Int?
        
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
            taskDetailsId = taskId
        }
    }
}

extension View {
    func fullScreenCover<Value, Content: View>(_ value: Binding<Value?>, content: @escaping (Value) -> Content) -> some View {
        fullScreenCover(
            isPresented: .init(
                get: {
                    value.wrappedValue != nil
                },
                set: { appears in
                    if !appears {
                        value.wrappedValue = nil
                    }
                }
            ),
            content: {
                if let value = value.wrappedValue {
                    content(value)
                }
            }
        )
    }
}
