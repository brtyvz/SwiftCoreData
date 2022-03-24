//
//  DetailsViewController.swift
//  AlisverisListesi
//
//  Created by Berat Yavuz on 18.03.2022.
//

import UIKit
import CoreData
class DetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var secilenUrunIsmi = ""
    var secilenUUID : UUID?

    @IBOutlet weak var kaydetButton: UIButton!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var fiyatTextField: UITextField!
    @IBOutlet weak var bedenTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if secilenUrunIsmi != ""{
            //core datadan veriler çekilecek
            
            kaydetButton.isHidden = true
            
            if let uuidString = secilenUUID?.uuidString{
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
                fetchRequest.predicate = NSPredicate(format: "id = %@",uuidString)
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let sonuclar = try context.fetch(fetchRequest)
                    
                    if sonuclar.count>0 {
                        for sonuc in sonuclar as! [NSManagedObject]{
                            
                            if let isim = sonuc.value(forKey: "isim") as? String{
                                isimTextField.text = isim
                            }
                            if let fiyat = sonuc.value(forKey: "fiyat") as? Int{
                                
                                fiyatTextField.text = String(fiyat)
                            }
                            
                            if let beden = sonuc.value(forKey: "beden") as? String{
                                
                                bedenTextField.text = beden
                            }
                            if let gorselData = sonuc.value(forKey: "gorsel") as? Data{
                                
                                let image = UIImage(data: gorselData)
                                imageView.image = image
                            }
                            
                            
                            
                        }
                    }
                    
                    
                } catch  {
                    print("hatalı")
                }
                
            }
        }
        else{
            kaydetButton.isHidden = false
            kaydetButton.isEnabled = false
            isimTextField.text = ""
            fiyatTextField.text = ""
            bedenTextField.text = ""
            
        }
        
        let gestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognaizer)
        
        //imageviewi kullanıcının etkileşime girebileceği şekilde ayarladık
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(imageGestureRecognaizer)
    }
   
    @objc func gorselSec(){
//        galeriden görsel çekmek için picker nesnesini kulanıcaz
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        kaydetButton.isEnabled = true
        
        self.dismiss(animated: true, completion: nil)
    }

    @objc func klavyeyiKapat(){
        view.endEditing(true)
    }
    
    @IBAction func kaydetButtonTiklandi(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let alisveris = NSEntityDescription.insertNewObject(forEntityName: "Alisveris", into: context)
        
        alisveris.setValue(isimTextField.text!, forKey: "isim")
        alisveris.setValue(bedenTextField.text!, forKey: "beden")
        
        if let fiyat = Int(fiyatTextField.text!){
            alisveris.setValue(fiyat, forKey: "fiyat")
            
        }
        
        alisveris.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        alisveris.setValue(data, forKey: "gorsel")
        
        do {
            try context.save()
            print("kayıt edildi")
        } catch  {
            print( "hatalı")
        }
        // verinin kaydedildiğini haber veriyor
        NotificationCenter.default.post(name: NSNotification.Name("veriGirildi"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
   
    

}
