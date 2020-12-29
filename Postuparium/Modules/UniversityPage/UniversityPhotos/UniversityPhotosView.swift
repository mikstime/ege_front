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
    var heightConstraint: NSLayoutConstraint! {
        didSet {
            defaultHeight = heightConstraint.constant
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
    var firstPhoto: OnePhoto!
    var secondPhoto: TwoPhotos!
    var thirdPhoto: OnePhoto!
    var forthPhoto: TwoPhotos!
    var fifthPhoto: OnePhoto!
    var morePhotos: MorePhotos!
    private var defaultHeight: CGFloat = 273;
    func initPhotos() {
//        container.subviews.forEach { $0.removeFromSuperview() }
        containerWidth.constant = 0

        if photos.count == 0 {
            heightConstraint?.constant = 0
            container.layer.masksToBounds = true
        } else {
            container.layer.masksToBounds = false
            heightConstraint?.constant = defaultHeight
        }
        if photos.count < 8 && morePhotos != nil {
            morePhotos.removeFromSuperview()
            morePhotos = nil
        }
        if photos.count < 7 && fifthPhoto != nil {
            fifthPhoto.removeFromSuperview()
            fifthPhoto = nil
        }
        if photos.count < 6 && forthPhoto != nil {
            forthPhoto.sImage.image = nil
            forthPhoto.sPhotoContainer.alpha = 0
        }
        if photos.count < 5 && forthPhoto != nil {
            forthPhoto.removeFromSuperview()
            forthPhoto = nil
        }
        if photos.count < 4 && thirdPhoto != nil {
            thirdPhoto.removeFromSuperview()
            thirdPhoto = nil
        }
        if photos.count < 3 && secondPhoto != nil {
            secondPhoto.sImage.image = nil
            secondPhoto.sPhotoContainer.alpha = 0
        }
        if photos.count < 2 && secondPhoto != nil {
            secondPhoto.removeFromSuperview()
            secondPhoto = nil
        }
        if photos.count < 2 && firstPhoto != nil {
            firstPhoto.removeFromSuperview()
            firstPhoto = nil
        }
        if photos.count >= 1 {
            if firstPhoto == nil  {
                let photo = OnePhoto()
                photo.dispatcher = dispatcher
                container.addSubview(photo)
                NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                firstPhoto = photo
            }
            firstPhoto.setImage(from: photos[0])
            containerWidth.constant += 134
            
            if photos.count >= 2 {
                if secondPhoto == nil {
                    let photo = TwoPhotos()
                    photo.dispatcher = dispatcher
                    container.addSubview(photo)
                    NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: firstPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                    NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                    NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                    secondPhoto = photo
                }
                secondPhoto.setFirstImage(from: photos[1])
                if photos.count >= 3 {
                    secondPhoto.setSecondImage(from: photos[2])
                }
                containerWidth.constant += 110 + 17
                
                if photos.count >= 4 {
                    if thirdPhoto == nil {
                        let photo = OnePhoto()
                        photo.dispatcher = dispatcher
                        container.addSubview(photo)
                        NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: secondPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                        NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                        NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: secondPhoto, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                        thirdPhoto = photo
                    }
                    thirdPhoto.setImage(from: photos[3])
                    containerWidth.constant += 134 + 17
                    
                    if photos.count >= 5 {
                        if forthPhoto == nil {
                            let photo = TwoPhotos()
                            photo.dispatcher = dispatcher
                            container.addSubview(photo)
                            NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: thirdPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                            NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                            NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                            forthPhoto = photo
                        }
                        forthPhoto.setFirstImage(from: photos[4])
                        if photos.count >= 6 {
                            forthPhoto.setSecondImage(from: photos[5])
                        }
                        
                        
                        containerWidth.constant += 110 + 17
                        
                        if photos.count >= 7 {
                            if fifthPhoto == nil {
                                let photo = OnePhoto()
                                photo.dispatcher = dispatcher
                                container.addSubview(photo)
                                NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: forthPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                                NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                                NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: secondPhoto, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                                fifthPhoto = photo
                            }
                            fifthPhoto.setImage(from: photos[6])
                            containerWidth.constant += 134 + 17
                            
                            if photos.count >= 8 {
                                if morePhotos == nil {
                                    let photo = MorePhotos()
                                    photo.dispatcher = dispatcher
                                    container.addSubview(photo)
                                    NSLayoutConstraint.init(item: photo, attribute: .leading, relatedBy: .equal, toItem: fifthPhoto, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
                                    NSLayoutConstraint.init(item: photo, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
                                    NSLayoutConstraint.init(item: photo, attribute: .bottom, relatedBy: .equal, toItem: secondPhoto, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                                    morePhotos = photo
                                }
                                morePhotos.setImage(from: photos[7])
                                containerWidth.constant += 108 + 17
                            }
                        }
                    }
                }
            }
        }
    }
}
