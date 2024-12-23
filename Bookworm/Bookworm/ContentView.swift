//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query var books: [Book]

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
