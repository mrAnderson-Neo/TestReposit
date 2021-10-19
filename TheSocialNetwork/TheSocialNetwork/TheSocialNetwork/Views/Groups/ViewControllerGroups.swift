//
//  ViewControllerGroups.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 13.09.2021.
//

import UIKit
import RealmSwift

class ViewControllerGroups: UIViewController {
    
    var arrayGroups = [ProtocolGroup]()
    @IBOutlet var buttonAllgroups: UIBarButtonItem!
    @IBOutlet var buttonUpdateRealm: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    
    let resueSegue = "fromGroupsToAllGroups"
    
    //var handler: (([ProtocolGroup]) -> Void)?
    
    let resueXibCell = "TableViewCell"
    
    
    var shouldUpdateRealm = false

    override func loadView() {
        super.loadView()
        DataStorage.dataStorage.subj.addObserver(observer: self)
        loadGroups()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //arrayGroups = DataStorage.dataStorage.arrayGroups

        self.tableView.register(UINib(nibName: resueXibCell, bundle: nil), forCellReuseIdentifier: resueXibCell)
        
        //buttonAllgroups.add
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pressUpdateRealm(_ sender: Any) {
        loadGroupsFromApi()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case resueSegue:
            if let editScreen = segue.destination as? ViewControllerAllGroups {
                editScreen.groupsThatHaveAUser = arrayGroups
                editScreen.completionHandler = { [weak self] arrGroups in
                    self?.arrayGroups.append(arrGroups[0])
                    self?.tableView.reloadData()
                }
            }
        default:
            break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - API
    func loadGroups(){
        loadGroupsFromDataBase()
        
        if !DataStorage.dataStorage.arrayGroups.isEmpty {
            return
        }
        
        loadGroupsFromApi()
    }
    
    func loadGroupsFromApi() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: DataStorage.dataStorage.userId),
            URLQueryItem(name: "access_token", value: DataStorage.dataStorage.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        var loadingEnded = false
        
        let congiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: congiguration)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            do {
                let groupsData = try JSONDecoder().decode(GroupResponse.self, from: data)
                for group in groupsData.response.items {
                    if DataStorage.dataStorage.arrayGroups.contains(where: {grp in group.name == grp.name}) {
                        continue
                    }
                    DataStorage.dataStorage.arrayGroups.append(Group(name: group.name, id: group.id))
                }
            } catch {
                print(error)
            }
            loadingEnded.toggle()
        }
        
        task.resume()
        
        while !loadingEnded { }
        
        DataStorage.dataStorage.subj.launchDownloads(.groups)
        DataStorage.dataStorage.subj.removeObserver(observer: self)
        
        if shouldUpdateRealm {
            updateDataForRealm()
        }
    }
    
    func updateDataForRealm() {
        guard let arrGrp = DataStorage.dataStorage.arrayGroups as? [Group] else { return }

        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            realm.beginWrite()
            realm.add(arrGrp, update: .all)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadGroupsFromDataBase() {
        DataStorage.dataStorage.arrayGroups.removeAll()
        do {
            let realm = try Realm()
            let data = realm.objects(Group.self)
            for grp in data {
                DataStorage.dataStorage.arrayGroups.append(Group(name: grp.name, id: grp.id))
            }
        } catch {
            //shouldUpdateRealm = true
            print(error)
            return
        }
        
        shouldUpdateRealm = DataStorage.dataStorage.arrayGroups.isEmpty
        
        DataStorage.dataStorage.subj.launchDownloads(.groups)
    }

}


// MARK: - DELEGATE
extension ViewControllerGroups: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - DATASOURCE
extension ViewControllerGroups: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resueXibCell) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let foundGroup = arrayGroups[indexPath.row]
        
        cell.configure(textName: foundGroup.name, avatar: foundGroup.avatar, changeLabelAge: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}



// MARK: - OBSERVER
extension ViewControllerGroups: Observer {
    func update(subject: Any) {
        guard let sub = subject as? Subject, sub.typeOfDownload == .groups else {
            return
        }
        arrayGroups = DataStorage.dataStorage.arrayGroups
        self.tableView.reloadData()
    }
}
