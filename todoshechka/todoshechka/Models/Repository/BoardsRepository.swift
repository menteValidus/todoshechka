//
//  Created on 29.03.23.
//

import Foundation

protocol IBoardsRepository: AnyObject {
    func getAll() async -> [Board]
}

final class BoardsRepository: IBoardsRepository {
    
    func getAll() async -> [Board] {
        [
            .init(id: 1, name: "Board 1"),
            .init(id: 2, name: "Board 2"),
            .init(id: 3, name: "Board 3")
        ]
    }
}
