//
//  ListCardViewController.swift
//  PokemonCard
//
//  Created by GnolDrol on 12/17/20.
//

import UIKit
import Alamofire
import SDWebImage

class ListCardViewController: UIViewController {

    var pokemons : [PokemonObj] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        getPokemonCards()
        // Do any additional setup after loading the view.
    }
    
    
    func initializeUI() {
        tableView.register(UINib(nibName: ListCardCell.cellName(), bundle: Bundle.main), forCellReuseIdentifier: ListCardCell.cellName())
    }
    
    func getPokemonCards() {
        AF.request("https://api.pokemontcg.io/v1/cards").responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                self.parseResponse(data: response.data)
                break
            case let .failure(error):
                break
            default:
                break
            }
           
        })
    }
    
    private func parseResponse(data : Data?) {
        guard let data = data else {
            return
        }
        
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // try to read out a string array
                if let pokemonArr = json["cards"] as? [[String : Any]] {
                    for obj in pokemonArr {
                        var pokemonObj = PokemonObj()
                        pokemonObj.name = obj["name"] as? String
                        pokemonObj.imageUrl = obj["imageUrl"] as? String
                        pokemonObj.pokemonId = obj["id"] as? String
                        pokemons.append(pokemonObj)
                    }
                    tableView.reloadData()
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}

//
extension ListCardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCardCell.cellName(), for: indexPath) as! ListCardCell
        let pokemonObj = pokemons[indexPath.row]
        cell.nameLabel.text = pokemonObj.name
        cell.typeLabel.text = pokemonObj.pokemonId
        if let imageUrl = pokemonObj.imageUrl {
            cell.avatarImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListCardCell.cellHeight()
    }
}
