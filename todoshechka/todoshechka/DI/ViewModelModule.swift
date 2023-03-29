//
//  Created on 29.03.23.
//

extension Container {
    var createTaskViewModel: CreateTask.ViewModel {
        .init(
            boardsRepository: self.boardsRepository,
            tagColorProvider: self.tagColorProvider
        )
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
