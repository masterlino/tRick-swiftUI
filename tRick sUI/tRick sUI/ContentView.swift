//
//  ContentView.swift
//  tRick sUI
//
//  Created by Lino Bustamante on 27/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var characters: [Character] = []
    @State private var error: Error?

    var body: some View {
        NavigationView {
            List(characters, id: \.id) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    RemoteImage(url: character.image)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle()) // Add this line to clip the image into a circle
                    Text(character.name)
                }
                
                .listRowBackground(
                    Capsule()
                        .fill(Color.teal)
                        .padding(2)
                )
            }
            .navigationTitle("Show Characters")
            .font(.custom( "AmericanTypewriter", fixedSize: 24))
            .foregroundColor(Color.yellow)
            .onAppear {
                fetchCharacters()
            }
            .alert(isPresented: Binding<Bool>(get: { self.error != nil }, set: { _ in self.error = nil })) {
                Alert(title: Text("Error"), message: Text(error!.localizedDescription), dismissButton: .default(Text("OK")))
            }
            .scrollContentBackground(.hidden)
        }
    }

    private func fetchCharacters() {
        let apiClient = APIClient(baseURL: URL(string: "https://rickandmortyapi.com/api/")!)

        apiClient.fetchCharacters { result in
            switch result {
            case .success(let characterResponse):
                self.characters = characterResponse.results  // Access results from CharacterResponse
            case .failure(let error):
                self.error = error
            }
        }
    }
}

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        VStack {
            Text(character.name)
                .font(.largeTitle)
            Text("Status: \(character.status)")
            Text("Species: \(character.species)")
            Text("Gender: \(character.gender)")
            // Use RemoteImage for the foreground image
                  RemoteImage(url: character.image)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle()) // Add this line to clip the image into a circle (optional)
            // Use RemoteImage for the background image
                  RemoteImage(url: character.image)
                    .scaledToFill()
                    .blur(radius: 20)
                    .ignoresSafeArea(.all) // Optional, to extend the background image
        }
    
        .foregroundColor(Color.pink)
    }
}

struct RemoteImage: View {
  let url: String

  var body: some View {
    AsyncImage(url: URL(string: url)) { phase in
      switch phase {
      case .empty:
        ProgressView()
      case .success(let image):
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      case .failure:
        Image(systemName: "xmark.circle") // Display a placeholder if failed
      }
    }
  }
}

#Preview {
    ContentView()
}
