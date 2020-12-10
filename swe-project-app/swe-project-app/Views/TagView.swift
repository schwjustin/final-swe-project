//
//  BusinessAddress.swift
//  swe-project-app
//
//  Created by Hugh Do on 11/7/20.
//

import SwiftUI
import Firebase

struct TagView: View {
    @EnvironmentObject var authService: AuthService
    var ref: DatabaseReference! = Database.database().reference()
    
    
    @Binding var tag1: String
    @Binding var tag2: String
    @Binding var tag3: String

    var body: some View {
        Form {
           
                TextField("Tag 1", text: $tag1)
                TextField("Tag 2", text: $tag2)
                TextField("Tag 3", text: $tag3)
            
        }
        .navigationBarTitle("Tags")
    }
}
