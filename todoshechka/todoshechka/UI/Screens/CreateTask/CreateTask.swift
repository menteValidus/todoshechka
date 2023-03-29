//
//  Created on 28.03.23.
//

import SwiftUI

struct CreateTask: View {
    private enum FocusedField {
        case title, description
    }
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: FocusedField?
    @State private var isEditingDate = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                topActionItems
                
                boards
                    .padding(.top)
                
                taskTitleField
                    .focused($focusedField, equals: .title)
                    .padding(.top)
                
                deadlineField
                
                descriptionField
                    .focused($focusedField, equals: .description)
                    .padding(.top)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
        }
        .onAppear {
            focusedField = .title
        }
        .preferredColorScheme(.light)
        .scrollDismissesKeyboard(.interactively)
        .background(
            R.color.tags.accent2.color
                .ignoresSafeArea()
        )
        .overlay(
            VStack {
                Spacer()
                
                CircleButton(
                    icon: Image(systemName: "checkmark"),
                    backgroundColor:  R.color.primary.color,
                    foregroundColor: R.color.onPrimaryVariant3.color,
                    action: {}
                )
                .frame(width: 80)
                .padding()
            }
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
                ForEach(viewModel.boardTags) { model in
                    BoardTag(
                        model: model,
                        selected: model.id == viewModel.selectedBoardId,
                        action: {
                            viewModel.selectBoard(boardId: model.id)
                        }
                    )
                }
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
    
    var taskTitleField: some View {
        TextField(
            R.string.localizable.create_task_title_placeholder(),
            text: $viewModel.taskName,
            axis: .vertical
        )
        .font(.system(size: 74))
    }
    
    var deadlineField: some View {
        VStack(alignment: .leading, spacing: 0) {
            let isNotEditing = viewModel.deadline == nil && !isEditingDate
            Button(action: {
                isEditingDate = true
            }) {
                Text(R.string.localizable.create_task_deadline())
                    .font(isNotEditing ? .largeTitle.bold() : .subheadline.bold())
                    .opacity(isNotEditing ? 0.8 : 0.5)
                    .padding(.bottom, 6)
            }
            .allowsHitTesting(isNotEditing)
            
            if viewModel.deadline == nil && isEditingDate {
                DatePicker(selection: .constant(Date()), label: {  })
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                
                HStack(spacing: 20) {
                    Spacer()
                    Button(action: { isEditingDate = false }) {
                        Image(systemName: "checkmark")
                    }
                    
                    Button(action: { isEditingDate = false }) {
                        Image(systemName: "xmark")
                    }
                }
                .opacity(0.6)
                .font(.largeTitle)
                .foregroundColor(R.color.tags.onAccent.color)
            }
            
            if viewModel.deadline != nil {
                Button(action: {}) {
                    VStack(alignment: .leading) {
                        Text("3:00 p.m")
                            .font(.largeTitle.bold())
                        Text("Mar 28, 2023")
                            .font(.subheadline.bold())
                    }
                }
            }
        }
        .foregroundColor(R.color.tags.onAccent.color)
    }
    
    var descriptionField: some View {
        TextField(R.string.localizable.create_task_description_placeholder(),
                  text: $viewModel.description,
                  axis: .vertical
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask(viewModel: Container.shared.createTaskViewModel)
    }
}
