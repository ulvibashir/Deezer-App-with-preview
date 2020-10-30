//
//  TrackViewController.swift
//  Musica
//
//  Created by Ulvi Bashirov on 10/15/20.
//


import UIKit
import AVKit

class TrackViewController: UIViewController {
    
    @IBOutlet weak var singleTrackImage: UIImageView!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var singleTrackLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var forwardBtn: UIButton!
    
    var player = AVPlayer()
    var playerStatus: Bool = false
    var timer: Timer?
    var timeTick: Int = 0
    var indexPath: IndexPath?
    var viewModel = MusicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundBlur()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player.pause()
    }
    
    func setUp(track: Track?) {
        singleTrackLabel.text = "\(track?.artist?.name ?? "") - \(track?.title ?? "")"
        let url = track?.album?.cover_medium ?? ""
        singleTrackImage.sd_setImage(with: URL(string: url))
        singleTrackImage.contentMode = .scaleToFill
        singleTrackImage.layer.borderWidth = 1
        singleTrackImage.layer.masksToBounds = false
        singleTrackImage.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        singleTrackImage.layer.cornerRadius = 20
        singleTrackImage.clipsToBounds = true
        playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        backwardBtn.setImage(#imageLiteral(resourceName: "backward"), for: .normal)
        forwardBtn.setImage(#imageLiteral(resourceName: "forward"), for: .normal)
        backgroundImageView.sd_setImage(with: URL(string: url))
        singleTrackImage.contentMode = .scaleToFill
        
        
        let playerItem = AVPlayerItem(url: URL(string: track?.preview ?? "")!)
        player = AVPlayer(playerItem: playerItem)
        
        audioSlider.minimumValue = 0
        audioSlider.maximumValue = 30
        
        timeLabel.text = "00:00"
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        next()
        play()
    }
    
    @objc func everyTick() {
        update()
        timeTick += 1
    }
    
    func setBackgroundBlur () {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(blurEffectView)
        blurEffectView.frame = backgroundImageView.frame
    }
    
    func setIndexPath(indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    func update() {
        audioSlider.setValue(Float(player.currentTime().seconds), animated: true)
        updateTimeLabel()
    }
    
    func updateTimeLabel () {
        let zeroStr = timeTick < 10 ? "0" : ""
        timeLabel.text = "0\(Int(player.currentTime().seconds / 60)):\(zeroStr)\(timeTick)"

    }
    
    func next() {
        if let index = indexPath?.row, index+1 < viewModel.tracks.count {
            let track = viewModel.getMusic(with: index+1)
            setUp(track: track)
            self.indexPath!.row += 1
        }
        
        update()
        timeTick = 0
        updateTimeLabel()
        playerStatus = false
        timer?.invalidate()
    }
    
    func back() {
        if let index = indexPath?.row, index-1 > viewModel.tracks.count {
            let track = viewModel.getMusic(with: index-1)
            setUp(track: track)
            self.indexPath!.row -= 1
        }
        update()
        timeTick = 0
        updateTimeLabel()
        timer?.invalidate()
        playerStatus = false
    }
    
    func play() {
        if playerStatus {
            player.pause()
            playerStatus = false
            playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            timer?.invalidate()
        } else {
            player.play()
            playerStatus = true
            playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(everyTick), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func sliderChangeAction(_ sender: UISlider) {
        
    }
    
    @IBAction func playAction(_ sender: Any) {
        play()
    }
    
    @IBAction func backwardAction(_ sender: Any) {
       back()
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        next()
    }
    
}
