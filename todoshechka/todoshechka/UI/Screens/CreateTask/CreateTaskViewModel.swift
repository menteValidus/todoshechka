//
//  Created on 26.03.2023.
//

import Foundation

extension CreateTask {
    final class ViewModel: ObservableObject {
        @Published private(set) var boardTags: [BoardTag.Model] = []
        @Published private(set) var selectedBoardId: Int?
        
        func load() {
            boardTags = [
                .init(id: 2, name: "Board 2", color: R.color.tags.accent2.color),
                .init(id: 1, name: "Board 1", color: R.color.tags.accent1.color),
                .init(id: 3, name: "Board 3", color: R.color.tags.accent3.color)
            ]
            
            selectedBoardId = 2
        }
    }
}
