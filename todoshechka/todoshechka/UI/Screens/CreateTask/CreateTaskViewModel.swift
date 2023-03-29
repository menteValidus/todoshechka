//
//  Created on 26.03.2023.
//

import Foundation

extension CreateTask {
    final class ViewModel: ObservableObject {
        @Published private(set) var boardTags: [BoardTag.Model] = []
        @Published private(set) var selectedBoardId: Int?
        
        @Published var taskName: String = ""
        @Published var description: String = ""
        
        private var boards: [Board] = []
        
        private let boardsRepository: IBoardsRepository
        private let tagColorProvider: ITagColorProvider
        
        init(
            boardsRepository: IBoardsRepository,
            tagColorProvider: ITagColorProvider
        ) {
            self.boardsRepository = boardsRepository
            self.tagColorProvider = tagColorProvider
        }
        
        func load() {
            loadBoards()
        }
        
        func selectBoard(boardId: Int) {
            guard boardId != selectedBoardId else { return }
            
            selectedBoardId = boardId
        }
        
        private func loadBoards() {
            Task.detached { [weak self] in
                guard let self = self else { return }
                
                self.configureBoards(await self.boardsRepository.getAll())
            }
        }
        
        private func configureBoards(_ boards: [Board]) {
            self.boards = boards
                .sorted(by: { lhs, rhs in lhs.id < rhs.id })
            
            Task { @MainActor in
                self.boardTags = self.boards.enumerated().map(self.indexedBoardToTag)
            }
        }
        
        private func indexedBoardToTag(_ indexedBoard: (Int, Board))  ->  BoardTag.Model {
            let color = tagColorProvider.tagColorFor(index: indexedBoard.0)
            let board = indexedBoard.1
            
            return .init(id: board.id, name: board.name, color: color)
        }
    }
}
