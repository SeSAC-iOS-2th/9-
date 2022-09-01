//
//  Sample.swift
//  SeSACWeek9
//
//  Created by 이중원 on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> Void)? //클로저 구문을 변수 형태로 저장
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completionHandler: @escaping (T) -> Void ) {
        completionHandler(value)
        listener = completionHandler
    }
    
}
