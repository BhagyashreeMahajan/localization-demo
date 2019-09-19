//
//  ViewController.swift
//  localization demo
//
//  Created by Bhagyalaxmi Poojary on 05/10/18.
//  Copyright © 2018 KK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblWelcome: UILabel!
    @IBOutlet var btnLanguage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Localisator"
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        
        configureViewFromLocalisation()
    }

    func configureViewFromLocalisation() {
        
        
        lblWelcome.text      = Localization("HomeTitleText")
        btnLanguage.setTitle(Localization("HomeButtonTitle"), for: UIControlState.normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Notification methods
    
    @objc func receiveLanguageChangedNotification(notification:NSNotification) {
        if notification.name == kNotificationLanguageChanged {
            configureViewFromLocalisation()
        }
    }
    
    // MARK: - Memory management
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }

}

