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
    func fetchAllDatas() async throws-> [Result]?
}

struct RickyMortyService: RickyMortyServiceInterface {
    func fetchAllDatas() async throws -> [Result]? {
        let request = AF.request(RickyMortyServiceEndPoint.characterPath(), method: .get)
        var response: RickyMortyModel?
        do {
            response = try await request.serializingDecodable(RickyMortyModel.self).value
        } catch {
            print("Ricky And Morty Characters API Request Error, \(error)")
            throw error
        }
        
        
        return response?.results
    }
}

