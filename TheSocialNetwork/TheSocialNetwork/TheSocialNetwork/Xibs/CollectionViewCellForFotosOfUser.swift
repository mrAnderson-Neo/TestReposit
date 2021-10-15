//
//  CollectionViewCellForFotosOfUser.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 09.09.2021.
//

import UIKit

class CollectionViewCellForFotosOfUser: UICollectionViewCell {

    @IBOutlet var imageViewFoto: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var counterLabel: UILabel!
    
    var imageViewHeart: UIImageView!
    var imageViewHeartFill: UIImageView!
    
    var isLike = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupImageLikes()
        likeButton.tintColor = .clear
        likeButton.addTarget(self, action: #selector(pressLikeButton(_:)), for: .touchUpInside)
        clear()
    }
    
    @objc func pressLikeButton(_ sender: UIButton) {
        isLike.toggle()
        
        if isLike {
            UIView.transition(from: imageViewHeart, to: imageViewHeartFill, duration: 0.5,
                              options: .transitionFlipFromLeft, completion: nil)
            if let numb = Int(counterLabel.text ?? "0") {
                counterLabel.text = String(numb + 1)
            }
        } else {
            UIView.transition(from: imageViewHeartFill, to: imageViewHeart, duration: 0.5,
                              options: .transitionFlipFromRight, completion: nil)
            if let numb = Int(counterLabel.text ?? "0") {
                counterLabel.text = String(numb - 1)
            }
        }
    }
    
    private func setupImageLikes() {
        let width = likeButton.bounds.width
        let height = likeButton.bounds.height
        
        imageViewHeart = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewHeart.image = UIImage(systemName: "heart")
        //imageViewHeart.backgroundColor = .blue
        imageViewHeart.tintColor = .systemPink
        
        imageViewHeartFill = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewHeartFill.image = UIImage(systemName: "heart.fill")
        imageViewHeartFill.tintColor = .systemPink
        
        likeButton.addSubview(imageViewHeart)
    }
    
    func configure(imageFoto image: UIImage?, numb: Int) {
        imageViewFoto.image = image
        
//        if numb%2 == 0 {
//            imageViewFoto.constraints[0].constant += 100
//            imageViewFoto.constraints[1].constant += 100
//        }
        
        //imageViewFoto.siz
    }
    
    override func prepareForReuse() {
        clear()
    }
    
    

    private func clear() {
        imageViewFoto.image = nil
    }
    
    //@objc func pressLi
}
