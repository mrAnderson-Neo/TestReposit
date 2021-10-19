//
//  ViewControllerFriends.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 03.09.2021.
//

import UIKit
import RealmSwift

class ViewControllerFriends: UIViewController {
    
    //let dataStorage = DataStorage.dataStorage
    
    @IBOutlet var buttonUpdateRealm: UIBarButtonItem!
    @IBOutlet var buttonAddUser: UIBarButtonItem!
    
    let resueViewForFotos = "resueViewForFotos"
    
    let alhabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t","u", "v", "w", "x", "y", "z", "а", "б", "в", "г", "д", "е", "ё", "к", "л", "м", "н", "о", "п", "р","с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я", "ж", "з", "и", "й"]
    
    typealias typeStringUser = (symbol: String, user: [Object])
    
    var arraySectionsOfUsers: [typeStringUser] = [typeStringUser]()
    var allUsers: [Object]!
    var usersFromRealm: Results<User>?
    
    var shouldUpdateRealm = false
    
    var token: NotificationToken?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let resueXibCell = "TableViewCell"
    
    override func loadView() {
        super.loadView()
        DataStorage.dataStorage.subj.addObserver(observer: self)
        loadFriends()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNibType = UINib(nibName: resueXibCell, bundle: nil)
        tableView.register(cellNibType, forCellReuseIdentifier: resueXibCell)
        
//        allUsers = DataStorage.dataStorage.arrayUsers
//
//        fillTheUsers()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pressUpdateRealm(_ sender: Any) {
        loadUsersFromAPI()
    }
    
    @IBAction func pressAddUser(_ sender: Any) {
        let alert = UIAlertController(title: "Добавление пользователя", message: "Добавте нового пользователя", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addTextField(configurationHandler: nil)
        
        alert.textFields?[0].placeholder = "name"
        alert.textFields?[1].placeholder = "id"
        
        let buttonAdd = UIAlertAction(title: "Add user", style: .default) { [weak self] _ in
            let name = alert.textFields?[0].text ?? ""
            let id = alert.textFields?[1].text ?? ""
            
            guard let id = Int(id) else { return }
            
            self?.addUser(name: name, id: id)
        }
        
        let buttonCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(buttonAdd)
        alert.addAction(buttonCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func addUser(name: String, id: Int) {
            let newUsr = User(name: name, age: 1, idUser: id)
            //newCity.name = name
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.add(newUsr, update: .all)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        }

    
    private func fillTheUsers() {
        arraySectionsOfUsers.removeAll()
        for symbol in alhabet {
            var usrArr = [Object]()
            for user in allUsers.filter({ usr in
                guard let usr = usr as? User,  let symb = usr.name.first?.uppercased() else {
                    return false
                }
                return symbol.uppercased() == symb
            }) {
                usrArr.append(user)
            }
            if usrArr.count == 0 {
                continue
            }
            arraySectionsOfUsers.append((symbol.uppercased(), usrArr))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
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

    func loadFriends() {
        
        loadFriendsFromDataBase()
        
        if !DataStorage.dataStorage.arrayUsers.isEmpty {
            return
        }
        
        loadUsersFromAPI()
        
    }
    
    func loadUsersFromAPI() {
        var loadingEnded = false
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: DataStorage.dataStorage.userId!),
            URLQueryItem(name: "access_token", value: DataStorage.dataStorage.token!),
            URLQueryItem(name: "fields", value: "first_name"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let usersData = try JSONDecoder().decode(UserForApi.self, from: data)
                for user in usersData.response.items {
                    if DataStorage.dataStorage.arrayUsers.contains(where: {usr in user.userId == usr.idUser}) {
                        continue
                    }
                    let creatUser = User(name: user.name, age: 1, idUser: user.userId)
                    
                    DataStorage.dataStorage.arrayUsers.append(creatUser)
                }
                
                loadingEnded.toggle()
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
        while !loadingEnded { }
        
        DataStorage.dataStorage.subj.launchDownloads(.friends)
        DataStorage.dataStorage.subj.removeObserver(observer: self)
        
        if loadingEnded {
            updateDataForRealm()
        }
    }
    
    func loadFriendsFromDataBase() {
        DataStorage.dataStorage.arrayUsers.removeAll()
        do {
            let realm = try Realm()
            usersFromRealm = realm.objects(User.self)
            
            guard let usersFromRealm = usersFromRealm else {
                return
            }
            
            self.token = usersFromRealm.observe({ [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(let result, let deletions, let insertions, let modifications):
                    tableView.reloadData()
                case .error(let error):
                    print(error)
                }
            })

            
            for usr in usersFromRealm {
                DataStorage.dataStorage.arrayUsers.append(User(name: usr.name, age: 1, idUser: usr.idUser))
            }
        } catch {
            //shouldUpdateRealm = true
            print(error)
            return
        }
        
        shouldUpdateRealm = DataStorage.dataStorage.arrayUsers.isEmpty
        
        DataStorage.dataStorage.subj.launchDownloads(.friends)
    }

    func updateDataForRealm() {
        guard let arrUsr = DataStorage.dataStorage.arrayUsers as? [User] else { return }
        
        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            realm.beginWrite()
            realm.add(arrUsr, update: .all)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}




// MARK: - DELEGATE

extension ViewControllerFriends: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("select \(dataStorage.arrayUsers[indexPath.row].name)")
        //let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let editStreen = myStoryboard.instantiateViewController(identifier: resueViewForFotos) as! ViewControllerForFotosFriends
        
        //editStreen.arrayFotos = arraySectionsOfUsers[indexPath.section].user[indexPath.row].arrayFotos
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userForDel = usersFromRealm?[indexPath.row]
            guard let userForDel = userForDel else { return }
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(userForDel)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        }
    }
    
}

// MARK: - DATASOURCE

extension ViewControllerFriends: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //dataStorage.arrayUsers.count
        usersFromRealm?.count ?? 0//arraySectionsOfUsers[section].user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resueXibCell, for: indexPath) as? TableViewCell
        else {
            return UITableViewCell()
        }
        
        let user = usersFromRealm?[indexPath.row]//arraySectionsOfUsers[indexPath.section].user[indexPath.row]
        
        guard let user = user else {  return UITableViewCell() }
            //dataStorage.arrayUsers[indexPath.row]
        
        cell.configure(textName: user.name, textAge: String(user.idUser), avatar: nil)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1//arraySectionsOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        nil//arraySectionsOfUsers[section].symbol.uppercased()
    }
    
}

// MARK: - SEARCH BAR

extension ViewControllerFriends: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            allUsers = //DataStorage.dataStorage.arrayUsers
//        } else {
//            allUsers = DataStorage.dataStorage.arrayUsers.filter({ usr in
//                usr.name.lowercased().contains(searchText.lowercased())
//            })
//        }
//        fillTheUsers()
//        tableView.reloadData()
    }
}

// MARK: - OBSERVER
extension ViewControllerFriends: Observer {
    func update(subject: Any) {
        guard let sub = subject as? Subject, sub.typeOfDownload == .friends else {
            return
        }
        //allUsers = DataStorage.dataStorage.arrayUsers
        //fillTheUsers()
        self.tableView.reloadData()
    }
}
