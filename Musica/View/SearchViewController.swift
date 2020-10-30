//
//  ViewController.swift
//  Musica
//
//  Created by Ulvi Bashirov on 10/15/20.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var trackCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var viewModel = MusicViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp() {
        searchView.layer.cornerRadius = 20
        searchTextField.delegate = self
        trackCollectionView.delegate = self
        trackCollectionView.dataSource = self
        trackCollectionView.keyboardDismissMode = .interactive
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Song or artist...",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        getTracks(text: "ezhel")
    }
    
    func getTracks(text: String) {
        viewModel.search(text: text, success: {
            self.trackCollectionView.reloadData()
        }, failure: {
            //show alert
        })
    }
    
    @IBAction func valueChanged(_ sender: UITextField) {
        let text = sender.text == "" ? "ezhel" : (sender.text ?? "")
        getTracks(text: text)
    }    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trackCollectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
        cell.setUp(track: viewModel.tracks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - (60)) / 2
        return CGSize(width: width, height: 190)
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "trackVC") as! TrackViewController
        present(vc, animated: true)
        vc.setUp(track: viewModel.tracks[indexPath.row])
        vc.setIndexPath(indexPath: indexPath)
        vc.viewModel = viewModel
    }
}
