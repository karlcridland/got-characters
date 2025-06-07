//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Karl Cridland on 07/06/2025.
//

class CharactersViewModel {
    
    private let manager: CharacterManager
    private(set) var characters: [Character] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(manager: CharacterManager = CharacterManager()) {
        self.manager = manager
        
        self.manager.onUpdate = { [weak self] characters in
            self?.characters = characters
            self?.onUpdate?()
        }
        
        self.manager.onError = { error in
            print("Error updating characters: \(error.localizedDescription)")
            self.onError?(error)
        }
        
    }
    
    func search(query: String?) {
        manager.search(query: query)
    }
    
}
