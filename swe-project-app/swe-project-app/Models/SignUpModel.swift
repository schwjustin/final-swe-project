import Foundation

class SignUpModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    /*
    init(email: String, password: String, confirmPassword: String) {
        self.email = email
        self.password = confirmPassword
        self.confirmPassword = confirmPassword
    }
    */
    func isPasswordMatch () ->Bool{
         return password == confirmPassword
    }
    func validPassword() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func validEmail() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    /*
    var isEmailEmpty : Bool {
        if email.isEmpty {
            return true
        }
        return false;
    }
    
    var isPassEmpty : Bool {
        if password.isEmpty {
            return true;
        }
        return false;
    }
    
    var isConfirmedPassEmpty : Bool {
        if confirmPassword.isEmpty{
            return true;
        }
        return false;
    }
     */
    
    var isSignUpComplete : Bool {
        if !isPasswordMatch() || !validPassword() || !validEmail()
        {
            return false
        }
        return true
    }
    
    var passwordPrompt : String {
        if validPassword(){
            return ""
        }
        else{
            return "Password must contain at least one letter, at least one number, and be longer than six charaters"
        }
    }
    var passwordMatchPrompt : String {
        if isPasswordMatch(){
            return ""
        }
        else{
            return "Password do not match"
        }
    }
    var emailPrompt : String {
        if validEmail(){
            return ""
        }
        else{
            return "Email is not valid"
        }
    }
    
}
