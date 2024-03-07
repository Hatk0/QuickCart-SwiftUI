import SwiftUI

struct AlertView: View {
    var message: String
    
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Message")
                .fontWeight(.bold)
                .foregroundStyle(.gray)
            
            Text(message)
                .foregroundStyle(.gray)
            
            Button {
                show.toggle()
            } label: {
                Text("Close")
                    .foregroundStyle(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color("buttonColor"))
            }
            .frame(alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 15)
    }
}
