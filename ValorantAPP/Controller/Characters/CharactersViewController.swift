//
//  ViewController.swift
//  ValorantAPP
//
//  Created by Cenk Bahadır Çark on 12.09.2022.
//

import UIKit
import Kingfisher

final class CharactersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var characterList: [DataResponse]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getCharacterArray { characters in
            self.characterList = characters
            self.collectionView.reloadData()
            
        }
        
        
    }
    
    private func getCharacterArray(completion: @escaping (([DataResponse]) -> ())){
        
        let url = "https://valorant-api.com/v1/agents"
        
        NetworkService.shared.fetchData(from: url) { characterResponse in
            
            guard let characters = characterResponse.data else {return}
            
            completion(characters)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let character = sender as?  DataResponse
        let destionationVC = segue.destination as! DetailsViewController
        destionationVC.selectedCharacter = character
    }


}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return characterList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CharacterCell{
            
            cell.configureCell(dataResponse: cell)
            cell.setImage(from: self.characterList![indexPath.row])
            return cell
            
        }
    
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetails", sender: characterList![indexPath.row])
    }
}

