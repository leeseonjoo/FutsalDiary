//
//  Item.swift
//  FutsalDiary
//
//  Created by 이선주 on 11/17/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
