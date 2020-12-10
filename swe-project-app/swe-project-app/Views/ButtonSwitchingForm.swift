//
//  ButtonSwitchingForm.swift
//  swe-project-app
//
//  Created by Hugh Do on 11/7/20.
//

import SwiftUI

struct ButtonSwitchingForm: View {
    
    @State private var userTap: Bool = false
    @State private var businessTap: Bool = false
        
    func isUserTap(){
        self.userTap = true
    }
    func isBusinessTap(){
        self.businessTap = true
    }
    
    var body: some View {
        NavigationView{
        VStack{
        Button(action: {
            print("Move to user registration form")
            self.isUserTap()
        }) {
            HStack{
            Image(systemName: "person.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("User Registration")
                .fontWeight(.semibold)
                .font(.title)
                .foregroundColor(.white)
            }
            
        }
        .buttonStyle(GradientBackgroundStyle())
        .padding(.vertical, 10)
            
           // Fill in the registrartion for user at the empty view
            NavigationLink(destination: EmptyView(), isActive: $userTap){
                EmptyView()
            }
            
            Button(action: {
                print("Move to Business registration form")
                self.isBusinessTap()
            }) {
                HStack{
                Image(systemName: "building.2.crop.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Business Registration")
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundColor(.white)
                }
                
            }
            .buttonStyle(GradientBackgroundStyle())
//            NavigationLink(destination: BusinessRegistrationView(), isActive: $businessTap){
//
//            }
            
    }
    
       
    }
        
  }

}

struct GradientBackgroundStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.black.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ButtonSwitchingForm_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSwitchingForm()
    }
}
