//
//  NetworkService.swift
//  ValorantAPP
//
//  Created by Cenk Bahadır Çark on 12.09.2022.
//

import Foundation

class NetworkService{
    
    static let shared = NetworkService()
    
    func fetchData(from url: String, completion: @escaping (CharacterResponse)-> ()){
        
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url){data, response, error in
                
                if let data = data {
                    do{
                        let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(response)
                        }
                    }catch{
                        print("catch error")
                    }
                }else{
                    print("no data")
                }
            }.resume()
        }else{
            print("invalid URL")
        }   
    }
}
