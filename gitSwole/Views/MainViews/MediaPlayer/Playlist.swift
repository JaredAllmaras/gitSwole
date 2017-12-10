//
//  Playlist.swift
//  gitSwole
//
//  Created by Jared Allmaras on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

enum Playlist {
    case kanye, drake
    
    var title: String {
        switch self {
        case .kanye: return "Kanye West - Graduation"
        case .drake: return "Drake - Views"
        }
    }
    var urlString: String {
        switch self {
        case .kanye: return "spotify:album:3SZr5Pco2oqKFORCP3WNj9"
        case .drake: return "spotify:album:40GMAhriYJRO1rsY4YdrZb"
        }
    }

}
