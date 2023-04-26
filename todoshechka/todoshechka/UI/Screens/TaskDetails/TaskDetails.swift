//
//  Created on 04.04.23.
//

import SwiftUI

struct TaskDetails: View {
    @State var isEditing = false
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        TaskDetailsForm(
            isEditing: isEditing,
            toolbarItem: {
                toolbarButton
            },
            backgroundColor: .gray,
            boardTags: [],
            selectedBoardId: 0,
            taskName: $viewModel.taskName,
            description: $viewModel.taskDescription,
            deadlineModel: nil,
            dateSelected: { _ in },
            boardSelected: { _ in },
            fabTapped: { dismiss() }
        )
        .onAppear {
            viewModel.start()
        }
    }
}

private extension TaskDetails {
    var toolbarButton: some View {
        Button(action: isEditing ? cancelEditing : startEditing) {
            Image(systemName: isEditing ? "xmark" : "pencil")
                .foregroundColor(R.color.onPrimaryVariant3.color)
        }
        .buttonStyle(CircleButtonStyle(backgroundColor: R.color.primary.color))
        .defaultAnimation(value: isEditing)
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
        TaskDetails(viewModel: Container.shared.taskDetailsViewModelFactory.create(taskId: 0))
    }
}
