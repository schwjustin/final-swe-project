//
//  ConsumerRegistraion.swift
//  swe-project-app
//
//  Created by Allison Denham on 11/9/20.
//

import SwiftUI
import Firebase

struct ConsumerRegistraion: View {
    
    // Create instance of Firebase DB
    @EnvironmentObject var authService: AuthService
    var ref: DatabaseReference! = Database.database().reference()
    
    @State private var consumerFirstName: String = ""
    @State private var consumerEmail: String = ""
    @State private var consumerPassword: String = ""
    @State private var consumerLastName: String = ""
    @State private var consumerBirthDate = Date();
    
    var body: some View {
       
        VStack
        {
            Text("Create Account").bold().font(.title)
            
            TextField("First Name", text: $consumerFirstName)
                .padding()
            
            TextField("Last Name", text: $consumerLastName)
                .padding()
            
            TextField("Email", text: $consumerEmail)
                .padding()
                       
            SecureField("Password", text: $consumerPassword)
                .padding()
            
            Button(action: register){
                
                Text("Create").foregroundColor(Color.white).bold()
                
                }
            .padding().background(Color.yellow).cornerRadius(5)
                        
        }
        
    }
    
    func register()
    {
        let consumerFirstN = consumerFirstName as NSString
        let consumerLastN = consumerLastName as NSString
        let consumerEm = consumerEmail as NSString
        let consumerPass = consumerPassword as NSString
        
        ref.child("consumerData").childByAutoId().setValue([
            "consumerFirstName" : consumerFirstN,
            "consumerLasName" : consumerLastN,
            "consumerEmail" : consumerEm,
            "consumerPassword" : consumerPass
            
        ])
    }
}

struct ConsumerRegistraion_Previews: PreviewProvider {
    static var previews: some View {
        ConsumerRegistraion()
    }
}
