//
//  ViewControllerMethodsGets.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 29.09.2021.
//

import UIKit

class ViewControllerMethodsGets: UIViewController {
    
    @IBOutlet weak var buttonGetFriends: UIButton!
    @IBOutlet weak var buttonGetGroups: UIButton!
    @IBOutlet weak var buttonGetPhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonGetFriends.addTarget(self, action: #selector(pressGetFriends(_:)), for: .touchUpInside)
        buttonGetGroups.addTarget(self, action: #selector(pressButtonGetGroups(_:)), for: .touchUpInside)
        buttonGetPhoto.addTarget(self, action: #selector(pressGetPhotos(_:)), for: .touchUpInside)
    }
    
    @objc func pressGetFriends(_ sender: UIButton) {
        //https://api.vk.com/method/friends.get?user_ids=138271117&fields=bdate&access_token=f0247676c79ac2869a3256d9d1d01d92960019aeacc1e73f47624e0b13e97e71ee180c1902c6e1e819eec&v=5.131
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: DataStorage.dataStorage.userId),
            URLQueryItem(name: "access_token", value: DataStorage.dataStorage.token),
            URLQueryItem(name: "fields", value: "first_name"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        let congiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: congiguration)
        
        var openListFriends = false
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            do {
                let dataUsers = try JSONDecoder().decode(UserForApi.self, from: data)
                for user in dataUsers.response.items {
                    if DataStorage.dataStorage.arrayUsers.contains(where: { usr in
                        usr.idUser == user.userId
                    }){
                        continue
                    }
                    DataStorage.dataStorage.arrayUsers.append(User(name: user.name, age: 1, idUser: user.userId))
                }
            } catch {
                print(error)
            }
            
//            let json = try? JSONSerialization.jsonObject(with: data,
//                                                         options: JSONSerialization.ReadingOptions.mutableContainers)
//            let myData = json as! [String: Any]
//            let response = myData["response"] as! [String: Any]
//            let array = response["items"] as! [Any]
//
//            for user in array {
//                let objUser = user as! [String: Any]
//
//                let name = objUser["first_name"] as! String
//                let id = objUser["id"] as! Int64
//
//                DataStorage.dataStorage.arrayUsers.append(User(name: name, age: 1, idUser: id))
//            }
            
            
            //print(name)
            openListFriends = true
        }
        
        task.resume()
        //try await task
        
        while !openListFriends {
            
        }
        
        let strb = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = strb.instantiateViewController(withIdentifier: "ViewControllerOfFriends")
        
        self.navigationController?.pushViewController(editScreen, animated: true)
        
    }
    
    
    @objc func pressButtonGetGroups(_ sender: UIButton) {
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
        
        let congiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: congiguration)
        
        var openListFriends = false
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            do {
                let groupsData = try JSONDecoder().decode(GroupResponse.self, from: data)
                for group in groupsData.response.items {
                    if DataStorage.dataStorage.arrayAllGroup.contains(where: {grp in group.name == grp.name}) {
                        continue
                    }
                    DataStorage.dataStorage.arrayAllGroup.append(Group(name: group.name, avatar: nil))
                }
            } catch {
                print(error)
            }
            
//            let json = try? JSONSerialization.jsonObject(with: data,
//                                                         options: JSONSerialization.ReadingOptions.mutableContainers)
//            let myData = json as! [String: Any]
//            let response = myData["response"] as! [String: Any]
//            let array = response["items"] as! [Any]
//
//            for group in array {
//                let objGroup = group as! [String: Any]
//
//                let name = objGroup["name"] as! String
//                //let id = String(group as! Int64)
//
//                DataStorage.dataStorage.arrayAllGroup.append(Group(name: name, avatar: nil))
//            }
            
            
            //print(name)
            openListFriends = true
        }
        
        task.resume()
        
        while !openListFriends {
            
        }
        
        let strb = UIStoryboard(name: "Main", bundle: nil)
        let editStreen = strb.instantiateViewController(identifier: "ViewControllerOfAllGroups")
        
        self.navigationController?.pushViewController(editStreen, animated: true)
    }
    
    @objc func pressGetPhotos(_ sender: UIButton) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "-\(DataStorage.dataStorage.userId!)"),
            URLQueryItem(name: "access_token", value: DataStorage.dataStorage.token),
            //URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        let congiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: congiguration)
        
        var openListFriends = false
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data,
                                                         options: JSONSerialization.ReadingOptions.mutableContainers)
            let myData = json as! [String: Any]
            let response = myData["response"] as! [String: Any]
            let array = response["items"] as! [Any]
            
            for photo in array {
                let objPhoto = photo as! [String: Any]
                
                //let name = objGroup["name"] as! String
                //let id = String(objPhoto["id"] as! Int64)
                
                let listPhotos = objPhoto["sizes"] as! [Any]
                
                for ph in listPhotos {
                    let objResult = ph as! [String: Any]
                    DataStorage.dataStorage.arrayPhoto.append((objResult["url"] as! String))
                }
                
                
            }
            
            
            //print(name)
            openListFriends = true
        }
        
        task.resume()
        
        while !openListFriends {
            
        }
        
        let strb = UIStoryboard(name: "Main", bundle: nil)
        let editStreen = strb.instantiateViewController(identifier: "ViewControllerPhoto")
        
        self.navigationController?.pushViewController(editStreen, animated: true)
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
