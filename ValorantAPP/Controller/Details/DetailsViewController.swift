//
//  DetailsViewController.swift
//  ValorantAPP
//
//  Created by Cenk Bahadır Çark on 12.09.2022.
//

import UIKit
import Kingfisher
import AVFoundation

final class DetailsViewController: UIViewController {
    
    //UI ELEMENTS
    @IBOutlet weak private var displayIcon: UIImageView!
    @IBOutlet weak private var characterName: UILabel!
    @IBOutlet weak private var developerName: UILabel!
    @IBOutlet weak private var backgroundImage: UIImageView!
    @IBOutlet weak private var fullPortraitImage: UIImageView!
    @IBOutlet weak private var roleName: UILabel!
    @IBOutlet weak private var roleIcon: UIImageView!
    @IBOutlet weak private var descriptionLbl: UILabel!
    @IBOutlet weak private var roleDescriptionLbl: UILabel!
    //COLLECTIONVIEW ELEMENTS
    @IBOutlet weak var collectionView: UICollectionView!
    //POP UP TRAINING
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    //POP UI OUTLETS
    @IBOutlet weak var popUpImage: UIImageView!
    @IBOutlet weak var popUpAbilityName: UILabel!
    @IBOutlet weak var popUpAbilityDesc: UILabel!
    //AUDIO PLAYER
    var player: AVAudioPlayer?
    
    var selectedCharacter : DataResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //POPUP VIEW SETTINGS
        blurView.bounds = self.view.bounds
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.3)
        //Display UI
        setAllData()
       
    }
    
    func setAllData(){
        if selectedCharacter != nil {
            displayIcon.kf.setImage(with: URL(string: (selectedCharacter?.displayIcon!)!))
            characterName.text = selectedCharacter?.displayName
            developerName.text = selectedCharacter?.developerName
            fullPortraitImage.kf.setImage(with: URL(string: (selectedCharacter?.fullPortrait!)!))
            descriptionLbl.text = selectedCharacter?.description
            roleName.text = selectedCharacter?.role?.displayName?.rawValue
            roleIcon.kf.setImage(with: URL(string: (selectedCharacter?.role?.displayIcon)!))
            roleDescriptionLbl.text = selectedCharacter?.role?.description
            //for abilities
            //
            if selectedCharacter?.background == nil {
                backgroundImage.backgroundColor = .white
            }else{
                backgroundImage.kf.setImage(with: URL(string: (selectedCharacter?.background!)!))
            }
        }
        
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        animateOut(view: popUpView)
        animateOut(view: blurView)
    }
    @IBAction func playAudio(_ sender: Any) {
        
        let url = Bundle.main.url(forResource: "sound", withExtension: "wav")
        do{
            try player = AVAudioPlayer(contentsOf: url!)
        }catch{
            print(error.localizedDescription)
        }
        player?.play()
         
    }
    
    func animateIn(view: UIView){
        let backgroundView = self.view
        
        backgroundView?.addSubview(view)
        //animation process
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.alpha = 0
        view.center = backgroundView!.center
        
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            view.alpha = 1
        })
    }
    //animate out
    func animateOut(view: UIView){
        
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            view.alpha = 0
        },completion: { _ in
            view.removeFromSuperview()
            
        })
    }
    
    
}
extension DetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AbilityCell", for: indexPath) as? DetailsCollectionViewCell{
            
            let ability = selectedCharacter?.abilities![indexPath.row]
            cell.configureCell(abilityResponse: cell)
            cell.setAbility(from: ability!)
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ability = selectedCharacter?.abilities![indexPath.row]
        animateIn(view: blurView)
        animateIn(view: popUpView)
        popUpAbilityName.text = ability?.displayName
        popUpAbilityDesc.text = ability?.description
        popUpImage.kf.setImage(with: URL(string: (ability?.displayIcon)!)!)
    }
}
