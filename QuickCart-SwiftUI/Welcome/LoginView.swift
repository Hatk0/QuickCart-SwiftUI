import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack() {
                Image(colorScheme == .dark ? "darkgroceries" : "lightgroceries")
                    .resizable()
                
                // Enter mobile number
                ZStack {
                    Image(colorScheme == .dark ? "darkLoginBlur" : "lightLoginBlur")
                        .padding(.bottom, 400)
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image("icon")
                            .resizable()
                            .frame(width: 60, height: 60)
                        
                        Text("Enter your mobile \n number")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        
                        Text("We'll send you a verification code")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color(.lightGray))
                        
                        // Mobile number field
                        HStack {
                            Text("+ \(viewModel.getCountryCode()) | \(viewModel.phoneNumber.prefix(10))")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        .onChange(of: viewModel.phoneNumber) { oldValue, newValue in
                            if newValue.count > 10 {
                                viewModel.phoneNumber = String(newValue.prefix(10))
                            }
                        }

                        Spacer()
                            .frame(height: 400)
                    }
                }
                
                NavigationLink(destination: VerificationView(viewModel: viewModel), isActive: $viewModel.gotoVerify) {
                    Text("")
                        .hidden()
                }
                
                Button {
                    viewModel.sendCode()
                } label: {
                    Text("Continue")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(width: 300, height: 55)
                .background(Color("buttonColor"))
                .clipShape(RoundedRectangle(cornerRadius: 100))
                    .disabled(viewModel.phoneNumber == "" ? true : false)
                
                Text("By clicking on “Continue” you are \n agreeing to our terms of use")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color(.lightGray))
                    .multilineTextAlignment(.center)
                    .padding(.top, 120)
                
                ZStack {
                    Image(colorScheme == .dark ? "numpadDark" : "numpadLight")
                        .resizable()
                        .frame(height: 350)
                    
                    CustomNumberPad(value: $viewModel.phoneNumber, isVerify: false)
                        .offset(y: -320)
                }
                .offset(y: 280)
                
                if viewModel.error {
                    AlertView(message: viewModel.errorMessage, show: $viewModel.error)
                }

            }
            .ignoresSafeArea(.all)
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView()
}
