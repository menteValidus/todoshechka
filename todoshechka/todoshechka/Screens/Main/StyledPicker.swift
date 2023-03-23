//
//  Created on 23.03.2023.
//

import SwiftUI

struct StyledPicker: View {
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("12")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .font(.body)
                        .background(Color.white)
                        .clipShape(Capsule())
                    Text("Tasks")
                        .font(.largeTitle.weight(.light))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                HStack {
                    Text("3")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .font(.body)
                        .overlay(Capsule().stroke( Color.gray))
                    Text("Boards")
                        .foregroundColor(.gray)
                        .font(.largeTitle.weight(.light))
                }
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Color.gray
                    Color.white
                        .frame(width: geo.size.width / 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
}

struct StyledPicker_Previews: PreviewProvider {
    static var previews: some View {
        StyledPicker()
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
