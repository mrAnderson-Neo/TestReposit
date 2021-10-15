//
//  VK_ViewController.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 29.09.2021.
//

import UIKit
import WebKit
import RealmSwift

class VK_ViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    @IBOutlet weak var buttonStartOfRequest: UIButton!
    @IBOutlet weak var buttonTestRealm: UIButton!
    
    var showTabBarFriends = false
    var showTabBarGroups = false
    
    var urlComponents = URLComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonStartOfRequest.addTarget(self, action: #selector(pressButtonStartOfRequest(_:)), for: .touchUpInside)
        buttonTestRealm.addTarget(self, action: #selector(pressButtonTestRealm(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
//        guard let token = DataStorage.dataStorage.token,
//        let userId = DataStorage.dataStorage.userId else {
//            return
//        }
        
        //var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7961571"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token")
            //URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webview.load(request)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func pressButtonTestRealm(_ sender: UIButton) {
        //UserApi.testRealm()
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let dataUsers = realm.objects(User.self)
            for usr in dataUsers {
                print(usr.idUser, usr.name)
            }
        } catch {
            print(error)
        }
    }
    
    @objc func pressButtonStartOfRequest(_ sender: UIButton) {
        
        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = myStoryboard.instantiateViewController(withIdentifier: "TabBarControllerFriendsAndGroups")
        
        navigationController?.pushViewController(editScreen, animated: true)
        
//        var arr = [User]()
//
//        var usr = User(name: "Ivan", age: 1)
//        usr.idForBase = 1
//        arr.append(usr)
//
//        usr = User(name: "Petya", age: 1)
//        usr.idForBase = 2
//        arr.append(usr)
//
//        do {
//            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//            let realm = try Realm(configuration: configuration)
//            realm.beginWrite()
//            realm.add(arr)
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
        
        // заполнить друзей
//        let closure: (Data?, URLResponse?, Error?) -> Void = { [weak self] data, response, error in
//            guard let data = data else { return }
//
//            do {
//                let usersData = try JSONDecoder().decode(UserForApi.self, from: data)
//                var arrUsers = [User]()
//                for user in usersData.response.items {
//                    if DataStorage.dataStorage.arrayUsers.contains(where: {usr in user.userId == usr.idUser}) {
//                        continue
//                    }
//
//
//
//                    let creatUser = User(name: user.name, age: 1, idUser: user.userId)
//                    creatUser.idForBase = Int(user.userId)
//
//                    DataStorage.dataStorage.arrayUsers.append(creatUser)
//                    arrUsers.append(creatUser)
//                }
//                self?.showTabBarFriends.toggle()
//                do {
//                    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//                    let realm = try Realm(configuration: configuration)
//                    print(realm.configuration.fileURL)
//                    realm.beginWrite()
////                    let newUsr = User(name: "Test", age: 12)
////                    newUsr.idForBase = 123
//                    realm.add(arrUsers, update: .all)
//                    try realm.commitWrite()
//                } catch {
//                    print(error)
//                }
//            } catch {
//                print(error)
//            }
//        }
//        let dictionary = ["user_ids": DataStorage.dataStorage.userId!, "access_token": DataStorage.dataStorage.token!,
//                          "fields": "first_name", "v": "5.131"]
//        loadFriends(scheme: "https", host: "api.vk.com", path: "/method/friends.get", queryItems: dictionary,
//                closure: closure)
//
//        // заполнить группы
//        loadGroups()
//
//
//        while !showTabBarFriends || !showTabBarGroups {}
//
//        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let editScreen = myStoryboard.instantiateViewController(withIdentifier: "TabBarControllerFriendsAndGroups")
//
//        navigationController?.pushViewController(editScreen, animated: true)
    }
    
    func loadFriends(scheme: String, host: String, path: String, queryItems: [String: String],
                 closure: @escaping (Data?, URLResponse?, Error?) -> Void) {
        //var urlComponents = URLComponents()
        urlComponents.scheme = scheme//"https"
        urlComponents.host = host//"api.vk.com"
        urlComponents.path = path//"/method/groups.get"
        var arrURLQuery = Array<URLQueryItem>()
        for (key, value) in queryItems {
            arrURLQuery.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = arrURLQuery
        
        guard let url = urlComponents.url else { return }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url, completionHandler: closure)
        
        return task.resume()
    }
    
    func loadGroups(){
        //scheme: String, host: String, path: String, queryItems: [String: String],
          //       closure: @escaping (Data?, URLResponse?, Error?) -> Void) {
        //var urlComponents = URLComponents()
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
            self.showTabBarGroups.toggle()
        }
        
        task.resume()
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

extension VK_ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
        let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
                    .components(separatedBy: "&")
                    .map { $0.components(separatedBy: "=") }
                    .reduce([String: String]()) { result, param in
                        var dict = result
                        let key = param[0]
                        let value = param[1]
                        dict[key] = value
                        return dict
                }
        
        let token = params["access_token"]
        
        DataStorage.dataStorage.token = token
        
        //print(token)
        
        decisionHandler(.cancel)
        
        
        return
    }
}
