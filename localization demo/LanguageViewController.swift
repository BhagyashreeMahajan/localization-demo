//
//  LanguageViewController.swift
//  localization demo
//
//  Created by Bhagyalaxmi Poojary on 05/10/18.
//  Copyright © 2018 KK. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableViewLanguages: UITableView!
    @IBOutlet var labelChooseLanguage: UILabel!
    
    let arrayLanguages = Localisator.sharedInstance.getArrayAvailableLanguages()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        
        configureViewFromLocalisation()
    }

    func configureViewFromLocalisation() {
       // title                           = Localization("")
        labelChooseLanguage.text        = Localization("LocalisatorViewTitle")
        // labelSaveLanguage.text          = Localization("LocalisatorViewSaveText")
        tableViewLanguages.reloadData()
    }
    
    // MARK: - Notification methods
    
    @objc func receiveLanguageChangedNotification(notification:NSNotification) {
        if notification.name == kNotificationLanguageChanged {
            configureViewFromLocalisation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLanguages.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyIdentifier")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MyIdentifier")
        }
        cell!.selectionStyle        = UITableViewCellSelectionStyle.gray
        cell!.imageView?.image      = UIImage(named:arrayLanguages[indexPath.row])
        cell!.textLabel?.text       = Localization(arrayLanguages[indexPath.row])
        return cell!
    }
    
    // MARK: - UITableViewDelegateprotocol conformance
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        if SetLanguage(arrayLanguages[indexPath.row])
        {
            let alertController = UIAlertController(title: nil, message:Localization("languageChangedWarningMessage"), preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style:.default, handler: { (alert: UIAlertAction!) in
                
            })
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Memory management
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
