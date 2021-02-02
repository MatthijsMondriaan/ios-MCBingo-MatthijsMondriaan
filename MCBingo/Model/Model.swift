//
//  Model.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 02/02/2021.
//

import UIKit

import Foundation

// MARK: - Welcome
struct Welcome {
    let player: Player
    let game: Game
    let roundType: String
    let card: Card
    let numbers: [Number]
}

// MARK: - Card
struct Card {
    let id, playerID, gameID: Int
    let createdAt, updatedAt: String
    let bingoCardNumbers: [Number]
}

// MARK: - Number
struct Number {
    let row, col, number: Int
}

// MARK: - Game
struct Game {
    let id: Int
    let gameID, createdAt, updatedAt: String
}

// MARK: - Player
struct Player {
    let name, pincode, uniqueID: String
}
