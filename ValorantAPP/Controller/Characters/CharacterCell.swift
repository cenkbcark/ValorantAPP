//
//  CharacterCell.swift
//  ValorantAPP
//
//  Created by Cenk Bahadır Çark on 12.09.2022.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak private var characterImageView: UIImageView!
    
    func setImage(from dataResponse: DataResponse){
        
        characterImageView.kf.setImage(with: URL(string: dataResponse.displayIcon!))
    }
    
    func configureCell(dataResponse: CharacterCell){
        dataResponse.layer.cornerRadius = 20.0
        dataResponse.layer.borderWidth = 3.0
        dataResponse.layer.borderColor = UIColor.white.cgColor
    }
    
    
    
}
