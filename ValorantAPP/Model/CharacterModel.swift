//
//  CharacterModel.swift
//  ValorantAPP
//
//  Created by Cenk Bahadır Çark on 12.09.2022.
//

import Foundation

// MARK: - CharacterResponse
struct CharacterResponse: Codable {
    let status: Int?
    let data: [DataResponse]?
}

// MARK: - Datum
struct DataResponse: Codable {
    let uuid, displayName, description, developerName: String?
    let characterTags: [String]?
    let displayIcon, displayIconSmall: String?
    let bustPortrait: JSONNull?
    let fullPortrait: String?
    let fullPortraitV2: JSONNull?
    let killfeedPortrait: String?
    let background: String?
    let backgroundGradientColors: [String]?
    let assetPath: String?
    let isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent: Bool?
    let role: Role?
    let abilities: [Ability]?
    let voiceLine: VoiceLine?

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case description
        case developerName, characterTags, displayIcon, displayIconSmall, bustPortrait, fullPortrait, fullPortraitV2, killfeedPortrait, background, backgroundGradientColors, assetPath, isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent, role, abilities, voiceLine
    }
}

// MARK: - Ability
struct Ability: Codable {
    let slot: Slot?
    let displayName, description: String?
    let displayIcon: String?

    enum CodingKeys: String, CodingKey {
        case slot, displayName
        case description
        case displayIcon
    }
}

enum Slot: String, Codable {
    case ability1 = "Ability1"
    case ability2 = "Ability2"
    case grenade = "Grenade"
    case passive = "Passive"
    case ultimate = "Ultimate"
}

// MARK: - Role
struct Role: Codable {
    let uuid: String?
    let displayName: DisplayName?
    let description: String?
    let displayIcon: String?
    let assetPath: String?

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case description
        case displayIcon, assetPath
    }
}

enum DisplayName: String, Codable {
    case controller = "Controller"
    case duelist = "Duelist"
    case initiator = "Initiator"
    case sentinel = "Sentinel"
}

// MARK: - VoiceLine
struct VoiceLine: Codable {
    let minDuration, maxDuration: Double?
    let mediaList: [MediaList]?
}

// MARK: - MediaList
struct MediaList: Codable {
    let id: Int?
    let wwise: String?
    let wave: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

