//
//  Created on 29.03.23.
//

import Factory

extension Container {
    var boardRepository: IBoardsRepository {
        BoardsRepository()
    }
}
