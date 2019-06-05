//
//  PokemonListCollectionViewCell.swift
//  PokeDex
//
//  Created by Nathachai Bangkung on 4/27/19.
//  Copyright © 2019 Nathachai Bangkung. All rights reserved.
//

import UIKit
import Kingfisher

class PokemonListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    func loadData(imageUrl: String, name: String) {
        let sourceUrl = URL(string: imageUrl)!
        self.pokemonImage.kf.setImage(with: sourceUrl)
        self.pokemonName.text = name
    }
    
}
