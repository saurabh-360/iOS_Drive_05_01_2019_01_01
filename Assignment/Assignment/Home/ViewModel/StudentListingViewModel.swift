//
//  StudentListingViewModel.swift
//  Assignment
//
//  Created by Saurabh Yadav on 05/01/19.
//  Copyright © 2019 Viacom 18. All rights reserved.
//

import Foundation
import RxSwift

class StudentListingViewModel {
    
    var studentData = Variable<[StudentListingModel]>([])
    let disposeBag = DisposeBag()
    
    
    var tempResult = Variable<[StudentListingModel]>([])
    
    func getStudentData() -> Observable<[String: Any]> {
        return Observable.create{observer in
            RequestManager.sharedInstance.makeGetRequest(withPath: API.listURL.rawValue)
                .asObservable()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { responseData in
                    do {
                        var modelObject = try JSONDecoder().decode([StudentListingModel].self, from: responseData)
                        
                        if (modelObject.isEmpty) {
                            observer.onError(NSError.init(domain: "a", code: 0, userInfo: nil)) // generate a custom error object here
                            observer.on(.completed)
                        } else {
                            self.studentData.value = modelObject
                            self.tempResult.value = modelObject

                            observer.onNext(["data" : true])
                            observer.on(.completed)
                        }
                    }
                    catch {
                        observer.onError(NSError.init(domain: "a", code: 0, userInfo: nil)) //
                        // generate a custom error object here
                        observer.on(.completed)
                    }
                },onError: { error in
                    observer.on(.completed)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
}
