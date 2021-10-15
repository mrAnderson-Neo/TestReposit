//
//  ViewControllerAllGroups.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 14.09.2021.
//

import UIKit

class ViewControllerAllGroups: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var groupsThatHaveAUser = [ProtocolGroup]()
    var arrGroups = [ProtocolGroup]()
    
    var completionHandler: (([ProtocolGroup]) -> Void)?
    
    let resueXibCell = "TableViewCell"
    
    override func loadView() {
        super.loadView()
        DataStorage.dataStorage.subj.addObserver(observer: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //arrGroups = DataStorage.dataStorage.arrayAllGroup
        
        tableView.register(UINib(nibName: resueXibCell, bundle: nil), forCellReuseIdentifier: resueXibCell)
        // Do any additional setup after loading the view.
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
        //scheme: String, host: String, path: String, queryItems: [String: String],
          //       closure: @escaping (Data?, URLResponse?, Error?) -> Void) {
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
                    DataStorage.dataStorage.arrayGroups.append(Group(name: group.name, avatar: nil))
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
    }

}


// MARK: - DELEGATE
extension ViewControllerAllGroups: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGroup = arrGroups[indexPath.row]
        if groupsThatHaveAUser.contains(where: {(groupWithArr) -> Bool in groupWithArr.name == selectedGroup.name}) {
            let alert = UIAlertController(title: "Предупреждение", message: "Данная группа уже используется",
                                          preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(buttonOk)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let arr = [selectedGroup]
        completionHandler?(arr)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - DATASOURCE
extension ViewControllerAllGroups: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resueXibCell) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let group = arrGroups[indexPath.row]
        
        cell.configure(textName: group.name, avatar: group.avatar, changeLabelAge: 0)
        
        return cell
    }
    
}


// MARK: - OBSERVER
extension ViewControllerAllGroups: Observer {
    func update(subject: Any) {
        guard let sub = subject as? Subject, sub.typeOfDownload == .groups else {
            return
        }
        arrGroups = DataStorage.dataStorage.arrayAllGroup
        self.tableView.reloadData()
    }
}
