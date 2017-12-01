//
//  PlaylistViewController.swift
//  gitSwole
//
//  Created by Jared Allmaras on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    private var playerView: UIView!
    private var playerButton: UIButton!
    fileprivate var infoLabel: UILabel!
    private var tableView: UITableView!
    fileprivate var progressSlider: UISlider!
    fileprivate var album: SPTAlbum?
    fileprivate var tracks: [SPTPartialTrack]? {
        return album?.tracksForPlayback() as? [SPTPartialTrack]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showAlbumSelection()
        configureView()
        MediaPlayer.shared.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlbumSelection() {
        let alert = UIAlertController(title: "Please select your favorite album", message: "", preferredStyle: .alert)
        let firstAction = UIAlertAction(title: Playlist.kanye.title, style: .default) { (action) in
            self.load(playlist: Playlist.kanye)
        }
        alert.addAction(firstAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func configurePlayerView() {
        playerView = UIView()
        playerView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        playerButton = UIButton()
        playerButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        playerButton.tintColor = .white
        playerButton.translatesAutoresizingMaskIntoConstraints = false
        playerButton.addTarget(self, action: #selector(playerButtonAction), for: .touchUpInside)
        
        infoLabel = UILabel()
        infoLabel.text = "No song loaded"
        infoLabel.textColor = .white
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.numberOfLines = 0
        
        progressSlider = UISlider()
        progressSlider.translatesAutoresizingMaskIntoConstraints = false
        progressSlider.tintColor = .spotifyGreen
        progressSlider.isContinuous = false
        progressSlider.addTarget(self, action: #selector(progressSliderAction(sender:)), for: .valueChanged)
        
        view.addSubview(playerView)
        playerView.addSubview(infoLabel)
        playerView.addSubview(playerButton)
        playerView.addSubview(progressSlider)
        
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        playerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        playerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        playerButton.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 16).isActive = true
        playerButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        playerButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        playerButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor).isActive = true
        
        infoLabel.leadingAnchor.constraint(equalTo: playerButton.trailingAnchor, constant: 20).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: playerView.centerYAnchor, constant: -15).isActive = true
        
        progressSlider.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor).isActive = true
        progressSlider.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5).isActive = true
        progressSlider.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16).isActive = true
        
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: playerView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    @objc func progressSliderDidStartDrag(sender: UISlider) {
        MediaPlayer.shared.seek(to: sender.value)
    }
    
    @objc func progressSliderAction(sender: UISlider) {
        MediaPlayer.shared.seek(to: sender.value)
    }
    
    @objc func playerButtonAction() {
        updatePlayButton(playing: !MediaPlayer.shared.isPlaying)
        if MediaPlayer.shared.isPlaying {
            MediaPlayer.shared.pause()
        } else {
            if MediaPlayer.shared.currentTrack != nil {
                MediaPlayer.shared.resume()
            } else {
                if let tracks = tracks, let first = tracks.first {
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    MediaPlayer.shared.play(track: first)
                    infoLabel.text = first.name
                } else {
                    showDefaultError()
                }
            }
        }
    }
    
    private func load(playlist: Playlist) {
        guard LoginManager.shared.isLogged else {return}
        MediaPlayer.shared.loadAlbum(url: playlist.urlString) {[weak self] (album, error) in
            guard let  `self` = self else {return}
            guard let album = album, error == nil else {
                self.showDefaultError()
                return
            }
            self.album = album
            self.title = album.name
            self.tableView.reloadData()
        }
    }
    
    fileprivate func updatePlayButton(playing: Bool) {
        playerButton.setImage(playing ? #imageLiteral(resourceName: "pause") : #imageLiteral(resourceName: "play"), for: .normal)
    }
}

extension PlaylistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tracks = tracks {
            return tracks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let track = tracks![indexPath.row]
        cell.textLabel!.text = track.name
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks![indexPath.row]
        if let current = MediaPlayer.shared.currentTrack, current == track {
            return
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell!.textLabel?.textColor = .black
        MediaPlayer.shared.play(track: track)
        infoLabel.text = track.name
        updatePlayButton(playing: true)
    }
}

extension PlaylistViewController: MediaPlayerDelegate {
    
    func mediaPlayerDidStartPlaying(track: SPTPartialTrack) {
        
    }
    
    func mediaPlayerDidChange(trackProgress: Double) {
        progressSlider.setValue(Float(trackProgress), animated: true)
    }
    
    func mediaPlayerDidPause() {
        
    }
    
    func mediaPlayerDidResume() {
        
    }
    
    func mediaPlayerDidFail(error: Error) {
        showDefaultError()
        MediaPlayer.shared.pause()
        updatePlayButton(playing: false)
    }
    
    func mediaPlayerDidFinishTrack() {
        updatePlayButton(playing: false)
        progressSlider.setValue(0, animated: false)
    }
    
    fileprivate func showDefaultError() {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
