//
//  MasterViewController.swift
//  PokeddexGo
//
//  Created by Karl on 2018/8/1.
//  Copyright © 2018年 whisperkarl.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PokeMonSelectionDelegate: class{
    func pokemonSelected (_ newPokeMon: Pokemon)
}

class MasterViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemons = LibraryAPI.sharedInstance.getPokemons()
    var filteredPokemons = [Pokemon]()
    
    fileprivate let idsposeBag = DisposeBag()  //用于适当时机削除观察者
    
    weak var delegate: PokeMonSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        filteredPokemons = pokemons
    }
    
    fileprivate func setupUI() {
        self.title = "精灵列表"
        definesPresentationContext = true
        searchBar
            .rx.text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [unowned self] query in
                    if query?.characters.count == 0 {
                        self.filteredPokemons = self.pokemons
                    } else {
                        self.filteredPokemons = self.pokemons.filter{ $0.name.hasPrefix(query!) }
                    }
                    self.tableView.reloadData()
            })
            .addDisposableTo(idsposeBag)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifiler = "pokemonCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: identifiler, for: indexPath) as! MasterTableViewCell
        let pokemon = filteredPokemons[indexPath.row]
        cell.awakeFromNib(pokemon.id, name: pokemon.name, pokeImageUrl: pokemon.pokeImgUrl)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = self.filteredPokemons[indexPath.row]
        delegate?.pokemonSelected(pokemon)
        if let detailViewController = self.delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
    }

}
