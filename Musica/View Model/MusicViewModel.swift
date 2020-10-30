//
//  searchViewModel.swift
//  Musica
//
//  Created by Ulvi Bashirov on 10/15/20.
//

import Foundation


class MusicViewModel {
    
    var tracks = [Track]()
    var history: [String]?
    
    func search(text: String, success: @escaping ()->(), failure: @escaping ()->()) {
        
   
        Network.searchApi(searchText: text) { response in
            if let data = response.data {
                self.tracks = data
                success()
            } else {
                failure()
            }
        }
    }
    
    func getMusic(with index: Int) throws -> Track {
        
        if tracks.count <= index {
            throw ValidationErrors.outOfRange
        }
        return tracks[index]
    }
}
