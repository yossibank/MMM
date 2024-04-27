//
//  Item.swift
//  MMM
//
//  Created by Kamiyama Yoshihito on 2024/04/27.
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
