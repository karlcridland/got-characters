// Copyright © 2025 CreateFuture. All rights reserved.

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cultureLabel: UILabel!
    @IBOutlet var bornLabel: UILabel!
    @IBOutlet var diedLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!

    func setupWith(character: Character) {
        selectionStyle = .none
        nameLabel.text = character.name
        cultureLabel.text = character.culture
        bornLabel.text = character.born
        diedLabel.text = character.died
        seasonLabel.text = character.seasonString
    }
}


