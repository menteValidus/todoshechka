//
//  Created on 30.03.23.
//

import SwiftUI

struct DeadlinePicker: View {
    var model: Model?
    let onDateSelected: (Date?) -> Void
    
    @State private var isEditingDate = false
    @State private var date: Date
    
    init(
        model: Model?,
        onDateSelected: @escaping (Date?) -> Void
    ) {
        self.model = model
        self.onDateSelected = onDateSelected
        let date = model?.rawDate ?? Date()
        self._date = State(initialValue: date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let isNotEditing = model == nil && !isEditingDate
            Button(action: startEditingDate) {
                Text(R.string.localizable.create_task_deadline())
                    .font(isNotEditing ? .largeTitle.bold() : .subheadline.bold())
                    .opacity(isNotEditing ? 0.8 : 0.5)
                    .padding(.bottom, 6)
            }
            .allowsHitTesting(isNotEditing)
            
            if isEditingDate {
                DatePicker(selection: $date, label: {  })
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                
                HStack(spacing: 20) {
                    Spacer()
                    Button(action: saveDate) {
                        Image(systemName: "checkmark")
                    }
                    
                    Button(action: stopEditingDate) {
                        Image(systemName: "xmark")
                    }
                }
                .opacity(0.6)
                .font(.largeTitle)
                .foregroundColor(R.color.tags.onAccent.color)
            }
            
            if let model = model, !isEditingDate {
                Button(action: startEditingDate) {
                    VStack(alignment: .leading) {
                        Text(model.formattedTime)
                            .font(.largeTitle.bold())
                        Text(model.formattedDate)
                            .font(.subheadline.bold())
                    }
                }
            }
        }
        .foregroundColor(R.color.tags.onAccent.color)
    }
}

private extension DeadlinePicker {
    func startEditingDate() {
        isEditingDate = true
    }
    
    func saveDate() {
        stopEditingDate()
        onDateSelected(date)
    }
    
    func stopEditingDate() {
        isEditingDate = false
    }
}

extension DeadlinePicker {
    struct Model: Equatable {
        let rawDate: Date
        let formattedTime: String
        let formattedDate: String
    }
}

struct DeadlinePicker_Previews: PreviewProvider {
    static var previews: some View {
        DeadlinePicker(
            model: nil,
            onDateSelected: { _ in }
        )
        
        DeadlinePicker(
            model: .init(
                rawDate: .init(),
                formattedTime: "time",
                formattedDate: "date"
            ),
            onDateSelected: { _ in }
        )
    }
}
