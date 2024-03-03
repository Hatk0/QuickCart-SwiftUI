import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Image(colorScheme == .dark ? "darkgroceries" : "lightgroceries")
                .resizable()
            
            ZStack {
                Image(colorScheme == .dark ? "darkblur" : "lightblur")
                
                VStack(alignment: .center, spacing: 12) {
                    Spacer()
                    
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text("Welcome to\n Quick Cart")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Text("The best app for fast delivery \n of fresh groceries in the city")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(.lightGray))
                        .padding(.bottom, 30)
                    
                    ReusableButton(title: "Shop now") {
                        
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    WelcomeView()
}
