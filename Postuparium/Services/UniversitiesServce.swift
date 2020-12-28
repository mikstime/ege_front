//
//  UniversitiesServce.swift
//  Postuparium
//
//  Created by user on 27.12.2020.
//

import Foundation
import UIKit


protocol UniversitiesServiceProtocol {
    var universities: [University] {get set}
    var fetchedUniversities: [University] {get set}
    func fetchUniversities(callback: @escaping  () -> Void )
    func searchUniversities(query:String, callback: @escaping  () -> Void )
}
// принцип работы. Запрошенные с сервера универы хранятся в fetchedUniversities
// ответ на последний запрос – в universities. Переписывать времени нет.
class UniversitiesService: UniversitiesServiceProtocol{
    
    func searchUniversities(query: String, callback: @escaping () -> Void) {
        self.universities = self.fetchedUniversities.filter { university in
            return university.name.starts(with: query)
        }
        callback()
    }
    
    var universities = [University]()
    var fetchedUniversities = [University]()
    static var shared: UniversitiesServiceProtocol = UniversitiesService()
    
    func fetchUniversities(callback: @escaping  () -> Void ) {
        //  заглушка для подгрузки университетов
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.fetchedUniversities.append(University(scores: 192, place: 52, rating: 5, name: "Мисис", image:"https://polymus.ru/media/cache/57/2e/572e9f269782833f4d32d392c6a346b3.jpg", description: "Средненький вуз"))
            self.fetchedUniversities.append(University(scores: 210, place: 14, rating: 5, name: "МГТУ", image: "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg", description: "Ну вообще, как бы, это – лучший технический вуз страны. В нем еще твой дед учился. На электрика. Или кого-то еще."))
            self.fetchedUniversities.append(University(scores: 270, place: 13, rating: 3.1, name: "МГУ", image:  "https://www.msu.ru/upload/iblock/3f9/20170913_010.jpg", description: "Первый ВУЗ страны после МГТУ"))
            self.fetchedUniversities.append(University(scores: 199, place: 100, rating: 5, name: "МФТИ", image:  "https://upload.wikimedia.org/wikipedia/ru/thumb/0/09/Лабораторный_корпус_МФТИ_20190407_1449011.jpg/2560px-Лабораторный_корпус_МФТИ_20190407_1449011.jpg", description: ""))
            self.fetchedUniversities.append(University(scores: 240, place: 99, rating: 4.9, name: "МИРЭА", image: "http://цнирти.рф/upload/medialibrary/bba/bbae3c6ba8f02f1530cd31cdbe0fcb25.jpg", description: "МИРЭА – это что и где? (c) – Генирал Адмирал, ректор МИРЭА Пупкин А.С."))
            self.fetchedUniversities.append(University(scores: 260, place: 89, rating: 4.3, name: "МТУСИ", image:  "https://avatars.mds.yandex.net/get-altay/248099/2a0000015f1ad8d99463e642b3078bc2eede/XXXL", description: "МТУСИ – сокращение от Мы ТУСИм"))
            self.universities = self.fetchedUniversities
            callback();
        });
    }
}
