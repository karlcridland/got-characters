// Copyright © 2025 CreateFuture. All rights reserved.

import Foundation

struct Character: Codable {
    
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let aliases: [String]
    let tvSeries: [String]
    let playedBy: [String]
    
    var seasonString: String {
        let series = self.tvSeries.map({$0.replacingOccurrences(of: "Season ", with: "").romanNumeral})
        return series.joined(separator: ", ")
    }
    
}

extension String {
    
    var romanNumeral: String {
        switch self {
            case "1": return "I"
            case "2": return "II"
            case "3": return "III"
            case "4": return "IV"
            case "5": return "V"
            case "6": return "VI"
            case "7": return "VII"
            case "8": return "VIII"
            case "9": return "IX"
            case "10": return "X"
            default: return "?"
        }
    }
    
}
