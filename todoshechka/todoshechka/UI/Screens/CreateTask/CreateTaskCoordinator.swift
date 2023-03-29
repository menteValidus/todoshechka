//
//  Created on 26.03.2023.
//

import SwiftUI

extension CreateTask {
    struct CoordinatorView: View {
        @StateObject
        private var object = Container.shared.createTaskCoordinatorObject
        
        var body: some View {
            CreateTask(viewModel: object.viewModel)
        }
    }
}

extension CreateTask {
    final class CoordinatorObject: ObservableObject {
        @Published private(set) var viewModel: ViewModel
        
        init(viewModel: ViewModel) {
            self.viewModel = viewModel
        }
    }
}
