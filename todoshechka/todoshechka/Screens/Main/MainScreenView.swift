//
//  Created on 22.03.2023.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        VStack {
            topView
            
            welcomeMessage
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("colors/primary")
        )
    }
}

extension MainScreen {
    var topView: some View {
        HStack {
            Color("colors/onPrimaryVariant2")
                .frame(width: 38, height: 38)
                .mask(Circle())
            Spacer()
            
        }
    }
    
    var welcomeMessage: some View {
        Text("Good Morning")
            .foregroundColor(Color("colors/onPrimaryVariant1"))
            .font(.system(size: 74))
            .lineSpacing(0)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
