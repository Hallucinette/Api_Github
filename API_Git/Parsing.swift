//
//  Parsing.swift
//  API_Git
//
//  Created by Amelie Pocchiolo on 27/09/2022.


import SwiftUI
import Foundation

struct Api: Decodable {
    let name: String
    let login: String
    let avatar_url: String
    let followers: Int
    let following: Int
    let public_repos: Int
}

func getGit(username:String) async throws -> Api {
    //creat url
    guard let url = URL(string: "https://api.github.com/users/\(username)" )
            //modifier ici l'URL
    else {
        fatalError("Missing URL")
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    
    // fetch data from that url
    do {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            fatalError("Error while fetching data")
        }
        // Convert to JSon
        let decoded = try JSONDecoder().decode(Api.self, from: data)
        return decoded
    }
}
