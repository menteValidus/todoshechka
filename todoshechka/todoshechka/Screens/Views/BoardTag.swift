//
//  Created on 28.03.23.
//

import SwiftUI

struct BoardTag: View {
    let model: Model
    var selected: Bool = false
    var action: VoidCallback
    
    var body: some View {
        Button(action: action) {
            HStack {
                if selected {
                    Image(systemName: "checkmark")
                }
                Text(model.name)
                    .font(.body)
            }
                .padding(10)
                .overlay(
                    Capsule()
                        .stroke( R.color.tags.onAccent.color, lineWidth: 2)
                )
                .background(
                    model.color
                        .clipShape(Capsule())
                )
                .padding(2)
        }
        .foregroundColor(R.color.tags.onAccent.color)
    }
}

extension BoardTag {
    struct Model: Identifiable {
        let id: Int
        let name: String
        let color: Color
    }
}

struct BoardTag_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BoardTag(
                model: BoardTag.Model(
                    id: 1,
                    name: "Board 1",
                    color: .red
                ),
                action: {}
            )
            .previewDisplayName("Default")
            
            BoardTag(
                model: BoardTag.Model(
                    id: 1,
                    name: "Board 1",
                    color: .red
                ),
                selected: true,
                action: {}
            )
            .previewDisplayName("Selected")
        }
        .previewLayout(.sizeThatFits)
    }
}
