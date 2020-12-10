//
//  SignUpView.swift
//  swe-project-app
//
//  Created by Justin Schwartz on 12/7/20.
//
import SwiftUI

struct SignUpView: View {
    @ObservedObject var signUp = SignUpModel()
    @State private var formOffset: CGFloat = 0
    
    var body: some View {
        return VStack (spacing: 40) {
            Image("logo")
            Text("Sign Up").font(.title).bold()
            VStack{
                AuthTextField(value: $signUp.email, placeholder: "Email", icon: Image(systemName: "at"),
                              onEditingChanged: {flag in withAnimation{
                                self.formOffset = flag ? -150 : 0
                                }
                              })
                AuthTextField(value: $signUp.password, placeholder: "Password", icon: Image(systemName: "lock"), isSecure: true)
                AuthTextField(value: $signUp.confirmPassword, placeholder: "Confirm Password", icon: Image(systemName: "lock.rotation"), isSecure: true)
                // Creating button for signing up
                Button(action: {
                    
                }) {
                Text("Sign In").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                }.background(Color.yellow)
                .clipShape(Capsule())
                .padding(.top,5)
                .opacity(signUp.email.isEmpty || signUp.password.isEmpty ? 0.6 : 1 )
                .disabled(signUp.email.isEmpty || signUp.password.isEmpty)
                .animation(.easeInOut)
                }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
