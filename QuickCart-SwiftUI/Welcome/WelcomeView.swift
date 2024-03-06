import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(colorScheme == .dark ? "darkgroceries" : "lightgroceries")
                    .resizable()
                
                ZStack {
                    Image(colorScheme == .dark ? "darkWelcomeBlur" : "lightWelcomeBlur")
                    
                    VStack(alignment: .center, spacing: 12) {
                        Spacer()
                        
                        Image("icon")
                            .resizable()
                            .frame(width: 60, height: 60)
                        
                        Text("Welcome to\n Quick Cart")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Text("The best app for fast delivery \n of fresh groceries in the city")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color(.lightGray))
                            .padding(.bottom, 30)
                        
                        NavigationLink {
                            LoginView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Button {
                                print("Tapped")
                            } label: {
                                Text("Shop Now")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 300, height: 55)
                            .background(Color("buttonColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 100))
                        }
                        
                        Spacer()
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    WelcomeView()
}
