//
//  API.swift
//  Musica
//
//  Created by Ulvi Bashirov on 10/15/20.
//

import Foundation
import Alamofire

struct Network {
    static let url = URL(string: "https://rapidapi.p.rapidapi.com/search")!
    static private let headers: HTTPHeaders = [
        "x-rapidapi-host": "deezerdevs-deezer.p.rapidapi.com",
        "x-rapidapi-key": "ce0455611amsh402292da2fb68fdp16df03jsn8f029e4855ec"
    ]
    
    static func searchApi(searchText: String, completion: @escaping (Result) -> ()) {
        
        let parameters: [String: String] = ["q": searchText]

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            if let jsonData = response.data {
                do {
                    let res = try JSONDecoder().decode(Result.self, from: jsonData)
                    completion(res)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
