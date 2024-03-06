import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    @Published var phoneNumber = ""
    @Published var code = ""
    @Published var errorMessage = ""
    @Published var error = false
    
    @Published var CODE = ""
    @Published var gotoVerify = false
    
    func getCountryCode() -> String {
        let regionCode = Locale.current.region?.identifier ?? ""
        return countries[regionCode] ?? ""
    }
    
    func sendCode() {
        let number = "+\(getCountryCode())\(phoneNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            if let error = err {
                self.errorMessage = error.localizedDescription
                self.error.toggle()
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
}
