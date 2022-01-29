//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Yerlan on 28.01.2022.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            
            present(navController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let navController = UINavigationController(rootViewController: controller)
                self.present(navController, animated: true, completion: nil)
            }

            return
        }
        
        setupViewControllers()
        
//        func setupBottomTabar() {
//            let bottomDividerView = UIView()
//            bottomDividerView.backgroundColor = UIColor.lightGray
//            bottomDividerView.translatesAutoresizingMaskIntoConstraints = false
//
//            view.addSubview(bottomDividerView)
//
//            NSLayoutConstraint.activate([
//                bottomDividerView.topAnchor.constraint(equalTo: view.topAnchor),
//                bottomDividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                bottomDividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                bottomDividerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
//                bottomDividerView.heightAnchor.constraint(equalToConstant: 20)
//            ])
//        }
    }
    
    func setupViewControllers() {
        
        // home
        let homeNavController = templateNavController(unselectedImage: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // search
        let searchNavController = templateNavController(unselectedImage: UIImage(named: "search_unselected")!, selectedImage: UIImage(named: "search_selected")!)
        
        // plus
        let plusNavController = templateNavController(unselectedImage: UIImage(named: "plus_unselected")!, selectedImage: UIImage(named: "plus_unselected")!)
        
        // like
        let likeNavController = templateNavController(unselectedImage: UIImage(named: "like_unselected")!, selectedImage: UIImage(named: "like_selected")!)
        
        // user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = UIImage(named: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           plusNavController,
                           likeNavController,
                           userProfileNavController,
                          ]
        
        // modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        // home
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
