//
//  DetailsViewController.swift
//  AlisverisListesi
//
//  Created by Berat Yavuz on 18.03.2022.
//

import UIKit

class DetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var fiyatTextField: UITextField!
    @IBOutlet weak var bedenTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognaizer)
        
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
        imageView.image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }

    @objc func klavyeyiKapat(){
        view.endEditing(true)
    }
    
    @IBAction func kaydetButtonTiklandi(_ sender: Any) {
        
    }
    
   
    

}
