//
//  ViewController.swift
//  AlisverisListesi
//
//  Created by Berat Yavuz on 18.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(eklemeButonuTiklandi))
        
    }
    @objc func eklemeButonuTiklandi(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }

}

