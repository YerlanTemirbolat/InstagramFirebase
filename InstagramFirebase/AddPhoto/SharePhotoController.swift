//
//  SharePhotoController.swift
//  InstagramFirebase
//
//  Created by Yerlan on 31.01.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    fileprivate func setupImageAndTextViews() {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
                
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleShare() {
        
        guard let image = selectedImage else { return }

        guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }

        let filename = NSUUID().uuidString

        guard let uid = Auth.auth().currentUser?.uid else { return }

        let ref = Storage.storage().reference(withPath: uid)

        ref.putData(uploadData, metadata: nil) { metadata, err in

            if let err = err {
                print("Failed to push image to Storage:", err)
                return
            }

            ref.downloadURL { url, err in

                if let err = err {
                    print("Failed to retrieve downloadURL:", err)
                    return
                }

                print("Successfully stored image with url:", url?.absoluteString ?? "")

//                let dictionaryValues = ["username": username, "profileImageUrl": url] as [String : Any]
//                let values = [uid: dictionaryValues]

                Database.database().reference().child("users").updateChildValues([:], withCompletionBlock: { (err, ref) in

                    if let err = err {
                        print("Failed to save user info into db:", err)
                        return
                    }

                    print("Successfully saved user info to db")

                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }

                    mainTabBarController.setupViewControllers()

                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    var preferredStatusBarHidden: Bool {
        return true
    }
}
