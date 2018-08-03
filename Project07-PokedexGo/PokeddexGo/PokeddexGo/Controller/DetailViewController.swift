//
//  DetailViewController.swift
//  PokeddexGo
//
//  Created by Karl on 2018/8/1.
//  Copyright © 2018年 whisperkarl.com. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameIDLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeInfoLabel: UILabel!
    
    var pokemon: Pokemon! {
        didSet (newPokemon) {
            refreshUI()
        }
    }
    
    func refreshUI() {
        nameIDLabel?.text = pokemon.name + (pokemon.id < 10 ? " #00\(pokemon.id)" : pokemon.id < 100 ? " #0\(pokemon.id)" : " #\(pokemon.id)")
        pokeImageView?.image = LibraryAPI.sharedInstance.downloadImg(pokemon.pokeImgUrl)
        pokeInfoLabel?.text = pokemon.detailInfo
        self.title = pokemon.name
    }
    
    override func viewDidLoad() {
         refreshUI()
        super.viewDidLoad()
    }
}
extension DetailViewController: PokeMonSelectionDelegate{
    func pokemonSelected(_ newPokeMon: Pokemon) {
        pokemon = newPokeMon
    }
}
