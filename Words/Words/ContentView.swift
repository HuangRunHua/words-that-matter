//
//  ContentView.swift
//  Words
//
//  Created by Huang Runhua on 5/13/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("sorted") var sorted: Bool = true
    
    private let sourceURLString: String = "https://github.com/HuangRunHua/words-that-matter/raw/main/words.json"
    
    @EnvironmentObject var modelData: ModelData
    
    var words: [Word] {
        return self.sorted ? modelData.database?.words.sorted(by: { $0.id > $1.id }) ?? [] : modelData.database?.words.sorted(by: { $0.id < $1.id }) ?? [] 
    }
    
    @State private var showDetailWord: Bool = false
    @State var tag: Int?
    
    var body: some View {
        NavigationView {
            if self.words.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                List {
                    ForEach(words) { word in
                        Button(action: {
                            self.tag = self.words.firstIndex(where: { $0.id == word.id})
                            self.showDetailWord.toggle()
                        }) {
                            Text(word.word)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .navigationTitle("Words")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.sorted.toggle()
                        } label: {
                            Image(systemName: "arrow.right.arrow.left")
                        }

                    }
                }
            }
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
