//
//  ViewController.swift
//  ExerciseCombine
//
//  Created by Athoya on 29/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var menus: [String] = []
    var filteredMenus: [String] = []
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menus = AvaliableMenu().list
        filteredMenus = menus
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    @IBAction func searchOnValueChanged(_ sender: Any) {
        print(searchTextField.text)
        filteredMenus = menus.filter({ item in
            item.lowercased().contains(searchTextField.text?.lowercased() ?? "")
        })
        menuTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = filteredMenus[indexPath.row]
        return cell
    }
    
    
}
