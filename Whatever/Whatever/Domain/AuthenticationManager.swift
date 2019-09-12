//
//  AuthenticationManager.swift
//  Whatever
//
//  Created by Widyanti, Retno (AU - Melbourne) on 12/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import RxSwift
import RxCocoa

enum AuthenticationResult {
    case success(newUser: Bool)
    case wrongCredentials
    case accountLocked
    case error
}

enum AuthenticatedState {
    case loggedIn(newUser: Bool)
    case loggedOut
}

final class AuthenticationManager {
    private let disposeBag = DisposeBag()

    // Variable exposing authentication state.
    private(set) lazy var authenticated = self.authenticatedSubject
        .asDriver(onErrorJustReturn: .loggedOut)
    let authenticatedSubject = PublishSubject<AuthenticatedState>()

    // Repository.
    private let authenticationRepository = AuthenticationRepository()

    // Network calls.
    func createUser(
        email: String,
        password: String) -> Single<AuthenticationResult> {
        return authenticationRepository.createUser(
            email: email,
            password: password)
            .map { _ -> AuthenticationResult in
                return .success(newUser: true)
            }
            .catchErrorJustReturn(.error)
    }
}
