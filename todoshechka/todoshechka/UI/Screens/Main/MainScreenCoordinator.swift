//
//  Created on 26.03.2023.
//

import SwiftUI

struct MainScreenCoordinatorView: View {
    @StateObject
    private var object = MainScreenCoordinatorObject()
    
    var body: some View {
        MainScreen(viewModel: object.mainScreenViewModel)
            .fullScreenCover(
                object.createTaskViewModel,
                onDismiss: object.navigatedBackFromCreateTask,
                content: {
                    CreateTask.CoordinatorView()
                }
            )
    }
}

private final class MainScreenCoordinatorObject: ObservableObject {
    @Published private(set) var mainScreenViewModel: MainScreenViewModel!
    @Published private(set) var createTaskViewModel: CreateTask.ViewModel?
    
    init() {
        mainScreenViewModel = .init(createTaskButtonTapped: navigateToCreateTask) // Pass action with self
    }
    
    func navigatedBackFromCreateTask() {
        createTaskViewModel = nil
    }
    
    private func navigateToCreateTask() {
        createTaskViewModel = .init()
    }
}
