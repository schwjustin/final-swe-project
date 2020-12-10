//
//  EditView.swift
//  swe-project-app
//
//  Created by Justin Schwartz on 12/9/20.
//

import SwiftUI
import Firebase

struct ConsumerEditView: View {
    @EnvironmentObject var authService: AuthService

    @Environment(\.presentationMode) var presentationMode
    var ref: DatabaseReference! = Database.database().reference()
    
    
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section() {
                    TextField("First Name", text:$firstName)
                    TextField("Last Name", text:$lastName)
                  
                }
                Section {
                    Button(action: {
                       // if businessName != "" && businessNameOwner != "" && businessEmail != "" && address != "" && phoneNum != "" && firstName != "" && lastName != "" && personalPhoneNum != "" {
                            update()
                       // } else {
                            // alert
                       // }
                    }
                    ){
                        Text("Confirm")
                    }
                }
            }
            .navigationBarTitle("Edit Profile")
            .onAppear(perform: getConsumer)
        }
    }
    
    func getConsumer() {
        guard let sessionId = self.authService.session?.uid else { return }

        
        ref.child("consumerData/\(sessionId)").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            for child in (snapshot.children) {
                
                let child = child as! DataSnapshot
                switch child.key {
               
                    
                case "first": firstName = child.value as! String
                    
                case "last": lastName = child.value as! String
                    
              
                    
                default: break
                }
                
            }
          
        })
    }
    
    func update() {
        guard let sessionId = self.authService.session?.uid else { return }

        
        self.ref.child("consumerData/\(sessionId)").updateChildValues([
         
            "first": firstName,
            "last": lastName,
        ])
     
        self.presentationMode.wrappedValue.dismiss()
    }
}
