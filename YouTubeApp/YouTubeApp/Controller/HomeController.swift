//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Alexey Danilov on 05/09/2018.
//  Copyright © 2018 Alexey Danilov. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
//    private var videos: [Video] = {
//
//        let kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "taylor_swift_profile"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 16009000
////        blankSpaceVideo.uploadDate
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylor_swift_blank_space"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 9087848383
//
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    private let cellId = "CellId"
    
    private let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableLeaves, .mutableContainers]) as? [[String: Any]] {
                    
                    self.videos = [Video]()
                    
                    for dict in json {
                        let video = Video()
                        video.title = dict["title"] as? String
                        video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                        
                        if let channelDict = dict["channel"] as? [String: Any] {
                            let channel = Channel()
                            channel.name = channelDict["name"] as? String
                            channel.profileImageName = channelDict["profile_image_name"] as? String
                            
                            video.channel = channel
                        }
                        
                        self.videos?.append(video)
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        })
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(
            image: searchImage,
            style: .plain,
            target: self,
            action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(
            image: moreImage,
            style: .plain,
            target: self,
            action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    @objc func handleSearch() {
        
    }
    
    @objc func handleMore() {
        
    }

}

