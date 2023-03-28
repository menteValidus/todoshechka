//
//  Created on 28.03.23.
//

import SwiftUI

struct CircleButton: View {
    var icon: Image
    var backgroundColor: Color
    var foregroundColor: Color
    var action: VoidCallback
    
    var body: some View {
        Button(action: action) {
            ZStack {
                backgroundColor
                    .clipShape(Circle())
                
                icon
                    .bold()
                    .foregroundColor(foregroundColor)
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(
            icon: Image(systemName: "checkmark"),
            backgroundColor: .accentColor,
            foregroundColor: .white,
            action: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
