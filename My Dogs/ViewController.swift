//
//  ViewController.swift
//  My Dogs
//
//  Created by Aamer Essa on 27/11/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController,dogs {
    
            

    @IBOutlet weak var ImageCollections: UICollectionView!
   
  
    var dogs = [Dogs]()
   let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // connect to DB
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ImageCollections.delegate = self
        ImageCollections.dataSource = self
        
       fetchAllDogs()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! AddNewDogViewView
        segue.Dog = self
    }
    
    
    func addNewDogs(dogesName: String, dogsColor: String, dogsFavoriteTreat: String, dogesImage: Data) {

        if dogesName != ""{
            
            let newDog = Dogs(context: managedObjectContext)
            newDog.dog_name = dogesName
            newDog.dog_color = dogsColor
            newDog.dog_favorite_treat = dogsFavoriteTreat
            newDog.dog_image = dogesImage

            dogs.append(newDog)

            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            ImageCollections.reloadData()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func editDogs(dogesName: String, dogsColor: String, dogsFavoriteTreat: String, dogesImage: Data, destination: Int) {

        let editDog = dogs[destination]
        editDog.dog_name = dogesName
        editDog.dog_color = dogsColor
        editDog.dog_favorite_treat = dogsFavoriteTreat
        editDog.dog_image = dogesImage

        do{
            try managedObjectContext.save()

        } catch {
            print("\(error)")
        } // end of catch

        ImageCollections.reloadData()
        dismiss(animated: true)

    }

    func deletDoga(destination:Int) {
        managedObjectContext.delete(dogs[destination])
        do{
            try managedObjectContext.save()
        } catch{
            print("\(error)")
        }

        dogs.remove(at: destination)
        ImageCollections.reloadData()
        dismiss(animated: true)
    }
    
    

    func fetchAllDogs (){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Dogs")
        do{
            let resualt = try managedObjectContext.fetch(request)
              dogs = resualt as! [Dogs]
        } catch {
            print("\(error)")
        }

    } // end of fetchAllTa
    
    
   

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageCollections.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! CollectionViewCell
        let imageView = UIImageView(image: UIImage(data: dogs[indexPath.row].dog_image!)) // conver from data to image
        imageView.alpha = 0.8
        cell.backgroundView = imageView
        cell.dogNames.text = "\( dogs[indexPath.row].dog_name!)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let editView = storyBoard.instantiateViewController(withIdentifier: "EditView") as! EditDogView
        editView.dogsName = dogs[indexPath.row].dog_name!
        editView.dogsColor = dogs[indexPath.row].dog_color!
        editView.dogsFavoriteTreat = dogs[indexPath.row].dog_favorite_treat!
        editView.dogImage = UIImage(data: dogs[indexPath.row].dog_image!)!
        editView.destination = indexPath.row
        editView.dog = self
        editView.modalPresentationStyle = .formSheet
        present(editView, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-4, height: (view.frame.size.height/5)-4)
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
