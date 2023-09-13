//
//  String+Extensions.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/23/23.
//

import Foundation

extension String {

    var isEmptyWithTrim: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // To capiltalized first word of sentence
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    var capitalizeFirstLetter: String {
        return self.capitalizingFirstLetter()
    }
}
