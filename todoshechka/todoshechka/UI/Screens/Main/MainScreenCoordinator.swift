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
                isPresented: $object.createTaskAppears,
                content: {
                    CreateTask.CoordinatorView()
                }
            )
    }
}

private final class MainScreenCoordinatorObject: ObservableObject {
    @Published private(set) var mainScreenViewModel: MainScreenViewModel!
    
    @Published var createTaskAppears = false
    
    init() {
        mainScreenViewModel = .init(createTaskButtonTapped: navigateToCreateTask)
    }
    
    private func navigateToCreateTask() {
        createTaskAppears = true
    }
}
