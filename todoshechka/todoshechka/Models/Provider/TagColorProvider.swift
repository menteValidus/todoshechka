//
//  Created on 29.03.23.
//

import SwiftUI

protocol ITagColorProvider: AnyObject {
    func tagColorFor(index: Int) -> Color
}

final class TagColorProvider: ITagColorProvider {
    private let colors = [
        R.color.tags.accent1.color,
        R.color.tags.accent2.color,
        R.color.tags.accent3.color,
    ]
    
    func tagColorFor(index: Int) -> Color {
        let tagIndex = index % colors.count
        
        return colors[tagIndex]
    }
}
