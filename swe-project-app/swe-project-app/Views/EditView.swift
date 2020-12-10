//
//  EditView.swift
//  swe-project-app
//
//  Created by Justin Schwartz on 12/9/20.
//

import SwiftUI
import Firebase

struct EditView: View {
    @EnvironmentObject var authService: AuthService

    @Environment(\.presentationMode) var presentationMode
    var ref: DatabaseReference! = Database.database().reference()
    
    
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
            .onAppear(perform: getBusiness)
        }
    }
    
    func getBusiness() {
        guard let sessionId = self.authService.session?.uid else { return }

        
        ref.child("businessData/\(sessionId)").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            for child in (snapshot.children) {
                
                let child = child as! DataSnapshot
                switch child.key {
                case "name": businessName = child.value as! String
                    
                case "email": businessEmail = child.value as! String
                    
                case "phone": phoneNum = child.value as! String
                    
                case "first": firstName = child.value as! String
                    
                case "last": lastName = child.value as! String
                    
                case "website": businessWebsite = child.value as! String
                    
                case "category":
                    let i = Constants.categories.firstIndex { $0 == child.value as! String }
                    selectedCategory = i ?? 0
                    
                case "address": streetAddress = child.value as! String
                    
                case "zip": zipcode = child.value as! String
                    
                case "state":
                    let i = Constants.states.firstIndex { $0 == child.value as! String }
                    selectedState = i ?? 0
                    
                case "city": city = child.value as! String

                case "race":
                    let i = Constants.races.firstIndex { $0 == child.value as! String }
                    selectedRace = i ?? 0
                    
                    
                    
                case "tags":
                    var i: Int = 0
                    for child in (child.children) {
                        let child = child as! DataSnapshot
                        if i == 0 { tag1 = child.value as! String }
                        if i == 1 { tag2 = child.value as! String }
                        if i == 2 { tag3 = child.value as! String }
                        i += 1
                    }
                    
                default: break
                }
                
            }
          
        })
    }
    
    func update() {
        guard let sessionId = self.authService.session?.uid else { return }

        
        self.ref.child("businessData/\(sessionId)").updateChildValues([
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
            "race": Constants.races[selectedRace]
        ])
        
        self.ref.child("businessData/\(sessionId)/tags").updateChildValues([
            "1": tag1,
            "2": tag2,
            "3": tag3
        ])
        
        self.presentationMode.wrappedValue.dismiss()
    }
}
