# Bookworm

## Overview

Welcome to **Bookworm**, a SwiftUI app that allows users to store, manage, and review their favorite books. This project dives into the powerful new **SwiftData** framework, enabling seamless data management within your app. Along the way, we explore essential concepts such as `@Model`, `@Query`, and `@Binding`, and learn how to integrate property wrappers to share and persist data across views.

---

## Key Concepts and Explanations

### 1. **SwiftData and `@Model`**

SwiftData simplifies data persistence in SwiftUI apps. By marking a class with `@Model` and importing `SwiftData`, we create an observable object tied to SwiftData's persistence layer.

#### Example:

```swift
@Model
class Book {
  var title: String
  var author: String
  var genre: String
  var review: String
  var rating: Int
  var date: Date

  init(title: String, author: String, genre: String, review: String, rating: Int) {
    self.title = title
    self.author = author
    self.genre = genre
    self.review = review
    self.rating = rating
    self.date = Date.now
  }
}
```

> **Note**: The `@Model` attribute integrates directly with the data storage system, creating an underlying database file automatically.

---

### 2. **`@Environment(\.modelContext)`**

The `modelContext` is the environment object for interacting with the SwiftData store. It is set up automatically when `.modelContainer` is attached to your app's `WindowGroup`.

#### Example:

```swift
@Environment(\.modelContext) var modelContext

// Delete a book:
modelContext.delete(book)
```

---

### 3. **`.modelContainer`**

Adding `.modelContainer(for: Book.self)` to the `WindowGroup` connects the SwiftData storage layer to your app. This creates the underlying database and propagates the context throughout the app for easy access.

#### Example:

```swift
@main
struct BookwormApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Book.self)
  }
}
```

---

### 4. **Querying Data with `@Query`**

`@Query` fetches and observes SwiftData objects. It enables sorting and filtering, making it easier to display data dynamically.

#### Example:

```swift
@Query(
  sort: [
    SortDescriptor(\Book.title),
    SortDescriptor(\Book.author)
  ]
) var books: [Book]
```

> **Tip**: Combine `SortDescriptor` for multi-criteria sorting, as shown above.

---

### 5. **Data Sharing with `@Binding`**

`@Binding` facilitates data sharing between views, particularly useful in custom UI components where you need to pass state back and forth.

#### Example:

```swift
struct RatingView: View {
  @Binding var rating: Int

  var body: some View {
    HStack {
      ForEach(1...5, id: \.self) { star in
        Button {
          rating = star
        } label: {
          Image(systemName: star <= rating ? "star.fill" : "star")
        }
      }
    }
  }
}
```

---

### 6. **Enhanced Previews for SwiftData**

To preview SwiftData in Xcode, use the `ModelConfiguration` with `isStoredInMemoryOnly: true`. This ensures that no persistent database file is created during previews.

#### Example:

```swift
#Preview {
  do {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Book.self, configurations: config)
    let example = Book(
      title: "Test Book",
      author: "Test Author",
      genre: "Fantasy",
      review: "This was a great book!",
      rating: 4
    )

    return DetailView(book: example)
      .modelContainer(container)
  } catch {
    return Text("Preview error: \(error.localizedDescription)")
  }
}
```

---

## Features Implemented

- **Add Books**: Use `TextField` and `Picker` to capture user input for new books. Validation ensures no empty titles or authors.
- **List Books**: Dynamically display books in a sorted order using `@Query` and `SortDescriptor`.
- **Detail View**: Show detailed information, including ratings, reviews, and genres, with conditional styling (e.g., 1-star books appear red).
- **Delete Books**: Swipe to delete functionality, integrated with SwiftData for persistence.

---

## Challenges

1. **Validation**:
   Ensure no book is saved without a title, author, or genre. This can be implemented with form validation logic:

   ```swift
   private var isSaveDisabled: Bool {
     title.trimmingCharacters(in: .whitespaces).isEmpty || author.trimmingCharacters(in: .whitespaces).isEmpty
   }
   ```

2. **Highlighting 1-Star Books**:

   Add conditional formatting in `ContentView`:

   ```swift
   Text(book.title)
     .foregroundStyle(book.rating == 1 ? Color.red : Color.primary)
   ```

3. **Add Date Attribute**:

   Extend `Book` to include a `date` property, and display it formatted in `DetailView`:
   ```swift
   Text(book.date.formatted(date: .complete, time: .omitted))
   ```

---

## Accessibility Considerations

Custom components like `RatingView` need accessibility support. Add accessibility labels and hints for better usability:

```swift
Button {
  rating = number
} label: {
  Image(systemName: "star.fill")
    .accessibilityLabel("\(number) star rating")
    .accessibilityHint("Tap to set your rating to \(number)")
}
```

> **Future Note**: Accessibility is critical for inclusivity, and we'll revisit this topic in an upcoming dedicated project.

---

## Summary

With SwiftData and SwiftUI’s property wrappers, you’ve built a robust app that manages user data effectively. This project sets the stage for more advanced concepts in data handling and accessibility.
