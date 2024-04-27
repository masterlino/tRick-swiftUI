//
//  Character.swift
//  tRick sUI
//
//  Created by Lino Bustamante on 27/4/24.
//


import Foundation

struct Character: Decodable, Identifiable {
  let id: Int
  let name: String
  let status: String
  let species: String
  let gender: String
  let image: String
  let location: Location // Nested Location struct (optional)
  let origin: Location   // Nested Location struct (optional)
  let episode: [URL]    // Array of URLs for character's episodes (optional)

  // Implement the 'Equatable' protocol for comparison
  static func == (lhs: Character, rhs: Character) -> Bool {
    return lhs.id == rhs.id
  }
}
