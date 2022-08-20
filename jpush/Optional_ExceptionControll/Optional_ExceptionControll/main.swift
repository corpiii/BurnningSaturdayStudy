//
//  main.swift
//  Optional_ExceptionControll
//
//  Created by 이정민 on 2022/08/20.
//

var budget: Int = 4000
var lunchList: [String?] = ["김밥", "라면", nil, "볶음밥", "짜장면", "짬뽕"]

// Optional Binding
func printZeroMenu() {
    if let zeroMenu = lunchList[0] {
        print("0번 상품은 \(zeroMenu)입니다.")
    } else {
        print("0번 메뉴가 없어용")
    }
}

func printFirstMenu() {
    guard let firstMenu = lunchList[1] else {
        print("1번 메뉴가 없어용")
        return
    }
        
    print("1번 상품은 \(firstMenu)입니다.")
}

func printSecondMenu() {
    // 들어오는 값이 0, 1 등을 알고 있을 때 사용하는 듯
    let secondMenu = lunchList[2]
    
    switch secondMenu {
    case .some(let menu):
        print("2번 상품은 \(menu)입니다.")
    case .none:
        print("2번 메뉴가 없어용")
        // 헐
        // enum의 결과값을 다 case로 작성하면 default를 적어주지 않아도 된다.
    }
}


// Optional Chainning
func printThirdMenu() {
    let thirdMenu = lunchList[3]
    
    if thirdMenu?.hasPrefix("볶음") == true {
        print("3번 상품은 볶음밥입니다.")
    } else {
        print("3번 메뉴가 없어용")
    }
}

// Optional Nil-Coalescing
func printFourthMenu() {
    let fourthMenu = lunchList[4] ?? ""
    
    if fourthMenu.isEmpty {
        print("4번 메뉴가 없어용")
    } else {
        print("4번 상품은 \(fourthMenu) 입니다.")
    }
}

// Unconditional Unwrapping
func printFifthMenu() {
//    let fifthMenu = lunchList[5]
//
//    print("5번 메뉴는 \(fifthMenu!)입니다.")
    if let fifthMenu = lunchList[5] {
        print("5번 상품은 \(fifthMenu)입니다.")
    } else {
        print("5번 메뉴가 없어용")
    }
}

// MARK: -- 실험 2

/*
 coalesce 뜻
 1. to grow together
 2. to unite into a whole

 a: OOXOO
 b:   O
 둘을 합쳐 완전하게 만드는 느낌?
 */

var flag = ""
while flag != "x" {
    printMenuList()
    do {
        let input = try fetchInput()
        if input == "x" {
            print("프로그램을 종료합니다.")
            break
        }

        let menuNumber = try convertToNumber(self: input)
        try order(menuNumber)
    } catch let error {
        print(error.localizedDescription)
    }
    print()
}

func printMenuList() {
    print("[메뉴 리스트]")
    printZeroMenu()
    printFirstMenu()
    printSecondMenu()
    printThirdMenu()
    printFourthMenu()
    printFifthMenu()
    
    print("""
        
        주문하실 메뉴를 선택해주세요 종료하시려면 x를 눌러주세요 :
        """, terminator: " ")
    
}

func fetchInput() throws -> String {
    guard let input = readLine() else {
        throw OrderError.InputValueError
    }
    
    return input
}

func convertToNumber(self inputValue: String) throws -> Int {
    guard let convertedNumber = Int(inputValue) else {
        throw OrderError.ConvertToNumberError
    }
    
    return convertedNumber
}

func order(_ menuNumber: Int) throws {
    if let menu = lunchList[menuNumber] {
        print("\(menuNumber)번의 메뉴 \(menu)는 1000원 입니다.")
        if budget >= 1000 {
            budget -= 1000
            lunchList[menuNumber] = nil
            print("1000원을 차감합니다 잔액은 \(budget)원 입니다.")
        } else {
            throw OrderError.lackOfBudgetError
        }
    } else {
        throw OrderError.NotExistMenuError(menuNumber)
    }
}


