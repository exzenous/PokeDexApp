//
//  ViewController.swift
//  PokeDex
//
//  Created by Nathachai Bangkung on 4/27/19.
//  Copyright © 2019 Nathachai Bangkung. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let pokeApiManager = PokeAPIManager()
    
    var pokemonData: [PokemonModel] = []
    
    var randomSets: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "PokéDex"
        self.pokemonCollectView.dataSource = self
        self.pokemonCollectView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPokemonToCollect()
    }
    
    func randomNr() {
        while randomSets.count < 100 {
            let randomOne = Int.random(in: 1 ... 100)
            if randomSets.count == 0 {
                randomSets.append(randomOne)
            }
            else {
                if !randomSets.contains(randomOne) {
                    randomSets.append(randomOne)
                }
            }
        }
    }
    
    func getPokemonToCollect() {
        randomNr()
        for idNum in randomSets {
            self.pokeApiManager.getPokemonData(id: idNum) { pokemonModel in
                self.pokemonData.append(pokemonModel)
                let indexPath = IndexPath(row: self.pokemonData.count - 1, section: 0)
                self.pokemonCollectView.insertItems(at: [indexPath])
            }
        }
        
    }

    @IBAction func tappedRefreshList(_ sender: Any) {
        randomSets.removeAll()
        pokemonData.removeAll()
        pokemonCollectView.reloadData()
        getPokemonToCollect()
        self.refreshButton.isEnabled = false
        delay(interval: 3) {
            self.refreshButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            closure()
        }
    }
    
    @IBOutlet weak var pokemonCollectView: UICollectionView!
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = pokemonCollectView.dequeueReusableCell(withReuseIdentifier: "PokemonListCollectionViewCell", for: indexPath) as? PokemonListCollectionViewCell {
            let data = self.pokemonData[indexPath.row]
            cell.loadData(imageUrl: data.sprites!.front_default!, name: data.name!)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = (self.view.frame.width - 4 * 8)/3
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

