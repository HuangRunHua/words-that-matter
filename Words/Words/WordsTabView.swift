//
//  WordsTabView.swift
//  Words
//
//  Created by Huang Runhua on 5/13/23.
//

import SwiftUI

struct WordsTabView: View {
    
    var words: [Word]
    
    @Environment(\.dismiss) var dismiss
    @State var tag: Int?
    
    var body: some View {
        NavigationView(content: {
            TabView(selection: $tag) {
                ForEach(words) { word in
                    WordView(word: word, total: words.count)
                        .tag(self.words.firstIndex(where: { $0.id == word.id}))
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .interactiveDismissDisabled()
    }
}

struct WordsTabView_Previews: PreviewProvider {
    static var previews: some View {
        WordsTabView(words: [
            Word(id: 1, word: "recapture", example: "Ukraine said it recaptured territory in Bakhmut, potentially signalling a change in momentum in the battle for the eastern town, which has grinded on for more than nine months. "),
            Word(id: 2, word: "grind", example: "Ukraine said it recaptured territory in Bakhmut, potentially signalling a change in momentum in the battle for the eastern town, which has grinded on for more than nine months.")
        ])
    }
}
