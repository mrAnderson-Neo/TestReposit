//
//  ViewControllerPhoto.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 30.09.2021.
//

import UIKit

class ViewControllerPhoto: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let resueXibCell = "TableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNibType = UINib(nibName: resueXibCell, bundle: nil)
        tableView.register(cellNibType, forCellReuseIdentifier: resueXibCell)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}


// MARK: - DELEGATE
extension ViewControllerPhoto: UITableViewDelegate {
    
}

// MARK: - DATASOURCE
extension ViewControllerPhoto: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataStorage.dataStorage.arrayPhoto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resueXibCell) as? TableViewCell else {
            return UITableViewCell()
        }
        let photo = DataStorage.dataStorage.arrayPhoto[indexPath.row]
        cell.configure(textName: photo, avatar: nil, changeLabelAge: 0)
        
        return cell
    }
    
    
    
}
