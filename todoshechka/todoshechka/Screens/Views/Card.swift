//
//  Created on 24.03.2023.
//

import SwiftUI

struct Card: View {
    var taskName: String
    var boardName: String
    var timeLeftText: String?
    var completed: Bool
    
    var backgroundColor = R.color.tags.accent1.color
    
    var onComplete: VoidCallback
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                R.color.onPrimaryVariant2.color
                    .frame(width: 38, height: 38)
                    .mask(Circle())
                
                Spacer()
                
                if let timeLeftText = timeLeftText {
                    Text(timeLeftText)
                        .font(.caption2)
                        .bold()
                        .foregroundColor(R.color.tags.onAccent.color)
                }
                
                completeButton(completed: completed, action: onComplete)
            }
            
            VStack(alignment: .leading) {
                Text(boardName)
                    .font(.caption2)
                Text(taskName)
                    .font(.largeTitle)
            }
            .lineLimit(1)
            .padding(.top, 4)
            .padding(.bottom)
        }
        .padding(10)
        .background(
            backgroundColor
                .cornerRadius(38)
        )
    }
}

extension Card {
    func completeButton(completed: Bool, action: @escaping VoidCallback) -> some View {
        Button(action: action) {
            ZStack {
                R.color.onPrimaryVariant2.color.opacity(0.2)
                    .frame(width: 38, height: 38)
                    .mask(Circle())
                
                Image(systemName: "checkmark")
                    .foregroundColor(R.color.tags.onAccent.color)
                    .bold()
            }
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(
            taskName: "Task name",
            boardName: "Board name",
            timeLeftText: "1h 30m",
            completed: false,
            onComplete: {}
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Default")
    }
}
