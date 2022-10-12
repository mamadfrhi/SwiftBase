//
//  VideoListView.swift
//  Africa
//
//  Created by iMamad on 07.10.22.
//

import SwiftUI

struct VideoListView: View {
    
    //MARK: - PROPERTIES
    @State var videos: [Video] = Bundle.main.decode("videos.json")
    private let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            List(videos) { video in
                VideoListItemView(video: video)
                    .padding(.vertical, 8)
            } //: LIST
            .navigationTitle(Text("Videos"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        videos.shuffle()
                        hapticImpact.impactOccurred()
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                    }

                }
            }
            
            
        } //: NAVIGATION
    }
}


// MARK: - PREVIEW
struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}
