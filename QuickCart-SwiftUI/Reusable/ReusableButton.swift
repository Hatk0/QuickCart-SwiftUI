import SwiftUI

struct ReusableButton: View {
    @State var title: String = "Title"
    var didTap: (() -> ())?
    
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
        }
        .frame(width: 190, height: 55)
        .background(Color("buttonColor"))
        .clipShape(RoundedRectangle(cornerRadius: 100))
    }
}

#Preview {
    ReusableButton()
}
