//
//  Character.swift
//  tRick sUI
//
//  Created by Lino Bustamante on 27/4/24.
//


import Foundation

struct CharacterResponse: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let location: Location // Nested Location struct (optional)
    let origin: Location   // Nested Location struct (optional)
    let episode: [String]    // Array of URLs for character's episodes (optional)
    
    // Implement the 'Equatable' protocol for comparison
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}
