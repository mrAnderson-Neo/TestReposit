//
//  ViewControllerForFotosFriends.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 09.09.2021.
//

import UIKit

protocol ProtocolCollectionFotoUsers {
    var arrayFotos: [UIImage]? { get set }
}

class ViewControllerForFotosFriends: UIViewController, ProtocolCollectionFotoUsers {
    var arrayFotos: [UIImage]?
    
    @IBOutlet var collectionView: UICollectionView!
    
    let resueXibCell = "CollectionViewCellForFotosOfUser"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: resueXibCell, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: resueXibCell)
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


extension ViewControllerForFotosFriends: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("1")
        let viewControllerBigFoto = UIViewController()
        let mainView = UIView()
        mainView.backgroundColor = .white
        viewControllerBigFoto.view = mainView
        let imageViewController = UIImageView(frame: CGRect(x: 0, y: 50, width: 200, height: 200))
        mainView.addSubview(imageViewController)
        imageViewController.image = arrayFotos?[indexPath.item]
        
        self.navigationController?.pushViewController(viewControllerBigFoto, animated: true)
    }
}

extension ViewControllerForFotosFriends: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: 150, height: 200)
//    }
    
}

extension ViewControllerForFotosFriends: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let arrFotos = arrayFotos else {
            return 0
        }
        return arrFotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let arrFotos = arrayFotos,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resueXibCell, for: indexPath)
                  as? CollectionViewCellForFotosOfUser else {
            return UICollectionViewCell()
        }
        
        cell.configure(imageFoto: arrFotos[indexPath.item], numb: indexPath.item)
        
        return cell
    }
    
}
