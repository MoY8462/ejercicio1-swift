//
//  TableViewController.swift
//  Ejercicio1
//
//  Created by DISMOV on 10/11/22.
//

import UIKit
import Network

extension UIImageView {
    func imgCell(URLAddress: String) {
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

class TableViewController: UITableViewController {
    var personajes = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if NetworkMonitor.shared.isConnected {
            print("Conectado")
            
        }
        else {
            print("Sin conexión")
            showSimpleAlert()
        }

        if let url=URL(string: "https://rickandmortyapi.com/api/character/") {
            do {
                let bytes = try Data(contentsOf: url)
                let rick = try JSONDecoder().decode(Rick.self, from: bytes)
                personajes = rick.results
            }
            catch {
            }
        }
        title = "Rick and Morty"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personajes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let personaje = personajes[indexPath.row]
        cell.textLabel?.text = personaje.name
        cell.imageView?.imgCell(URLAddress: personaje.image)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ViewController
        
        let indice = tableView.indexPathForSelectedRow!
        
        viewController.personaje = personajes[indice.row]
    }
    
    func showSimpleAlert() {
            let alert = UIAlertController(title: "Error", message: "Error al obtener información. Verifica tu conexión a internet",         preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                //Cancel Action
            }))
            self.present(alert, animated: true, completion: nil)
        }    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
