//
//  RickyMortyService.swift
//  Rick and Morty
//
//  Created by Mehmet Talha Irmak on 28.07.2023.
//

import Foundation
import Alamofire

enum RickyMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\( BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol RickyMortyServiceInterface {
    func fetchAllDatas(responseCallback: @escaping (RickyMortyModel?) -> Void)
}

struct RickyMortyService: RickyMortyServiceInterface {
    func fetchAllDatas(responseCallback: @escaping (RickyMortyModel?) -> Void) {
        AF.request(RickyMortyServiceEndPoint.characterPath(), method: .get).responseDecodable(of: RickyMortyModel.self) { (response) in
            guard let data = response.value else {
                //error
                print(response)
                fatalError("Couldn't fetch characters data from API")
            }
            
            responseCallback(data)
        }
    }
}
