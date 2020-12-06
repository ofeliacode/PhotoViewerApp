//
//  CollectionViewCell.swift
//  galleryApp
//
//  Created by Офелия Баширова on 05.12.2020.
//

import Foundation
import UIKit
class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cellIdentifier"
    private var urlStringOfImage: String = ""
    private var urlStringOfAvatar: String = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(userLabel)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(imageAvatar)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(commentsLabel)
        self.contentView.addSubview(likesEmodji)
        self.contentView.addSubview(commentsEmodji)
        self.contentView.addSubview(saveEmodji)
        self.contentView.addSubview(subscribeButton)
        setUpConstraints()
    }
    func setup(_ pic: Hitsdata) {
        updateUI(picture: pic.img, avatar: pic.avatar, likes: pic.likes, comments: pic.comments, user: pic.user)
    }
    
    func getImageFromURL(url: URL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("empty data")
                    return
                }
                guard let data = data else {return}
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.imageView.image = image
                    }
                }
            
            }.resume()
    }
    func getImageFromURLForUser(url: URL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("empty data")
                    return
                }
                guard let data = data else {return}
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.imageAvatar.image = image
                    }
                }
            }.resume()
    }
    func updateUI(picture: String?, avatar: String?, likes: Int?, comments: Int?, user: String?) {
       
        likesLabel.text = likes?.description
        commentsLabel.text = comments?.description
        userLabel.text = user
      
        guard let avatarString = avatar else {return}
        urlStringOfAvatar = avatarString
        
        guard let pictureString = picture else {return}
        urlStringOfImage = pictureString
        
        guard let pictureImageURL = URL(string: urlStringOfImage) else {
        imageView.image = UIImage(named: "no image")
            return
        }
        imageView.image = nil
        getImageFromURL(url: pictureImageURL)
        
        guard let pictureAvatarURL = URL(string: urlStringOfAvatar) else {
        imageAvatar.image = UIImage(named: "no image")
        return
        }
        imageAvatar.image = nil
        getImageFromURLForUser(url: pictureAvatarURL)
    }
    let imageView: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    let imageAvatar: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = CGFloat(15)
        return img
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.systemGray
        return label
    }()
    let likesEmodji: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.tintColor = UIColor.systemGray
        img.image = UIImage(systemName: "face.smiling")
        return img
    }()
    let commentsEmodji: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.tintColor = UIColor.systemGray
        img.image = UIImage(systemName: "message.fill")
        return img
    }()
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.systemGray
        return label
    }()
    let userLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return label
    }()
    
    let saveEmodji: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.tintColor = UIColor.systemGray
        img.image = UIImage(systemName: "arrow.down.to.line.alt")
        return img
    }()
    let subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("subscribe", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        return button
    }()
    
    func setUpConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageAvatar.translatesAutoresizingMaskIntoConstraints = false
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesEmodji.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsEmodji.translatesAutoresizingMaskIntoConstraints = false
        saveEmodji.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likesEmodji.topAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            likesEmodji.heightAnchor.constraint(equalToConstant: 20),
            likesEmodji.widthAnchor.constraint(equalToConstant: 20),
            likesEmodji.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        ])
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            likesLabel.heightAnchor.constraint(equalToConstant: 20),
            likesLabel.widthAnchor.constraint(equalToConstant: 37),
            likesLabel.leadingAnchor.constraint(equalTo: likesEmodji.trailingAnchor, constant: 4),
            
        ])
        NSLayoutConstraint.activate([
            commentsLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            commentsLabel.heightAnchor.constraint(equalToConstant: 20),
            commentsLabel.widthAnchor.constraint(equalToConstant: 27),
            commentsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -47)
        ])
        NSLayoutConstraint.activate([
            commentsEmodji.topAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            commentsEmodji.heightAnchor.constraint(equalToConstant: 20),
            commentsEmodji.widthAnchor.constraint(equalToConstant: 20),
            commentsEmodji.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80)
        ])
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            userLabel.heightAnchor.constraint(equalToConstant: 20),
            userLabel.widthAnchor.constraint(equalToConstant: 30),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
        NSLayoutConstraint.activate([
            subscribeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            subscribeButton.heightAnchor.constraint(equalToConstant: 20),
            subscribeButton.widthAnchor.constraint(equalToConstant: 74),
            subscribeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            imageAvatar.heightAnchor.constraint(equalToConstant: 30),
            imageAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageAvatar.widthAnchor.constraint(equalToConstant: 30),
            imageAvatar.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -15)
            ])
        NSLayoutConstraint.activate([
           imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
           imageView.heightAnchor.constraint(equalToConstant: 330),
           imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
           imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
           imageView.widthAnchor.constraint(equalToConstant: 300)
            ])
        NSLayoutConstraint.activate([
            saveEmodji.topAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            saveEmodji.heightAnchor.constraint(equalToConstant: 20),
            saveEmodji.widthAnchor.constraint(equalToConstant: 20),
            saveEmodji.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

