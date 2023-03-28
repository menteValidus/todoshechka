//
//  Created on 28.03.23.
//

import SwiftUI

struct BoardTag: View {
    var name: String
    var color: Color
    var selected: Bool = false
    var action: VoidCallback
    
    var body: some View {
        Button(action: action) {
            HStack {
                if selected {
                    Image(systemName: "checkmark")
                }
                Text(name)
                    .font(.body)
            }
                .padding(10)
                .overlay(
                    Capsule()
                        .stroke( R.color.tags.onAccent.color, lineWidth: 2)
                )
                .background(
                    color
                        .clipShape(Capsule())
                )
                .padding(2)
        }
        .foregroundColor(R.color.tags.onAccent.color)
    }
}

struct BoardTag_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BoardTag(
                name: "Board 1",
                color: .red,
                action: {}
            )
            .previewDisplayName("Default")
            
            BoardTag(
                name: "Board 1",
                color: .red,
                selected: true,
                action: {}
            )
            .previewDisplayName("Selected")
        }
        .previewLayout(.sizeThatFits)
    }
}
