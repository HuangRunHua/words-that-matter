//
//  ContentView.swift
//  Words
//
//  Created by Huang Runhua on 5/13/23.
//

import SwiftUI

struct ContentView: View {
    
    private let sourceURLString: String = "https://github.com/HuangRunHua/words-that-matter/raw/main/words.json"
    
    @EnvironmentObject var modelData: ModelData
    
    var words: [Word] {
        return modelData.database?.words.sorted(by: { $0.id > $1.id }) ?? []
    }
    
    @State private var showDetailWord: Bool = false
    @State var tag: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(words) { word in
                    Text(word.word)
                        .onTapGesture {
                            self.tag = self.words.firstIndex(where: { $0.id == word.id})
                            self.showDetailWord.toggle()
                        }
                }
            }
            .navigationTitle("Words")
        }
        .onAppear {
            DispatchQueue.main.async {
                self.modelData.fetchSource(urlString: sourceURLString)
            }
        }
        .fullScreenCover(isPresented: Binding(
            get: { showDetailWord },
            set: { showDetailWord = $0 })) {
                WordsTabView(words: words, tag: self.tag)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
