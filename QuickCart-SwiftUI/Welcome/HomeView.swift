import SwiftUI
import Firebase

struct HomeView: View {
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        ZStack {
            if status {
                VStack(spacing: 15) {
                    Text("Logged In Successfully")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Button {
                        try? Auth.auth().signOut()
                        withAnimation {
                            status = false
                        }
                    } label: {
                        Text("Log out")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 300, height: 55)
                    .background(Color("buttonColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    HomeView()
}
