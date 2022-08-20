//
//  Error.swift
//  Optional_ExceptionControll
//
//  Created by 이정민 on 2022/08/20.
//

import Foundation

// 중첩타입
enum OrderError: Error {
    case InputValueError
    case ConvertToNumberError
    case lackOfBudgetError
    case NotExistMenuError(Int)
}

extension OrderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .InputValueError:
            return "입력이 잘못되었습니다."
        case .ConvertToNumberError:
            return "메뉴 번호를 확인해주세요."
        case .lackOfBudgetError:
            return "잔액이 부족합니다."
        case .NotExistMenuError(let menuNumber):
            return "선택하신 \(menuNumber)번 메뉴가 매진되었습니다."
        }
    }
}
