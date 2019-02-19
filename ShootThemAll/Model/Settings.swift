//
//  Settings.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 13/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit

struct GameView {
    static let FONT_NAME = "HelveticaNeue-Bold"
}

struct Keys {
    static let BEST = "BEST"
}

struct GameSettings {
    static let NUM = 7
    static let SPACE:CGFloat = 4
    static let SPEED: CGFloat = 1400
    static let ADD_BALL_RANDOM_PERC = 45
    static let BLOCK_RANDOM_PERC = 50
    static let PENALTY = 1
}

struct PhysicsCategory {
    static let NONE: UInt32 = 0
    static let BALL: UInt32 = 0x1
    static let BLOCK: UInt32 = 0x1 << 1
    static let ADD_BALL: UInt32 = 0x1 << 2
    static let WALL: UInt32 = 0x1 << 3
    static let FLOOR: UInt32 = 0x1 << 4
    static let TOP: UInt32 = 0x1 << 5
}

struct zPositions {
    static let BLOCK: CGFloat = 0
    static let ADD_BALL: CGFloat = 1
    static let BALL: CGFloat = 2
    static let FLOOR: CGFloat = 3
    static let TOP: CGFloat = 4
    static let BACK: CGFloat = 5
}
