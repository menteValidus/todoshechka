//
//  Created on 26.03.2023.
//

import Foundation
import SwiftUI

extension CreateTask {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published private(set) var boardTags: [BoardTag.Model] = []
        @Published private(set) var selectedBoardId: Int = -1
        @Published private(set) var backgroundColor: Color = .clear
        
        @Published var taskName: String = ""
        @Published private(set) var deadlineModel: DeadlinePicker.Model?
        @Published var description: String = ""
        
        private var boards: [Board] = []
        
        private let boardsRepository: IBoardsRepository
        private let tagColorProvider: ITagColorProvider
        
        private lazy var deadlineDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            return dateFormatter
        }()
        
        private lazy var deadlineTimeFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            
            return dateFormatter
        }()
        
        nonisolated init(
            boardsRepository: IBoardsRepository,
            tagColorProvider: ITagColorProvider
        ) {
            self.boardsRepository = boardsRepository
            self.tagColorProvider = tagColorProvider
        }
        
        func load() async {
            await loadBoards()
        }
        
        func selectBoard(boardId: Int) {
            guard boardId != selectedBoardId else { return }
            
            selectedBoardId = boardId
            
            guard let selectedBoardTag = boardTags
                .first(where: { boardTag in boardTag.id == boardId }) else {
                return
            }
            backgroundColor = selectedBoardTag.color
        }
        
        func selectDate(date: Date) {
            guard date != deadlineModel?.rawDate else { return }
            
            deadlineModel = .init(
                rawDate: date,
                formattedTime: deadlineTimeFormatter.string(from: date),
                formattedDate: deadlineDateFormatter.string(from: date)
            )
        }
        
        private func loadBoards() async {
            let boards = await boardsRepository.getAll()
            self.configureBoards(await self.boardsRepository.getAll())
        }
        
        private func configureBoards(_ boards: [Board]) {
            self.boards = boards
                .sorted(by: { lhs, rhs in lhs.id < rhs.id })
            
            let boardTags = self.boards.enumerated().map(self.indexedBoardToTag)
//            Task { @MainActor in
                self.boardTags = boardTags
                
                guard let boardTag = boardTags.first else { return }
                
                self.selectedBoardId = boardTag.id
                self.backgroundColor = boardTag.color
//            }
        }
        
        private func indexedBoardToTag(_ indexedBoard: (Int, Board))  ->  BoardTag.Model {
            let color = tagColorProvider.tagColorFor(index: indexedBoard.0)
            let board = indexedBoard.1
            
            return .init(id: board.id, name: board.name, color: color)
        }
    }
}
