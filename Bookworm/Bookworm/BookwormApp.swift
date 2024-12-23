//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Book.self)
  }
}
