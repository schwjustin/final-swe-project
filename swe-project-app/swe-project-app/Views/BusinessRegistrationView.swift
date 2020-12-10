//
//  BusinessRegistrationView.swift
//  swe-project-app
//
//  Created by Justin Schwartz on 11/1/20.
//

import SwiftUI
import Combine
import Firebase

struct BusinessRegistrationView: View {
    @EnvironmentObject var authService: AuthService
    @Environment(\.presentationMode) var presentationMode
    var ref: DatabaseReference! = Database.database().reference()
    
    @Binding var inputEmail: String
    @Binding var inputPassword: String
    @State var loading = false
    @State var error: String = ""
    
    @State private var businessName: String = ""
    @State private var businessNameOwner: String = ""
    @State private var businessEmail: String = ""
    @State private var address: String = ""
    @State private var phoneNum: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var description: String = ""
    @State private var selectedDate = Date()
    @State private var personalPhoneNum: String = ""
    @State private var businessWebsite: String = ""
    @State private var selectedCategory = 0
    @State private var tag1 = ""
    @State private var tag2 = ""
    @State private var tag3 = ""
    
    @State private var streetAddress: String = ""
    @State private var city: String = ""
    @State private var zipcode: String = ""
    @State private var selectedState: Int = 0
    @State private var selectedRace: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Business Information")) {
                    TextField("Business Name", text: $businessName)
                    TextField("Business Email", text: $businessEmail)
                    TextField("Business Website", text: $businessWebsite)

                    
                    NavigationLink(destination: BusinessAddress(
                        streetAddress: self.$streetAddress,
                        city: self.$city,
                        zipcode: self.$zipcode,
                        selectedState: self.$selectedState
                    )) {
                        Text("Address")
                    }
                    TextField("Business Phone number", text: $phoneNum)
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(0..<Constants.categories.count, id:\.self) {
                            Text(Constants.categories[$0])
                        }
                    }
                    .layoutPriority(1)


                    NavigationLink(destination: TagView(
                        tag1: self.$tag1,
                        tag2: self.$tag2,
                        tag3: self.$tag3
                    )) {
                        Text("Tags")
                    }
                    
                    //                    VStack(alignment: .leading) {
                    //                        TextField("Business description", text: $description)
                    //
                    //                    }
                }
                Section(header: Text("Owner Information")) {
                    TextField("First Name", text:$firstName)
                    TextField("Last Name", text:$lastName)
                   // DatePicker("Date of birth", selection: $selectedDate, displayedComponents: .date)
                    Picker(selection: $selectedRace, label: Text("Race and/or Ethnicity")) {
                        ForEach(0..<Constants.races.count, id:\.self) {
                            Text(Constants.races[$0])
                        }
                    }
                  //  TextField("Phone Number", text:$personalPhoneNum)
                }
                Section {
                    Button(action: {
                       // if businessName != "" && businessNameOwner != "" && businessEmail != "" && address != "" && phoneNum != "" && firstName != "" && lastName != "" && personalPhoneNum != "" {
                            signUp()
                       // } else {
                            // alert
                       // }
                    }
                    ){
                        Text("Continue")
                    }
                }
            }
            .navigationBarTitle("Business Registration")
            
        }
    }
    
    /*func limitText(_ upper: Int) {
     if description.count > upper {
     description = String(description.prefix(upper))
     }
     }*/
    
    
    func register() {
        guard let sessionId = self.authService.session?.uid else { return }
        
        self.ref.child("businessData/\(sessionId)").setValue([
            "name": businessName,
            "email": businessEmail,
            "website": businessWebsite,
            "address": streetAddress,
            "city": city,
            "state": Constants.states[selectedState],
            "zip": zipcode,
            "phone": phoneNum,
            "category": Constants.categories[selectedCategory],
            "first": firstName,
            "last": lastName,
           // "birthDate": dateToString(selectedDate),
            "race": Constants.races[selectedRace],
           // "ownerPhone": personalPhoneNum,
            "rating": 0.0,
            "ratings": 0
        ])
        
        self.ref.child("businessData/\(sessionId)/tags").setValue([
            "1": tag1,
            "2": tag2,
            "3": tag3
        ])
        
        
        
        /*
         self.ref.child("categories/\(Constants.categories[selectedCategory])/\(sessionId)").setValue([
         "rating": 0.0,
         "name": businessName,
         
         ])
         
         self.ref.child("races/\(Constants.races[selectedRace])/\(sessionId)").setValue([
         "rating": 0.0,
         "name": businessName,
         
         ])*/
    }
    
    func signUp() {
        loading = true
        authService.signUp(email: self.inputEmail, password: self.inputPassword) { (result, error) in
            self.loading = false
            self.register()
            if let error = error {
                self.error = error.localizedDescription
            }
        }
    }
}


func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "y-MM-dd"
    let string: String
    string = formatter.string(from: date)
    return string
}
