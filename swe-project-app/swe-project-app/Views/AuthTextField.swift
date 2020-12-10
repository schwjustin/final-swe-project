import SwiftUI

struct AuthTextField: View {
           @Binding var value: String
           var placeholder = "Placeholder"
           var icon = Image(systemName: "person.crop.circle")
           var color = Color(.gray)
           var isSecure = false
           var onEditingChanged: ((Bool)->()) = {_ in }
    
           var body: some View {
               HStack {
                   if isSecure{
                       SecureField(placeholder, text: self.$value, onCommit: {
                           self.onEditingChanged(false)
                       }).padding()
                   } else {
                       TextField(placeholder, text: self.$value, onEditingChanged: { flag in
                           self.onEditingChanged(flag)
                       }).padding()
                   }
                   icon.imageScale(.medium)
                       .padding()
                       .foregroundColor(color)
               }.background(color.opacity(0.43)).clipShape(Capsule())
    }
}

struct AuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        AuthTextField(value: .constant(""))
    }
}
