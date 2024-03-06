import SwiftUI

struct VerificationView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var present
    
    var body: some View {
        ZStack {
            Image(colorScheme == .dark ? "darkgroceries" : "lightgroceries")
                .resizable()
            
            VStack {
                VStack {
                    HStack {
                        Button {
                            present.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                            .frame(width: 75)
                        
                        Text("Verify Number")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding()
                    .frame(height: UIScreen.main.bounds.height / 5)
                    
                    Text("Code sent to +7 | \(viewModel.phoneNumber)")
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    
                    HStack(spacing: 15) {
                        ForEach(0..<6, id: \.self) { index in
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    }
                    .onChange(of: viewModel.code) { oldValue, newValue in
                        if newValue.count > 6 {
                            viewModel.code = String(newValue.prefix(6))
                        }
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 6) {
                        Text("Didn't receive code?")
                            .foregroundStyle(.gray)
                        
                        Button {
                            
                        } label: {
                            Text("Request Again")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Get via call")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 6)
                    
                    Button {
                        print("Tapped")
                    } label: {
                        Text("Verify and Create Account")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 300, height: 55)
                    .background(Color("buttonColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .padding(.top, 10)
                }
                
                ZStack {
                    Image(colorScheme == .dark ? "numpadDark" : "numpadLight")
                        .resizable()
                        .frame(height: 350)
                    
                    CustomNumberPad(value: $viewModel.code, isVerify: true)
                        .offset(y: -65)
                }
                .offset(y: 60)
            }
        }
        .ignoresSafeArea(.all)
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
    }
    
    func getCodeAtIndex(index: Int) -> String {
        if viewModel.code.count > index {
            let start = viewModel.code.startIndex
            let current = viewModel.code.index(start, offsetBy: index)
            
            return String(viewModel.code[current])
        }
        
        return ""
    }
}

#Preview {
    VerificationView(viewModel: LoginViewModel())
}
