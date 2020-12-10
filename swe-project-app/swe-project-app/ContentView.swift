//
//  ContentView.swift
//  swe-project-app
//
//  Created by Justin Schwartz on 10/25/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var authService: AuthService

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loading = false
    @State var error: String = ""
    
    var body: some View {
        Group {
            if (self.authService.session != nil) {
       HomeView()
           //     Twitter()
      //          GMSView()
       //         BusinessDetailView()
            } else {
          WelcomeView()
                
//                SignUpView()
              //  Twitter()
            }
        }
        .onAppear(perform: getUser)
        .edgesIgnoringSafeArea(.all)
    }
    
    func getUser () {
        authService.listen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthService())
    }
}
