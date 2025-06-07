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
    var onError: ((Error) -> Void)?
    
    init() {
        self.getCharacters()
    }
    
    func search(query: String?) {
        var results = self.cachedCharacters
        if let query = query?.lowercased() {
            results = self.cachedCharacters.filter({$0.name.lowercased().contains(query)})
        }
        self.onUpdate?(results)
    }
    
    func getCharacters() {
        var request = URLRequest(url: URL(string: "https://yj8ke8qonl.execute-api.eu-west-1.amazonaws.com/characters")!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = ["Authorization": "Bearer 754t!si@glcE2qmOFEcN"]
        
        let task = URLSession(configuration: config)
            .dataTask(with: request, completionHandler: { [weak self] data, response, error in
                if let error = error {
                    self?.onError?(error)
                    return
                }
                guard let data = data else {
                    let error = NSError(domain: "CharacterManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    self?.onError?(error)
                    return
                }
                do {
                    try self?.handle(data: data)
                } catch {
                    DispatchQueue.main.async {
                        self?.onError?(error)
                    }
                }
            })
        task.resume()
    }
    
    func handle(data: Data) throws {
        let characters = try JSONDecoder().decode([Character].self, from: data)
        DispatchQueue.main.async {
            self.cachedCharacters = characters
            self.onUpdate?(characters)
        }
    }
    
}
