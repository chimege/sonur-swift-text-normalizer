import Foundation
import SwiftyPyString

extension Array where Element: Any {
    mutating func sort(key: (Element) -> Int) {
        self = self.sorted(by: {
            key($0) < key($1)
        })
    }
}

