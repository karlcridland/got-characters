//
//  CharacterManager.swift
//  iOSTakeHomeChallenge
//
//  Created by Karl Cridland on 07/06/2025.
//

import Foundation

class CharacterManager {
    
    var cachedCharacters: [Character] = []
    var onUpdate: (([Character]) -> Void)?
    
    init() {
        self.getCharacters()
    }
    
    func getCharacters() {
        var request = URLRequest(url: URL(string: "https://yj8ke8qonl.execute-api.eu-west-1.amazonaws.com/characters")!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = ["Authorization": "Bearer 754t!si@glcE2qmOFEcN"]
        
        let task = URLSession(configuration: config)
            .dataTask(with: request, completionHandler: { data, response, error in
                if let error = error {
                    print("Error fetching characters: \(error)")
                }
                else {
                    do {
                        let characters = try JSONDecoder().decode([Character].self, from: data!)
                        DispatchQueue.main.async { [weak self] in
                            self?.cachedCharacters = characters
                            self?.onUpdate?(characters)
                        }
                    }
                    catch {
                        print("Error decoding characters: \(error)")
                    }
                }
            })
        task.resume()
        
    }
    
}

