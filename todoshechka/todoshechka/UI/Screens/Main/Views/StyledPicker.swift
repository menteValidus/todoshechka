//
//  Created on 23.03.2023.
//

import SwiftUI

struct StyledPicker: View {
    let tasksNumber: Int
    let boardsNumber: Int
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("\(tasksNumber)")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .font(.body)
                        .background(R.color.secondary2.color)
                        .foregroundColor(R.color.onSecondary2.color)
                        .clipShape(Capsule())
                    Text(R.string.localizable.main_picker_section_tasks())
                        .font(.largeTitle.weight(.light))
                        .foregroundColor(R.color.onPrimaryVariant1.color)
                }
                
                Spacer()
                
                HStack {
                    Text("\(boardsNumber)")
                        .foregroundColor(R.color.onPrimaryVariant4.color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .font(.body)
                        .overlay(
                            Capsule().stroke( R.color.onPrimaryVariant4.color)
                        )
                    Text(R.string.localizable.main_picker_section_boards())
                        .foregroundColor(R.color.onPrimaryVariant4.color)
                        .font(.largeTitle.weight(.light))
                }
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    R.color.onPrimaryVariant4.color
                    R.color.onPrimaryVariant3.color
                        .frame(width: geo.size.width / 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
}

struct StyledPicker_Previews: PreviewProvider {
    static var previews: some View {
        StyledPicker(
            tasksNumber: 12,
            boardsNumber: 3
        )
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
