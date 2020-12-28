//
//  UniversityPhotosInteractor.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import Foundation


class UniversityPhotosInteractor {
    weak var view: UniversityPhotos!
    
    func initView() {
        PhotoGridService.shared.fetchPhotos { photos in
            self.view?.photos = photos
        }
    }
}
