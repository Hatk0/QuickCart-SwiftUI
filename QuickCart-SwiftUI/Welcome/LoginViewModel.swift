import Foundation

class LoginViewModel: ObservableObject {
    @Published var phoneNumber = ""
    @Published var code = ""
    
    func getCountryCode() -> String {
        let regionCode = Locale.current.region?.identifier ?? ""
        return countries[regionCode] ?? ""
    }
}
