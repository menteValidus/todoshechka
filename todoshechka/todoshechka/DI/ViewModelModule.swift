//
//  Created on 29.03.23.
//

extension Container {
    var createTaskViewModel: CreateTask.ViewModel {
        .init()
    }
    
    var mainScreenViewModelFactory: MainScreen.ViewModel.InjectedFactory {
        .init()
    }
}

extension MainScreen.ViewModel {
    final class InjectedFactory {
        func create(createTaskButtonTapped: @escaping VoidCallback) -> MainScreen.ViewModel {
            .init(createTaskButtonTapped: createTaskButtonTapped)
        }
    }
}
