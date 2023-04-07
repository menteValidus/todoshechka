//
//  Created on 04.04.23.
//

import SwiftUI

struct TaskDetails: View {
    private let animationDuration: CGFloat = 0.2
    
    @State var isEditing = false
    
    var body: some View {
        TaskDetailsForm(
            isEditing: isEditing,
            toolbarItem: {
                toolbarButton
            },
            backgroundColor: .accentColor,
            boardTags: [],
            selectedBoardId: 0,
            taskName: .constant("test"),
            description: .constant("test"),
            deadlineModel: nil,
            dateSelected: { _ in },
            boardSelected: { _ in },
            fabTapped: {}
        )
    }
}

private extension TaskDetails {
    var toolbarButton: some View {
        Button(action: isEditing ? cancelEditing : startEditing) {
            Image(systemName: isEditing ? "xmark" : "pencil")
                .foregroundColor(R.color.onPrimaryVariant3.color)
        }
        .buttonStyle(CircleButtonStyle(backgroundColor: R.color.primary.color))
        .animation(.easeInOut(duration: animationDuration), value: isEditing)
    }
}

private extension TaskDetails {
    func startEditing() {
        isEditing = true
    }
    
    func cancelEditing() {
        isEditing = false
    }
}

struct TaskDetails_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetails()
    }
}
