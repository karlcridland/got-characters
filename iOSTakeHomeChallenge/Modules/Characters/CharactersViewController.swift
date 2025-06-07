// Copyright © 2025 CreateFuture. All rights reserved.

import Foundation
import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: SearchBarView!
    @IBOutlet var tableView: UITableView!
    
    let manager: CharacterManager = CharacterManager()
    
    var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.searchBar.onValueChange = self.manager.search(query:)
        self.manager.onUpdate = { [weak self] characters in
            self?.loadData(characters: characters)
        }
    }

    func loadData(characters: [Character]) {
        self.characters = characters
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: self.characters[indexPath.row])
        return cell
    }
    
}
