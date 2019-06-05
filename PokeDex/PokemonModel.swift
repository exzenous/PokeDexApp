//
//  PokemonModel.swift
//  PokeDex
//
//  Created by Nathachai Bangkung on 4/27/19.
//  Copyright © 2019 Nathachai Bangkung. All rights reserved.
//

import Foundation

class PokemonModel: Codable {
    var name: String?
    var sprites: PokemonSpriteModel?
}

class PokemonSpriteModel: Codable {
    var front_default: String?
}
