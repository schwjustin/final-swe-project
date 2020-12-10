//
//  HomeView.swift
//  String
//
//  Created by Justin Schwartz on 10/30/20.
//

import SwiftUI
import Firebase



struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int
    
    var body: some View {
        let stars = HStack(spacing: 4) {
            ForEach(0..<maxRating) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(Color("star-yellow"))
                }
            }
            .mask(stars)
        )
        .foregroundColor(Color("gray30"))
    }
}

struct Result: Hashable {
    var uid: String
    var name: String
    var race: String
    var rating: Double
    var ratings: Int
    var tags: [String]
}

struct HomeView: View {
    @EnvironmentObject var authService: AuthService
    var ref: DatabaseReference! = Database.database().reference()
    
    @State private var query = ""
    @State var results = [Result]()
    @State private var selectedCategory = 0
    @State private var selectedRace = 0
    @State private var showCategory = true
    @State private var showRace = false
    @State private var active = false
    @State private var editToggle = false

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: self.authService.signOut) {
                        Text("Sign out")
                    }
                }
                if !editToggle { Section {
                    Button(action: {
                       
                        active = true
                        
                    }) {
                        Text("Edit Profile")
                    }
                }}
                Toggle(isOn: $showCategory) {
                    Text("Filter by Category")
                }
                Toggle(isOn: $showRace) {
                    Text("Filter by Race and/or Ethnicity")
                }
                
                if showCategory {Picker(selection: $selectedCategory, label: Text("Category")) {
                    ForEach(0..<Constants.categories.count, id:\.self) {
                        Text(Constants.categories[$0])
                    }}
                }
                
                if showRace {Picker(selection: $selectedRace, label: Text("Race and/or Ethnicity")) {
                    ForEach(0..<Constants.races.count, id:\.self) {
                        Text(Constants.races[$0])
                    }}
                }
                
                Section {
                    Button(action: {
                        if showCategory || showRace {
                            search()
                        } else {
                            // neither toggles
                            self.results.removeAll()
                            
                        }
                        
                    }) {
                        Text("Search")
                            .contentShape(Rectangle())
                    }
                }
                Section {
                    ForEach(0 ..< results.count, id: \.self) { i in
                        NavigationLink( destination: BusinessDetailView(
                            uid: results[i].uid
                        )
                        ) {
                            VStack(spacing: 0) {
                                HStack() {
                                    Text(results[i].name)
                                        .Body17Semibold()
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 4)
                                
                                HStack() {
                                    StarsView(
                                        rating: CGFloat(results[i].rating),
                                        maxRating: 5
                                    )
                                    .frame(height: 12)
                                    Spacer()
                                        .frame(width: 8)
                                    Text("\(results[i].ratings)")
                                        .Body15Regular()
                                        .foregroundColor(Color("gray60"))
                                    
                                    Spacer()
                                } .padding(.bottom, 12)
                                
                                tags(i)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .onAppear(perform: editCheck)
        .sheet(isPresented: $active) {
                EditView()
       
            
        }
        
        
        //.onAppear(perform: search)
    }
    
    func editCheck() {
        guard let sessionId = self.authService.session?.uid else { return }

        ref.child("businessData/\(sessionId)").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                editToggle = true
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        
    }
    func tags(_ i: Int) -> some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(results[i].tags, id: \.self) { tag in
                    
                    if tag != "" {
                        HStack(spacing: 0) {
                            Text(tag.capitalized)
                                .Caption13Regular()
                        }
                        .padding([.horizontal], 8)
                        .frame(height: 24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .strokeBorder(Color("gray40"), lineWidth: 1)
                        )}
                }
                
                Spacer()
            }
        }
    }
    
    func search() {
        self.results.removeAll()
        var raceToggle = false
        var param = "category"
        var query = Constants.categories[selectedCategory]
        if showRace && showCategory {
            raceToggle = true
        } else if showRace {
            query = Constants.races[selectedRace]
            param = "race"
        }
        
        ref.child("businessData").queryOrdered(byChild: param).queryEqual(toValue: query).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in (snapshot.children) {
                let child = child as! DataSnapshot
                
                var result = Result(
                    uid: "",
                    name: "",
                    race: "",
                    rating: 0.0,
                    ratings: 0,
                    tags: []
                )
                
                result.uid = child.key
                
                for child in (child.children) {
                    let child = child as! DataSnapshot
                    switch child.key {
                    case "name": result.name = child.value as! String
                        
                    case "rating":
                        result.rating = child.value as! Double
                        
                    case "race":
                        result.race = child.value as! String
                        
                    case "ratings":
                        result.ratings = child.value as! Int
                        
                        
                    case "tags":
                        for child in (child.children) {
                            let child = child as! DataSnapshot
                            result.tags.append(child.value as! String)
                        }
                        
                        
                    default: break
                    }
                }
                
                self.results.append(result)
                
            }
            if raceToggle {
                print(results[0].race)
                print(Constants.races[selectedRace])
                self.results = self.results.filter { $0.race == Constants.races[selectedRace]}
            }
            self.results.sort {
                $0.rating > $1.rating
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
