//
//  ViewController.swift
//  Ejercicio1
//
//  Created by DISMOV on 10/11/22.
//

import UIKit

extension UIImageView {
    func loadImage(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

class ViewController: UIViewController {

    var personaje : Result!
    @IBOutlet var imgPersonaje: UIImageView!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbSpecie: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imgPersonaje.loadImage(URLAddress: personaje.image)
        lbName.text = personaje.name
    }


}

