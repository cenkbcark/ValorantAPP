//  DetailsCollectionViewCell.swift
//  ValorantAPP
//
//  Created by Cenk Bahadır Çark on 12.09.2022.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var abilityImageView: UIImageView!
    
    func setAbility(from ability: Ability){
        
        abilityImageView.kf.setImage(with: URL(string: ability.displayIcon!))
    }
    func configureCell(abilityResponse: DetailsCollectionViewCell){
        abilityResponse.layer.cornerRadius = 20.0
        abilityResponse.layer.borderWidth = 2.0
        abilityResponse.layer.borderColor = UIColor.white.cgColor
    }
}
