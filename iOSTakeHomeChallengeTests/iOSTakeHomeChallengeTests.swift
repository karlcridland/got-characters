//
//  iOSTakeHomeChallengeTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Karl Cridland on 07/06/2025.
//

import XCTest
@testable import iOSTakeHomeChallenge

final class iOSTakeHomeChallengeTests: XCTestCase {
    
    func testCharactersViewModelSearch() {
        let mockManager = CharacterManager()
        let mockCharacters = [
            Character(name: "Arya Stark", gender: "", culture: "", born: "", died: "", aliases: [], tvSeries: [], playedBy: []),
            Character(name: "Jon Snow", gender: "", culture: "", born: "", died: "", aliases: [], tvSeries: [], playedBy: [])
        ]
        mockManager.cachedCharacters = mockCharacters

        let viewModel = CharactersViewModel(manager: mockManager)
        let expectation = XCTestExpectation(description: "ViewModel updates characters after search")

        viewModel.onUpdate = {
            XCTAssertEqual(viewModel.characters.count, 1)
            XCTAssertEqual(viewModel.characters.first?.name, "Arya Stark")
            expectation.fulfill()
        }
        
        viewModel.search(query: "arya")
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCharactersViewModelReceivesError() {
        class MockCharacterManager: CharacterManager {
            override func getCharacters() {
                let data = """
                [{
                    "name":"Eddard Stark",
                    "gender": "Male",
                    "culture": "Northmen",
                    "born": "In 263 AC",
                    "died": "In 299 AC",
                    "aliases": [123],
                    "tvSeries": ["Season 1"],
                    "playedBy": ["Sean Bean"]
                }]
                """.data(using: .utf8)!

                DispatchQueue.global().async { [weak self] in
                    do {
                        try self?.handle(data: data)
                    } catch {
                        DispatchQueue.main.async {
                            self?.onError?(error)
                        }
                    }
                }
            }
        }

        let manager = MockCharacterManager()
        let viewModel = CharactersViewModel(manager: manager)
        
        let expectation = XCTestExpectation(description: "ViewModel handles error")
        
        viewModel.onError = { error in
            XCTAssertTrue(error.localizedDescription.contains("couldn’t be read") || error.localizedDescription.contains("type mismatch"))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
