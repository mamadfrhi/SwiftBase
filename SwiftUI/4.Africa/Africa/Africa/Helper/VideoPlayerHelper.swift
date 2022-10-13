//
//  VideoPlayerHelper.swift
//  Africa
//
//  Created by iMamad on 13.10.22.
//

import AVKit

var videoPlayer : AVPlayer?

func playVideo(fileName: String, fileFormat: String) -> AVPlayer {
    if let videoURL = Bundle.main.url(forResource: fileName, withExtension: fileFormat) {
        videoPlayer = AVPlayer(url: videoURL)
        videoPlayer?.play()
    }
    return videoPlayer!
}
