//
//  WordView.swift
//  Words
//
//  Created by Huang Runhua on 5/13/23.
//

import SwiftUI

struct WordView: View {
    
    let word: Word
    let total: Int
    
    var body: some View {
        VStack {
            Text(word.word)
                .font(Font.custom("Georgia", size: 34))
                .fontWeight(.bold)
                .padding()
            
            Text("\(word.id)/\(total)")
                .font(Font.custom("Georgia", size: 22))
                .foregroundColor(.gray)
            
            ScrollView {
                Text(word.example)
                    .font(Font.custom("Georgia", size: 22))
                    .padding()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: Word(id: 1200,
                            word: "intelligence",
                            example: "But Yevgeny Prigozhin, the head of the Wagner Group, a Russian mercenary outfit, said Russian units were “running away”."), total: 12307)
    }
}
