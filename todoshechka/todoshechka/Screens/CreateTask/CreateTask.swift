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
                
                TextField(R.string.localizable.create_task_description_placeholder(),
                          text: .constant(""))
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                BoardTag(
                    name: "Board 2",
                    color: R.color.tags.accent2.color,
                    selected: true,
                    action: {}
                )
                
                BoardTag(
                    name: "Board 1",
                    color: R.color.tags.accent1.color,
                    action: {}
                )
                
                BoardTag(
                    name: "Board 3",
                    color: R.color.tags.accent3.color,
                    action: {}
                )
                
            }
        }
    }
    
    var taskTitleField: some View {
        TextField(
            R.string.localizable.create_task_title_placeholder(),
            text: .constant("")
        )
        .font(.system(size: 74))
    }
    
    var deadlineField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(R.string.localizable.create_task_deadline())
                .font(.subheadline.bold())
                .opacity(0.5)
                .padding(.bottom, 6)
            Button(action: {}) {
                VStack(alignment: .leading) {
                    Text("3:00 p.m")
                        .font(.largeTitle.bold())
                    Text("Mar 28, 2023")
                        .font(.subheadline.bold())
                }
            }
        }
        .foregroundColor(R.color.tags.onAccent.color)
    }
}

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask(viewModel: .init())
    }
}
