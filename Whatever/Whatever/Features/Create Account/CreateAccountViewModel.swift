//
//  CreateAccountViewModel.swift
//  Whatever
//
//  Created by Retno Widyanti on 11/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

enum CreateAccountViewState {
    case initial
    case error
}

class CreateAccountViewModel {
    private let disposeBag = DisposeBag()

    // Variable exposing view state.
    lazy var state: Observable<CreateAccountViewState> = self.stateSubject.asObservable()
    private let stateSubject = BehaviorSubject<CreateAccountViewState>(value: .initial)
    
    private let router: AnyRouter<AuthenticationRoute>
    private let authenticationManager: AuthenticationManager
    
    init(
        router: AnyRouter<AuthenticationRoute>,
        authenticationManager: AuthenticationManager) {
        self.router = router
        self.authenticationManager = authenticationManager
    }

    func createAccount(email: String, password: String) {
        authenticationManager.createUser(
            email: email,
            password: password)
            .map { state -> CreateAccountViewState in
                return .initial
            }
            .catchErrorJustReturn(.error)
            .do(onSuccess: { [weak self] _ in
                self?.router.trigger(.verifyEmail(email))
            })
            .asObservable()
            .subscribe(onNext: self.stateSubject.onNext)
            .disposed(by: disposeBag)
    }
}
