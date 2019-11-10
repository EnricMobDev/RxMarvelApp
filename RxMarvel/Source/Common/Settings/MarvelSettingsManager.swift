//
//  MarvelSettingsManager.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 10/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import Foundation

protocol SettingsManagerProtocol {
    var apiURL: String { get }
}

struct MarvelSettingsManager {
    private let privateKey = KeychainManager(key: "MarvelPrivateKey")
    private let publicKey = KeychainManager(key: "MarvelPublicKey")
    
    init() {
        let isKeyChainEmpty = checkIfKeychainExist(privateKey, publicKey)
        isKeyChainEmpty ? storeKeychains(privateKey, publicKey) : nil
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
    
    //MARK: Convert URL methods
    private func getPrivateKey() -> String {
        return KeychainManager(key: "MarvelPrivateKey").readStringValue()
    }
    
    private func getPublicKey() -> String {
        return KeychainManager(key: "MarvelPublicKey").readStringValue()
    }
    
    private func getHashedKey(_ privateKey: String, _ publicKey: String) -> String {
        let timestamp = "1"
        let hashParameters = timestamp + privateKey + publicKey
        return hashParameters.md5Hash(parameters: hashParameters)
    }
    
    private func convertoToURL(_ hashedKey: String, _ publicKey: String) -> String {
        let timestamp = "1"
        return "https://gateway.marvel.com:443/v1/public/characters?apikey=\(publicKey)&hash=\(hashedKey)&ts=\(timestamp)"
    }
    
}

extension MarvelSettingsManager: SettingsManagerProtocol {
    var apiURL: String {
        let privateKey = getPrivateKey()
        let publicKey = getPublicKey()
        let hashedKey = getHashedKey(privateKey, publicKey)
        let hashedUrl = convertoToURL(hashedKey, publicKey)
        return hashedUrl
    }
}
