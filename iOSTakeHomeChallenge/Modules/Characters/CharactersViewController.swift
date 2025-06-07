// Copyright © 2025 CreateFuture. All rights reserved.

import Foundation
import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: SearchBarView!
    @IBOutlet var tableView: UITableView!
    
    private let viewModel = CharactersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        self.tableView.dataSource = self
        
        self.viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        self.searchBar.onValueChange = self.viewModel.search(query:)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: self.viewModel.characters[indexPath.row])
        return cell
    }
    
}
