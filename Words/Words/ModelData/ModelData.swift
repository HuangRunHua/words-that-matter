//
//  ModelData.swift
//  Words
//
//  Created by Huang Runhua on 5/13/23.
//

import Foundation
import Combine
import SwiftUI

final class ModelData: ObservableObject {
    @Published var database: Database?
    
    func fetchSource(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    do {
                        self.database = try decoder.decode(Database.self, from: data)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
}
