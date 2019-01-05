//
//  RequestManager.swift
//  Assignment
//
//  Created by Saurabh Yadav on 05/01/19.
//  Copyright © 2019 Viacom 18. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class RequestManager {

    
    static var sharedInstance = RequestManager()
    
    
    func makeGetRequest(withPath path: String) -> Observable<Data>{
        var request = URLRequest.init(url: URL.init(string: path)!)
        request.timeoutInterval = 10
        
        let dataObservable = URLSession.shared.rx.data(request: request)
            .debug("some data is here")
        return dataObservable
    }
}
