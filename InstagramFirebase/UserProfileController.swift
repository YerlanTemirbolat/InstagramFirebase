//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Yerlan on 28.01.2022.
//

import Firebase
import UIKit


class UserProfileController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .green
        
        navigationItem.title = Auth.auth().currentUser?.uid
        
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let userName = dictionary["username"] as? String
            self.navigationItem.title = userName
            
        } withCancel: { err in
            print("Failed to fetch user:", err)
        }
    }
}
