//
//  Created on 28.03.23.
//

import SwiftUI

struct CreateTask: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isEditingDate = false
    @State private var isShowingAlert = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                topActionItems
                
                TaskDetailsForm(
                    boardTags: viewModel.boardTags,
                    selectedBoardId: viewModel.selectedBoardId,
                    taskName: $viewModel.taskName,
                    description: $viewModel.description,
                    deadlineModel: viewModel.deadlineModel,
                    dateSelected: { date in
                        viewModel.selectDate(date: date)
                    },
                    boardSelected: { boardId in
                        viewModel.selectBoard(boardId: boardId)
                    }
                )
            }
            .task {
                await viewModel.load()
            }
        }
        .preferredColorScheme(.light)
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
        .scrollDismissesKeyboard(.interactively)
        .background(
            viewModel.backgroundColor
                .ignoresSafeArea()
        )
        .overlay(
            VStack {
                Spacer()
                
                createTaskButton
                .frame(width: 80)
                .padding()
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
    
    func alertDismissed() {
        isShowingAlert = false
    }
}

private extension CreateTask {
    var topActionItems: some View {
        HStack {
            Spacer()
            Button(action: cancelTapped) {
                Image(systemName: "xmark")
                    .foregroundColor(R.color.onPrimaryVariant3.color)
            }
            .buttonStyle(CircleButtonStyle(backgroundColor: R.color.primary.color))
            .frame(width: 40)
        }
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
