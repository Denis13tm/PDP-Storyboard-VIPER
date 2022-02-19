//
//  BaseViewController.swift
//  PDP_StoryboardContact
//
//  Created by Otabek Tuychiev Muzaffar Ugli on 19/02/2022.
//https://github.com/Denis13tm/PDP_StoryboardContact.git

import UIKit
import JGProgressHUD

class BaseViewController: UIViewController {
    
    let progress = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Methods...
    
    private func appDelegate() -> AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    private func sceneDelegate() -> SceneDelegate {
        (UIApplication.shared.connectedScenes.first! .delegate as? SceneDelegate)!
    }
    
    func indicateProgressView() {
        if !progress.isVisible {
            progress.textLabel.text = "Loading..."
            progress.show(in: self.view)
        }
    }
    
    func hideProgressView() {
        if progress.isVisible {
            progress.dismiss()
        }
    }

}
