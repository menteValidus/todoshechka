//
//  Created on 05.04.23.
//

import SwiftUI

struct TaskDetailsForm<Content: View>: View {
    @ViewBuilder
    let toolbarItem: () -> Content
    let backgroundColor: Color
    let boardTags: [BoardTag.Model]
    let selectedBoardId: Int
    @Binding var taskName: String
    @Binding var description: String
    let deadlineModel: DeadlinePicker.Model?
    var fabEnabled: Bool = true
    
    let dateSelected: (Date) -> Void
    let boardSelected: (Int) -> Void
    let fabTapped: VoidCallback
    
    @FocusState private var focusedField: TaskDetailsForm.FocusedField?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                topActionItems
                    .padding(.horizontal, 24)
                boards
                    .padding(.top)
                
                taskTitleField
                    .focused($focusedField, equals: .title)
                    .padding(.top)
                
                DeadlinePicker(
                    model: deadlineModel,
                    onDateSelected: dateSelected
                )
                
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
            backgroundColor
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

private extension TaskDetailsForm {
    enum FocusedField {
        case title, description
    }
}

private extension TaskDetailsForm {
    var topActionItems: some View {
        HStack {
            Spacer()
            toolbarItem()
                .frame(width: 40)
        }
    }
    
    var boards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(boardTags) { model in
                    BoardTag(
                        model: model,
                        selected: model.id == selectedBoardId,
                        action: {
                            boardSelected(model.id)
                        }
                    )
                }
            }
        }
    }
    
    var taskTitleField: some View {
        TextField(
            R.string.localizable.create_task_title_placeholder(),
            text: $taskName,
            axis: .vertical
        )
        .font(.system(size: 74))
    }
    
    var descriptionField: some View {
        TextField(R.string.localizable.create_task_description_placeholder(),
                  text: $description,
                  axis: .vertical
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var createTaskButton: some View {
        Button(action: fabTapped) {
            Image(systemName: "checkmark")
                .foregroundColor(R.color.onPrimaryVariant3.color)
        }
        .disabled(!fabEnabled)
        .buttonStyle(CircleButtonStyle(backgroundColor: R.color.primary.color))
    }
}

struct TaskDetailsForm_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsForm(
            toolbarItem: {
                Image(systemName: "xmark")
                    .foregroundColor(R.color.onPrimaryVariant3.color)
            },
            backgroundColor: .gray,
            boardTags: [],
            selectedBoardId: 0,
            taskName: .constant(""),
            description: .constant(""),
            deadlineModel: nil,
            dateSelected: { _ in },
            boardSelected: { _ in },
            fabTapped: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
