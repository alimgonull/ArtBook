//
//  DetailVc.swift
//  ArtBook
//
//  Created by Alim Gönül on 16.09.2023.
//

import UIKit
import CoreData
class DetailVc: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled  = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
        
    }
    @objc func selectImage() {
        // KULLANICININ GALERİSİNE ERİŞİM SAĞLIYORUZ
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
    }
    // ERİŞİM SAĞLADIKTAN SONRA İŞLEM BİTİMİNDE GERİ DÖNÜŞ YAPILIYOR
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Resmin ojinal halini alıyoruz
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }

    @IBAction func saveButton(_ sender: Any) {
        //  VERİLERİ SAKLADIĞIMIZ ALAN
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Burdaki contexti kullanarak oluşturduğumuz entity'nin içine verileri kaydediyoruz.
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Painting", into: context)
        
        // Attributes
        
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
            
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("Succes")
        }catch {
            print("error")
        }
    }
    
 
   
}
