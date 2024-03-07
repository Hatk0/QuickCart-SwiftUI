import SwiftUI

struct CustomNumberPad: View {
    @Binding var value: String
    @Environment(\.colorScheme) var colorScheme
    
    var isVerify: Bool
    
    var rows = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "delete.left"]
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                Spacer()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 15) {
                    ForEach(rows, id: \.self) { value in
                        Button {
                            buttonAction(value: value)
                            print("Number")
                        } label: {
                            ZStack {
                                if value == "delete.left" {
                                    Image(systemName: value)
                                        .font(.title2)
                                        .foregroundColor(colorScheme == .dark ? .gray : .white)
                                } else {
                                    Text(value)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(colorScheme == .dark ? .gray : .white)
                                }
                            }
                            .frame(width: 80, height: 50)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        }
                        .disabled(value == "" ? true : false)
                    }
                }
            }
        }
        .padding()
    }
    
    // MARK: - Action
    
    func buttonAction(value: String) {
        if value == "delete.left" && self.value != "" {
            self.value.removeLast()
        }
        
        if value != "delete.left" {
            if isVerify {
                if self.value.count < 10 {
                    self.value.append(value)
                }
            } else {
                self.value.append(value)
            }
        }
    }
}
