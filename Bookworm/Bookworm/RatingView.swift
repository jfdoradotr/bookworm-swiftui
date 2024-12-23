//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct RatingView: View {
  @Binding var rating: Int

  var label = ""
  var maximumRating = 5

  var offImage: Image?
  var onImage = Image(systemName: "star.fill")

  var offColor = Color.gray
  var onColor = Color.yellow

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

#Preview {
  RatingView(rating: .constant(4))
}
