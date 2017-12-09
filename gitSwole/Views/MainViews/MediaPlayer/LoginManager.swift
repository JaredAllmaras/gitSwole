//
//  LoginManager.swift
//  gitSwole
//
//  Created by Jared Allmaras on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import SafariServices

protocol LoginManagerDelegate: class {
    func loginManagerDidLoginWithSuccess()
}

class LoginManager {
    
    static var shared = LoginManager()
    private init() {
        let redirectURL = "gitswole://"
        let clientID = "c32c4b25afb545a9824c43ac88a32247"
        auth.sessionUserDefaultsKey = "current session"
        auth.redirectURL    = URL(string: redirectURL)
        auth.clientID       = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope,
            SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
    }
    
    weak var delegate: LoginManagerDelegate?
    var auth = SPTAuth.defaultInstance()!
    private var session: SPTSession? {
        if let sessionObject = UserDefaults.standard.object(forKey: auth.sessionUserDefaultsKey) as?
            Data {
            return NSKeyedUnarchiver.unarchiveObject(with: sessionObject) as? SPTSession
        }
        return nil
    }
    var isLogged: Bool {
        if let session = session {
            return session.isValid()
        }
        return false
    }
    
    func preparePlayer() {
        guard let session = session else { return }
        MediaPlayer.shared.configurePlayer(authSession: session, id: auth.clientID)
    }
    
    func login() {
        let safariVC = SFSafariViewController(url: auth.spotifyAppAuthenticationURL())
        UIApplication.shared.keyWindow?.rootViewController?.present(safariVC, animated: true, completion: nil)
    }
    
    func handled(url: URL) -> Bool {
        guard auth.canHandle(auth.redirectURL) else {return false}
        auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
            if error != nil {
                print("error!")
            }
            self.delegate?.loginManagerDidLoginWithSuccess()
            self.preparePlayer()
        })
        return true
    }
    
    
}
