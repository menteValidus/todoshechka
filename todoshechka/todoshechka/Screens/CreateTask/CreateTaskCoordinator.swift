//
//  Created on 26.03.2023.
//

import SwiftUI

extension CreateTask {
    struct CoordinatorView: View {
        @StateObject
        private var object = CoordinatorObject()
        
        var body: some View {
            CreateTask(viewModel: object.viewModel)
        }
    }
}

fileprivate extension CreateTask {
    private final class CoordinatorObject: ObservableObject {
        @Published private(set) var viewModel: ViewModel
        
        init() {
            viewModel = .init()
        }
    }
}
