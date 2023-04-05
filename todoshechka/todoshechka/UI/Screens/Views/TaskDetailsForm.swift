//
//  Created on 05.04.23.
//

import SwiftUI

struct TaskDetailsForm: View {
    let boardTags: [BoardTag.Model]
    let selectedBoardId: Int
    @Binding var taskName: String
    @Binding var description: String
    let deadlineModel: DeadlinePicker.Model?
    
    let dateSelected: (Date) -> Void
    let boardSelected: (Int) -> Void
    
    @FocusState private var focusedField: TaskDetailsForm.FocusedField?
    
    var body: some View {
        VStack(alignment: .leading) {
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
        .onAppear {
            focusedField = .title
        }
    }
}

private extension TaskDetailsForm {
    enum FocusedField {
        case title, description
    }
}

private extension TaskDetailsForm {
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
}


struct TaskDetailsForm_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsForm(
            boardTags: [],
            selectedBoardId: 0,
            taskName: .constant(""),
            description: .constant(""),
            deadlineModel: nil,
            dateSelected: { _ in },
            boardSelected: { _ in }
        )
        .previewLayout(.sizeThatFits)
    }
}
