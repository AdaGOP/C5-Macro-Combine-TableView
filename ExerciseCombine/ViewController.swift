//
//  ViewController.swift
//  ExerciseCombine
//
//  Created by Athoya on 29/08/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var menus: [String] = []
    var filteredMenus: [String] = []
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // 1. Buat dulu kita variable subjectnya
    var searchText: CurrentValueSubject<String,Never> = CurrentValueSubject("")
    
    // 2. Kita buat variable cancellabe, kalo misal subject ga dipake kita bisa buang dari memory
    var subsciprions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menus = AvaliableMenu().list
        filteredMenus = menus
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
//
//         3. Kasih subscription dan behaviour kalo ada data berubah gimana
//                searchText.sink { value in
//                    self.filteredMenus = self.menus.filter({ item in
//                        item.lowercased().contains(self.searchTextField.text?.lowercased() ?? "")
//                    })
//                    self.menuTableView.reloadData()
//                }.store(in: &subsciprions)
        
        // 5. Coba operasi operasi data stream
        searchText
            .dropFirst()
            .filter({ value in
                value.count >= 3
            })
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .sink { value in
            self.filteredMenus = self.menus.filter({ item in
                item.lowercased().contains(self.searchTextField.text?.lowercased() ?? "")
            })
            self.menuTableView.reloadData()
        }.store(in: &subsciprions)
        
//        let textOnChange = NotificationCenter.default
//            .publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
//            .sink { value in
//                self.filteredMenus = self.menus.filter({ item in
//                    item.lowercased().contains(self.searchTextField.text?.lowercased() ?? "")
//                })
//                self.menuTableView.reloadData()
//        }.store(in: &subsciprions)
    }
    
    @IBAction func searchOnValueChanged(_ sender: Any) {
        print(searchTextField.text)
        
        // 4. Tambah data stream ke subject kita
        searchText.send(searchTextField.text ?? "")
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
