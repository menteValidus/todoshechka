//
//  Created on 26.03.2023.
//

import SwiftUI

struct MainScreenCoordinatorView: View {
    @StateObject
    private var object = MainScreenCoordinatorObject()
    
    var body: some View {
        MainScreen(viewModel: object.mainScreenViewModel)
            .navigationDestination(
                object.createTaskViewModel,
                onDisappear: object.navigatedBackFromCreateTask
            ) {
                CreateTaskCoordinatorView()
            }
    }
}

private final class MainScreenCoordinatorObject: ObservableObject {
    @Published private(set) var mainScreenViewModel: MainScreenViewModel!
    @Published private(set) var createTaskViewModel: CreateTaskViewModel?
    
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
