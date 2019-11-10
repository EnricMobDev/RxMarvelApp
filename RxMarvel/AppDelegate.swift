//
//  AppDelegate.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let privateKey = KeychainManager(key: "MarvelPrivateKey")
    private let publicKey = KeychainManager(key: "MarvelPublicKey")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let isKeyChainEmpty = checkIfKeychainExist(privateKey, publicKey)
        isKeyChainEmpty ? storeKeychains(privateKey, publicKey) : nil
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //MARK: Keychain fucntions
    private func checkIfKeychainExist(_ privateKey: KeychainManager, _ publicKey: KeychainManager) -> Bool {
        let isKeychainEmpty = privateKey.readStringValue().isEmpty || publicKey.readStringValue().isEmpty
         return isKeychainEmpty ? true : false
    }
    
    private func storeKeychains(_ privateKey: KeychainManager, _ publicKey: KeychainManager) {
        privateKey.storeString(value: "a52d24c4a5ba214407207cc81e5589c0b24673eb")
        publicKey.storeString(value: "194ee5cf836e30f41ca7fa8ae4e9e34c")
    }
}

