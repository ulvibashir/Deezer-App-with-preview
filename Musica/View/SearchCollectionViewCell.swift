//
//  SearchCollectionViewCell.swift
//  Musica
//
//  Created by Ulvi Bashirov on 10/15/20.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackLabel: UILabel!
    
    @IBOutlet weak var trackImageView: UIImageView! {
        didSet {
            trackImageView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var innerView: UIView! {
        didSet {
            innerView.layer.cornerRadius = 15
            innerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            innerView.layer.shadowOffset = CGSize(width: 4.0, height: 7.0)
            innerView.layer.shadowOpacity = 3.0
            innerView.layer.shadowRadius = 7.0
            innerView.layer.masksToBounds = false
        }
    }
    
    func setUp(track: Track?) {
        trackLabel.text = "\(track?.title ?? "") - \(track?.artist?.name ?? "")"
        let url = track?.album?.cover_medium ?? ""
        trackImageView.sd_setImage(with: URL(string: url))
        trackImageView.contentMode = .scaleToFill
    }
    
    override func prepareForReuse() {
        trackLabel.text = nil
        trackImageView.image = nil
    }
}
