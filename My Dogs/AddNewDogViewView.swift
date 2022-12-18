//
//  AddNewDogViewView.swift
//  My Dogs
//
//  Created by Aamer Essa on 29/11/2022.
//

import UIKit

class AddNewDogViewView: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var dogFavoriteTreat: UITextField!
    @IBOutlet weak var dogColorLabel: UITextField!
    @IBOutlet weak var dogNameLabel: UITextField!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var addNewDogBtn: UIButton!
    
    var Dog:dogs?
    // dogs is the name of protocol
    
   var imageData = Data()
    override func viewDidLoad() {
        super.viewDidLoad()

        // setip the label  inside image view
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: dogImageView.frame.width , height: 30))
           titleLabel.text = "Add Photo"
           titleLabel.font = UIFont(name:"chalkboard SE", size: 18)
           titleLabel.textColor = .white
        dogImageView.addSubview(titleLabel)
        
        
        // add action to image view
        let uploadImage = UITapGestureRecognizer(target: self, action: #selector(AddNewDogViewView.imageTapped(gesture:)))

        dogImageView.addGestureRecognizer(uploadImage)
        dogImageView.isUserInteractionEnabled = true
        
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
       
        if (gesture.view as? UIImageView) != nil {
          
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        }
    }
       
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {

            dogImageView.image = image
            dogImageView.contentMode = .scaleToFill
            imageData = image.pngData()!
            print(image)
        }
        picker.dismiss(animated: true)
    }
        
    @IBAction func addNewImage(_ sender: Any) {
        
        Dog?.addNewDogs(dogesName: dogNameLabel.text!, dogsColor: dogColorLabel.text!, dogsFavoriteTreat: dogFavoriteTreat.text!, dogesImage: imageData)
        

    }
    
    
  
   
    
    
}



   

