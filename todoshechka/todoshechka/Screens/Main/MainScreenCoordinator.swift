//
//  Created on 26.03.2023.
//

import SwiftUI

struct MainScreenCoordinatorView: View {
    @StateObject
    private var object = MainScreenCoordinatorObject()
    
    var body: some View {
        MainScreen(viewModel: object.mainScreenViewModel)
    }
}

private final class MainScreenCoordinatorObject: ObservableObject {
    @Published private(set) var mainScreenViewModel: MainScreenViewModel
    
    init() {
        mainScreenViewModel = .init(createTaskButtonTapped: {}) // Pass action with self
    }
}
