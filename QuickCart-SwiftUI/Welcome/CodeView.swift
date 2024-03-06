import SwiftUI

struct CodeView: View {
    var code: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(code)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .font(.title2)
                .frame(height: 45)
            
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
