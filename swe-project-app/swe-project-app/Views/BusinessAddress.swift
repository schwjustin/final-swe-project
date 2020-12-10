//
//  BusinessAddress.swift
//  swe-project-app
//
//  Created by Hugh Do on 11/7/20.
//

import SwiftUI
import Firebase

struct BusinessAddress: View {
    @EnvironmentObject var authService: AuthService
    var ref: DatabaseReference! = Database.database().reference()
    
    @Binding var streetAddress: String
    @Binding var city: String
    @Binding var zipcode: String
    @Binding var selectedState: Int

    var body: some View {
        Form {
            TextField("Street address", text:$streetAddress)
            
            TextField("City", text: $city)
               
            Picker(selection: $selectedState, label: Text("State")) {
                ForEach(0..<Constants.states.count, id:\.self){
                    Text(Constants.states[$0])
                }
            }

            TextField("Zipcode", text:$zipcode)
        }
        .navigationBarTitle("Business Address")
    }
}
