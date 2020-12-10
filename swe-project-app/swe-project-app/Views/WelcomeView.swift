//
//  WelcomeView.swift
//  String
//
//  Created by Justin Schwartz on 10/30/20.
//

import SwiftUI



struct WelcomeView: View {
    @EnvironmentObject var authService: AuthService
    @State private var fullName: String = ""
    @State private var user: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State var loading = false
    @State var error: String = ""
    @State private var active = false
    @State private var toggle = false
    @State private var showingAlert = false
    
    @State private var businessToggle = false
    
    var body: some View {
      
        
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: self.$email)
                }
                Section {
                    SecureField("Password", text: self.$password)
                }
                Group {
                    if !toggle {
                        Section {
                            Toggle(isOn: $businessToggle) {
                                Text("Business Profile")
                            }
                        }
                    }
                }
                Section {
                    Button(action: {
                        if self.$password.wrappedValue.count < 6 {
                            self.showingAlert = true
                        } else {
                            print(businessToggle)
                            if toggle {
                                self.logIn()
                            } else if businessToggle {
                                self.active.toggle()
                            } else {
                                signUp()
                            }
                            
                            
                        }
                        
                    }) {
                        Text(toggle ? "Log in" : "Create an Account")
                            .contentShape(Rectangle())
                    }
                }
                Section {
                    HStack(spacing: 0) {
                        Text(toggle ? "Don't have an account? " : "Already have an account? ")
                        Button(toggle ? "Sign up" : "Log in") {
                            self.toggle.toggle()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $active) {

                BusinessRegistrationView(
                    inputEmail: self.$email,
                    inputPassword: self.$password
                )
                .environmentObject(self.authService)
     
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(""), message: Text("Password must be at least 6 characters long."), dismissButton: .default(Text("OK")))
        }
    }
    
    /*
     VStack {
     Image("img").resizable().aspectRatio(contentMode: .fit).frame(height: 50, alignment: .center)
     
     Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
     
     VStack(alignment: .leading) {
     VStack(alignment: .leading) {
     Text("Username").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
     
     HStack {
     TextField("Enter Your Username", text: $email)
     
     if user != ""{
     
     Image("check").foregroundColor(Color.init(.label))
     }
     }
     
     Divider()
     }
     .padding(.bottom, 15)
     
     VStack(alignment: .leading){
     
     Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
     
     SecureField("Enter Your Password", text: $password)
     
     Divider()
     }
     
     HStack {
     Spacer()
     Button(action: {
     
     }) {
     
     Text("Forget Password ?")
     .foregroundColor(Color.blue.opacity(0.8))
     }
     }
     }.padding(.horizontal, 6)
     
     bottomView()
     }
     .padding()
     
     }
     
     func bottomView() -> some View {
     return VStack{
     
     Button(action: {
     
     }) {
     
     Text("Sign In").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
     
     
     }.background(Color.yellow)
     .clipShape(Capsule())
     .padding(.top,5)
     
     Text("(or)").foregroundColor(Color.gray.opacity(0.5)).padding(.top,5)
     
     HStack{
     
     Button(action: {
     
     }) {
     
     Image("google") .resizable()
     .aspectRatio(contentMode: .fit).frame(width: 40, height: 40, alignment: .center)
     
     
     }.background(Color.white)
     .clipShape(Circle())
     
     Spacer().frame(width:50)
     Button(action: {
     
     }) {
     
     Image("facebook") .resizable()
     .aspectRatio(contentMode: .fit).frame(width: 45, height: 45, alignment: .center)
     
     
     }.background(Color.white)
     .clipShape(Circle())
     
     
     }.padding(.top, 10)
     
     HStack(spacing: 8){
     
     Text("Don't Have An Account ?").foregroundColor(Color.gray.opacity(0.5))
     
     Button(action: {
     signUp()
     }) {
     
     Text("Sign Up")
     
     }.foregroundColor(.blue)
     
     }.padding(.top, 25)
     }
     }*/
    
    func signUp() {
        loading = true
        authService.signUp(email: self.email, password: self.password) { (result, error) in
            self.loading = false
            if let error = error {
                self.error = error.localizedDescription
            }
        }
    }
    
    func logIn() {
        loading = true
        authService.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AuthService())
    }
}
