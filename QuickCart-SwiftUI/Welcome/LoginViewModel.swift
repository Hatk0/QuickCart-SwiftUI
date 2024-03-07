import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    // Phone number and code
    @Published var phoneNumber = ""
    @Published var code = ""
    
    // Error handling
    @Published var errorMessage = ""
    @Published var error = false
    
    // Store code for verification
    @Published var CODE = ""
    @Published var gotoVerify = false
    
    // User logged status
    @AppStorage("log_Status") var status = false
    
    // Load view
    @Published var loadingView = false
    
    // Logged In
    @Published var isLoggedIn = false
    
    func getCountryCode() -> String {
        let regionCode = Locale.current.region?.identifier ?? ""
        return countries[regionCode] ?? ""
    }
    
    func sendCode() {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phoneNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { CODE, err in
            if let error = err {
                self.errorMessage = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
    
    func verifyCode() {
        guard code.count == 6 else {
            errorMessage = "Please enter a valid 6-digit code."
            error = true
            return
        }
        
        let creditential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loadingView = true
        
        Auth.auth().signIn(with: creditential) { result, error in
            self.loadingView = false
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            // If logged successfully
            withAnimation {
                self.status = true
                self.isLoggedIn = true
            }
        }
    }
    
    func requestCode() {
        sendCode()
        
        withAnimation {
            self.errorMessage = "Code sent successfully"
            self.error.toggle()
        }
    }
}
