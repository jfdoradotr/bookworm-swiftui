//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss

  @State private var title = ""
  @State private var author = ""
  @State private var rating = 3
  @State private var genre = "Fantasy"
  @State private var review = ""

  private var isSaveDisabled: Bool {
    let title = title.trimmingCharacters(in: .whitespacesAndNewlines)
    let author = author.trimmingCharacters(in: .whitespacesAndNewlines)
    return title.isEmpty || author.isEmpty
  }

  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Name of book", text: $title)
          TextField("Author's name", text: $author)

          Picker("Genre", selection: $genre) {
            ForEach(genres, id: \.self) {
              Text($0)
            }
          }
        }

        Section("Write a review") {
          TextEditor(text: $review)
          RatingView(rating: $rating)
        }

        Section {
          Button("Save") {
            let newBook = Book(
              title: title,
              author: author,
              genre: genre,
              review: review,
              rating: rating
            )
            modelContext.insert(newBook)
            dismiss()
          }
        }
        .disabled(isSaveDisabled)
      }
      .navigationTitle("Add Book")
    }
  }
}

#Preview {
  AddBookView()
}
