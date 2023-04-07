//
//  Created on 28.03.23.
//

import SwiftUI

struct CreateTask: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingAlert = false
    
    var body: some View {
        TaskDetailsForm(
            toolbarItem: {
                cancelButton
            },
            backgroundColor: viewModel.backgroundColor,
            boardTags: viewModel.boardTags,
            selectedBoardId: viewModel.selectedBoardId,
            taskName: $viewModel.taskName,
            description: $viewModel.description,
            deadlineModel: viewModel.deadlineModel,
            fabEnabled: viewModel.createButtonEnabled,
            dateSelected: { date in
                viewModel.selectDate(date: date)
            },
            boardSelected: { boardId in
                viewModel.selectBoard(boardId: boardId)
            },
            fabTapped: {
                Task {
                    await viewModel.createTask()
                    self.dismiss()
                }
            }
        )
        .task {
            await viewModel.load()
        }
        .alert(
            "Are you sure to discard changes?",
            isPresented: $isShowingAlert,
            actions: {
                Button(
                    role: .destructive,
                    action: dismiss.callAsFunction,
                    label: { Text("Yes") }
                )
            }
        )
    }
}

private extension CreateTask {
    func cancelTapped() {
        if viewModel.containsData {
            isShowingAlert = true
        } else {
            dismiss()
        }
    }
}

private extension CreateTask {
    var cancelButton: some View {
        Button(action: cancelTapped) {
            Image(systemName: "xmark")
                .foregroundColor(R.color.onPrimaryVariant3.color)
        }
        .buttonStyle(CircleButtonStyle(backgroundColor: R.color.primary.color))
    }
    
    var createTaskButton: some View {
        Button(action: {
            Task {
                await viewModel.createTask()
                dismiss()
            }
        }) {
            Image(systemName: "checkmark")
                .foregroundColor(R.color.onPrimaryVariant3.color)
        }
        .disabled(!viewModel.createButtonEnabled)
        .buttonStyle(CircleButtonStyle(backgroundColor: R.color.primary.color))
    }
}

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask(viewModel: Container.shared.createTaskViewModel)
    }
}
