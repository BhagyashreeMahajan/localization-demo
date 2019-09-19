//
//  Localisator.swift
//  Localisator_Demo-swift
//
//  Created by Michaël Azevedo on 10/02/2015.
//  Copyright (c) 2015 Michaël Azevedo. All rights reserved.
//

import UIKit

let kNotificationLanguageChanged        = NSNotification.Name(rawValue:"kNotificationLanguageChanged")

func Localization(_ string:String) -> String{
    return Localisator.sharedInstance.localizedStringForKey(string)
}

func SetLanguage(_ language:String) -> Bool {
    return Localisator.sharedInstance.setLanguage(language)
}

class Localisator {
   
    // MARK: - Private properties
    
    private let userDefaults                    = UserDefaults.standard
    private var availableLanguagesArray         = [ "English_en", "Marathi_mr"]
    private var dicoLocalisation:NSDictionary!
    
    private let kSaveLanguageDefaultKey         = "kSaveLanguageDefaultKey"
    
    // MARK: - Singleton method
    
    class var sharedInstance :Localisator {
        struct Singleton {
            static let instance = Localisator()
        }
        return Singleton.instance
    }
    
    // MARK: - Public custom getter
    
    func getArrayAvailableLanguages() -> [String] {
        return availableLanguagesArray
    }
    
    // MARK: - Private instance methods
    
    fileprivate func loadDictionaryForLanguage(_ newLanguage:String) -> Bool {
        
        let arrayExt = newLanguage.components(separatedBy: "_")
        
        for ext in arrayExt {
            if let path = Bundle(for:object_getClass(self)!).url(forResource: "Localizable", withExtension: "strings", subdirectory: nil, localization: ext)?.path {
                if FileManager.default.fileExists(atPath: path) {
                  //  currentLanguage = newLanguage
                    dicoLocalisation = NSDictionary(contentsOfFile: path)
                    return true
                }
            }
        }
        return false
    }
    
    fileprivate func localizedStringForKey(_ key:String) -> String {
        
        if let dico = dicoLocalisation {
            if let localizedString = dico[key] as? String {
                return localizedString
            }  else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }
    
    fileprivate func setLanguage(_ newLanguage:String) -> Bool
    {
        if loadDictionaryForLanguage(newLanguage) {
            NotificationCenter.default.post(name: kNotificationLanguageChanged, object: nil)
            return true
        }
        return false
    }
}

