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
                    Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: character.image)!)) ?? UIImage())
                        .resizable()
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
            Image(uiImage: {
              do {
                let data = try Data(contentsOf: URL(string: character.image)!)
                  return UIImage(data: data) ?? UIImage()
              } catch {
                // Handle error (e.g., print a message, display a placeholder image)
                return UIImage()
              }
            }())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        }
        .background {
            Image(uiImage: {
              do {
                let data = try Data(contentsOf: URL(string: character.image)!)
                  return UIImage(data: data) ?? UIImage()
              } catch {
                // Handle error (e.g., print a message, display a placeholder image)
                return UIImage()
              }
            }())
            .resizable()
            .scaledToFill()
            .blur(radius: 20)
        }
        .foregroundColor(Color.pink)
    }
}

#Preview {
    ContentView()
}
