//
//  Created on 25.03.2023.
//

import Foundation

struct Task: Identifiable {
    let id: Int
    let name: String
    let board: Board
    let deadline: Date?
    let completed: Bool
    
    init(id: Int, name: String, board: Board, deadline: Date? = nil, completed: Bool = false) {
        self.id = id
        self.name = name
        self.board = board
        self.deadline = deadline
        self.completed = completed
    }
}
