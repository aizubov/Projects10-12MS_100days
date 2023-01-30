//
//  DetailViewController.swift
//  Projects10-12MS_100days
//
//  Created by user228564 on 1/29/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var pictures: [Picture]!
    var picture: Picture!
    var current: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        picture = pictures[current]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editName))
        
        title = picture.imageName
        
        imageView.image = UIImage(contentsOfFile:FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(picture.imageID).path)
    }
    
    @objc func editName() {
        let ac = UIAlertController(title: "Edit", message: "Enter new name", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler:{ [weak self, weak ac] _ in
            if let newName = ac?.textFields?[0].text {
                print(self!.picture.imageName)
                self?.picture.imageName = newName
                print(self!.picture.imageName)
                DispatchQueue.global().async {
                    if let picturesToSave = self?.pictures {
                        if let encodedPictures = try? JSONEncoder().encode(picturesToSave) {
                            UserDefaults.standard.set(encodedPictures, forKey: "Pictures")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self?.title = self?.picture.imageName
                    }
                }
            }
        }
                                  ))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}
