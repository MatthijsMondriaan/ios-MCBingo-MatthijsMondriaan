//
//  Model.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 02/02/2021.
//

import Foundation

// MARK: - Welcome

struct Welcome: Codable {
    let player: Player
    let game: Game
    let roundType: String
    let card: Card
    let numbers: [Number]
}

// MARK: - Card

struct Card: Codable {
    let id, playerID, gameID: Int
    let createdAt, updatedAt: String
    let bingoCardNumbers: [Number]

    enum CodingKeys: String, CodingKey {
        case id
        case playerID = "player_id"
        case gameID = "game_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case bingoCardNumbers = "bingo_card_numbers"
    }
}

// MARK: - Number

struct Number: Codable {
    let row, col, number: Int
}

// MARK: - Game

struct Game: Codable {
    let id: Int
    let gameID, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case gameID = "game_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Player

struct Player: Codable {
    let name, pincode, uniqueID: String

    enum CodingKeys: String, CodingKey {
        case name, pincode
        case uniqueID = "unique_id"
    }
}
