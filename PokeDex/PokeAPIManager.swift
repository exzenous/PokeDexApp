//
//  PokeAPIManager.swift
//  PokeDex
//
//  Created by Nathachai Bangkung on 4/27/19.
//  Copyright © 2019 Nathachai Bangkung. All rights reserved.
//

import Foundation
import Alamofire

class PokeAPIManager {
    
    let host = "https://pokeapi.co/api/v2/"
    
    func getPokemonData (id: Int, completion: @escaping (PokemonModel) -> ()) {
        
        let path = "pokemon/\(id)/"
        let fullRequestPath = URL(string: host + path)!
        
        Alamofire.request(fullRequestPath).responseJSON { (response) in
            print(response)
            do {
                let data = try JSONDecoder().decode(PokemonModel.self, from: response.data!)
                completion(data)
            }
            catch {
                print("Error")
            }
            
        }
        
    }
}
