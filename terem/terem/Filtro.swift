//
//  Filtro.swift
//  terem
//
//  Created by svitlana vykhor on 09/02/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import Foundation
import UIKit

class FiltroCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Here you can customize the appearance of your cell
    override func layoutSubviews() {
        super.layoutSubviews()
        // Customize imageView like you need
        self.imageView?.frame = CGRect(x: 10, y: 0, width: 40, height: 35)
        self.imageView?.contentMode = .scaleAspectFit
        // Costomize other elements
        self.textLabel?.frame = CGRect(x: 60, y: 0, width: self.frame.width - 45, height: 20)
        self.detailTextLabel?.frame = CGRect(x: 60, y: 20, width: self.frame.width - 45, height: 15)
    }
}

class FiltroTable: UITableViewController {
    @IBAction func aplicar(_ sender: Any) {
        data.removeAll()
        
        for i in infoArray {
            if i.show() {
                data.append(i)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(FiltroCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return CategoriaMag.count
        } else {
            return Pais.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Magnitud"
        } else {
            return "Pais"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var sel = true
        if indexPath.section == 0 {
            CategoriaMag[indexPath.row].selected = !CategoriaMag[indexPath.row].selected
            sel = CategoriaMag[indexPath.row].selected
        } else {
            Pais[indexPath.row].selected = !Pais[indexPath.row].selected
            sel = Pais[indexPath.row].selected
        }
        
        if(sel == false) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = CategoriaMag[indexPath.row].title
            cell.imageView?.image = UIImage()
            if(CategoriaMag[indexPath.row].selected) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            cell.textLabel?.text = Pais[indexPath.row].title
            cell.imageView?.image = UIImage()
            let img = UIImage(named: Pais[indexPath.row].title.lowercased())
            if(img != nil) {
                cell.imageView?.image = img
            }
            cell.imageView?.frame = CGRect(x: 5, y: 5, width: 30, height: 20)
            if(Pais[indexPath.row].selected) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    
}
