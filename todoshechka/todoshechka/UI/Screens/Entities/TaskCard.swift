//
//  Created on 25.03.2023.
//

import Foundation
import SwiftUI

struct TaskCard: Identifiable, Equatable {
    let id: Int
    let name: String
    let boardName: String
    let remainingTime: String?
    let completed: Bool
    let tagColor: Color
}
