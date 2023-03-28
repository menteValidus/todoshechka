//
//  Created on 28.03.23.
//

import SwiftUI

struct CreateTask: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                topActionItems
                boards
                    .padding(.top)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
        }
        .preferredColorScheme(.light)
        .background(
            R.color.tags.accent2.color
        )
    }
}

private extension CreateTask {
    func cancelTapped() {
        dismiss() // TODO: Change to show alert
    }
}

private extension CreateTask {
    var topActionItems: some View {
        HStack {
            Spacer()
            CircleButton(
                icon: Image(systemName: "xmark"),
                backgroundColor: R.color.primary.color,
                foregroundColor: R.color.onPrimaryVariant3.color,
                action: cancelTapped
            )
            .frame(width: 44)
        }
    }
    
    var boards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                boardItem(
                    name: "Board 2",
                    color: R.color.tags.accent2.color,
                    selected: true,
                    action: {}
                )
                
                boardItem(
                    name: "Board 1",
                    color: R.color.tags.accent1.color,
                    action: {}
                )
                
                boardItem(
                    name: "Board 3",
                    color: R.color.tags.accent3.color,
                    action: {}
                )
                
            }
        }
    }
    
    func boardItem(
        name: String,
        color: Color,
        selected: Bool = false,
        action: @escaping VoidCallback
    ) -> some View {
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

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask()
    }
}
