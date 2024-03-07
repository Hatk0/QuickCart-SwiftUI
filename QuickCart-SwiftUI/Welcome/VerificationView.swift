import SwiftUI
import Firebase

struct VerificationView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var present
    @State private var isNavigating = false
    
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
                        
                        if viewModel.loadingView {
                            ProgressView()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(height: UIScreen.main.bounds.height / 5)
                    
                    Text("Code sent to + 7 | \(viewModel.phoneNumber)")
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
                            viewModel.requestCode()
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
                        viewModel.verifyCode()
                        isNavigating = viewModel.isLoggedIn
                    } label: {
                        Text("Verify and Create Account")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 300, height: 55)
                    .background(Color("buttonColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .padding(.top, 10)
                    .fullScreenCover(isPresented: $isNavigating) {
                        HomeView()
                    }
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
            
            if viewModel.error {
                AlertView(message: viewModel.errorMessage, show: $viewModel.error)
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
