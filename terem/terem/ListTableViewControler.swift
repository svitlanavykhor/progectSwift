//
//  ListTableViewControler.swift
//  terem
//
//  Created by svitlana vykhor on 30/01/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit


class ListTableViewControler: UITableViewController {
    var formatter: DateFormatter = DateFormatter()
    var teams: [String] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teams = ["us"]
       
        
        self.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototipCell", for: indexPath)as! PrototipoTableViewCell

        cell.Titulo?.text = data[indexPath.row].title
        if (data[indexPath.row].mag != nil) {
            cell.magnitud.text = String(format:"%.2f", data[indexPath.row].mag!)
        } else {
            cell.magnitud.text = ""
        }
        if (data[indexPath.row].date != nil) {
            cell.fecha.text = self.formatter.string(from: data[indexPath.row].date!)
        } else {
            cell.fecha.text = ""
        }
       
        cell.imagen.image = UIImage(named: (data[indexPath.row].pais ?? "us").lowercased())
            
        
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "detailMap") as! detailMapViewController
        NSLog("\(data[indexPath.row])")
        destination.set(g: data[indexPath.row])
        navigationController?.pushViewController(destination, animated: true)
    }
    
    


    /*
     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

