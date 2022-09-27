//
//  ContentView.swift
//  API_Git
//
//  Created by Amelie Pocchiolo on 27/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var api_s = Api(name: "", login: "", avatar_url: "", followers: 0, following: 0, public_repos: 0)
    @State var username: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                
                TextField("username", text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    Task{
                        api_s = try await getGit(username: username)
                    }
                } label: {
                    Text("Recherche")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color .blue)
                }
                
                HStack{
                    AsyncImage(url: URL(string: api_s.avatar_url)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.white
                    }
                    .frame(width: 128, height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                    
                    VStack {
                        Text(api_s.login)
                            .padding()
                        Text(api_s.name)
                            .padding()
                    }
                }
                .padding()
                HStack{
                    Text("Followers : \(String(api_s.followers))")
                        .padding()
                    Text("following : \(String(api_s.following))")
                        .padding()
                }
                    Text("public repos : \(String(api_s.public_repos))")
                        .padding()
                }
            .navigationTitle("GitHub")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
