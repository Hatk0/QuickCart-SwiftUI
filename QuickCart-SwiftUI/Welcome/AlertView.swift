import SwiftUI

struct AlertView: View {
    var message: String
    
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Message")
                .fontWeight(.bold)
                .foregroundStyle(.gray)
            
            Text(message)
                .foregroundStyle(.gray)
            
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Text("Close")
                    .foregroundStyle(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color("buttonColor"))
            }
            .frame(alignment: .center)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
