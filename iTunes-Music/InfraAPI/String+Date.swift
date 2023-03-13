//
//  String+Date.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 2/4/23.
//

import Foundation

extension String {
    func toDefinedDateString() -> String? {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let oldDate = olDateFormatter.date(from: self) else {
            return nil
        }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "yyyy'/'MM'/'dd"
        return convertDateFormatter.string(from: oldDate)
    }
}
