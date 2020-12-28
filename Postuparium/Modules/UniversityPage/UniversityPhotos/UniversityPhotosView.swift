//
//  UniversityPhotoView.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import UIKit

protocol UniversityPhotoDispatcher: class {
    func didTapOnPhoto(photo: UIImage)
    func didTapOnMore()
}
class UniversityPhotos: UIView {
    var university: University! {
        didSet {
            photos = []
            interactor.initView()
        }
    }
    weak var dispatcher: UniversityPhotoDispatcher! {
        didSet {
            initPhotos()
        }
    }
    var interactor = UniversityPhotosInteractor()
    var photos: [UIImage] = [] {
        didSet {
            initPhotos()
        }
    }
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var container: UIStackView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }

    func _init() {
        fromNib()
        initPhotos()
        interactor.view = self
        interactor.initView()
        layoutIfNeeded()
    }
    
    func initPhotos() {
        container.subviews.forEach { $0.removeFromSuperview() }
        containerWidth.constant = 0
        let firstPhoto: OnePhoto!
        let secondPhoto: TwoPhotos!
        let thirdPhoto: OnePhoto!
        let forthPhoto: TwoPhotos!
        let fifthPhoto: OnePhoto!
        if photos.count == 0 {
            
        }
        if photos.count >= 1 {
            let photo = OnePhoto()
            photo.dispatcher = dispatcher
            photo.setImage(from: photos[0])
            container.addSubview(photo)
            NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            firstPhoto = photo
            
            containerWidth.constant += 134
            
            if photos.count >= 2 {
                let photo = TwoPhotos()
                photo.dispatcher = dispatcher
                photo.setFirstImage(from: photos[1])
                container.addSubview(photo)
                NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: firstPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                
                if photos.count >= 3 {
                    photo.setSecondImage(from: photos[2])
                }
                secondPhoto = photo
                
                containerWidth.constant += 110 + 17
                
                if photos.count >= 4 {
                    let photo = OnePhoto()
                    photo.dispatcher = dispatcher
                    photo.setImage(from: photos[3])
                    container.addSubview(photo)
                    NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: secondPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                    NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                    NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: secondPhoto, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                    thirdPhoto = photo
                    
                    containerWidth.constant += 134 + 17
                    
                    if photos.count >= 5 {
                        let photo = TwoPhotos()
                        photo.dispatcher = dispatcher
                        photo.setFirstImage(from: photos[4])
                        container.addSubview(photo)
                        NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: thirdPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                        NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                        NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                        
                        if photos.count >= 6 {
                            photo.setSecondImage(from: photos[5])
                        }
                        
                        forthPhoto = photo
                        
                        containerWidth.constant += 110 + 17
                        
                        if photos.count >= 7 {
                            let photo = OnePhoto()
                            photo.dispatcher = dispatcher
                            photo.setImage(from: photos[6])
                            container.addSubview(photo)
                            NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: forthPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                            NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                            NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: secondPhoto, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                            fifthPhoto = photo
                            
                            containerWidth.constant += 134 + 17
                            
                            if photos.count >= 8 {
                                let photo = MorePhotos()
                                photo.dispatcher = dispatcher
                                photo.setImage(from: photos[7])
                                container.addSubview(photo)
                                NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: fifthPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                                NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                                NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: secondPhoto, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                                
                                containerWidth.constant += 108 + 17
                            }
                        }
                    }
                }
            }
        }
    }
}
