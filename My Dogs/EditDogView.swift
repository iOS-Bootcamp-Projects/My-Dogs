//
//  EditDogView.swift
//  My Dogs
//
//  Created by Aamer Essa on 29/11/2022.
//

import UIKit

class EditDogView: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var dogFavoriteTreat: UITextField!
    @IBOutlet weak var dogColor: UITextField!
    @IBOutlet weak var dogName: UITextField!
    @IBOutlet weak var dogImageView: UIImageView!
    
    var dogImage = UIImage()
    var dogsName = String()
    var dogsColor = String()
    var dogsFavoriteTreat = String()
    var imageData = Data()
    var dog:dogs?
    var destination = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        dogName.text = dogsName
        dogColor.text = dogsColor
        dogFavoriteTreat.text = dogsFavoriteTreat 
        
        // setip the label  inside image view
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: dogImageView.frame.width , height: 30))
           titleLabel.text = "Add Photo"
           titleLabel.font = UIFont(name:"chalkboard SE", size: 18)
        titleLabel.textColor = .white
        dogImageView.addSubview(titleLabel)
        dogImageView.image = dogImage 
        
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

        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
      
    @IBAction func editDog(_ sender: Any) {
        if imageData.isEmpty {
            imageData = dogImage.pngData()!
            dog?.editDogs(dogesName: dogName.text!, dogsColor: dogColor.text!, dogsFavoriteTreat: dogFavoriteTreat.text!, dogesImage: imageData, destination: destination)
        } else{
            dog?.editDogs(dogesName: dogName.text!, dogsColor: dogColor.text!, dogsFavoriteTreat: dogFavoriteTreat.text!, dogesImage: imageData, destination: destination)
        }
      
    }
    
    @IBAction func deleteDog(_ sender: Any) {
        dog?.deletDoga(destination: destination)
    }
    

}
