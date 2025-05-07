//
//  String+Localize.swift
//  QuotesPractice
//
//  Created by Telman Yusifov on 02.05.25.
//

import Foundation

extension String {
    func localized() -> String {
        if let path = Bundle.main.path(forResource: LanguageManager.shared.get(), ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return self
    }
}
