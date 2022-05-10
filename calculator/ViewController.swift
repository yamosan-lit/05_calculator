//
//  ViewController.swift
//  calculator
//
//  Created by 八森聖人 on 2022/05/11.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    enum Operation: Int {
        case add = 0
        case sub = 1
        case mul = 2
        case div = 3
    }
    var ope: Operation? = .add
    var currentOpe: UIButton? = nil
    var sum: Int = 0
    var input: String = "0"
    var isCalc: Bool = false
    var ini: Bool = true // "=" 入力後すぐに number or allClear された場合に計算をリセットする為のフラグ
   
    @IBOutlet var result: UILabel! // ラベルの入力値
    @IBOutlet var opeButtons: [UIButton]! // ÷×-+ ボタン

    @IBAction func allClear(_ sender: UIButton) {
        input = "0"
        
        if ini {
            ini = false
            sum = 0
        }
        
        display()
    }
    
    @IBAction func number(_ sender: UIButton) {
        guard let btnVal = sender.titleLabel?.text else {
            return
        }

        if input == "0" && btnVal == "0" {
            return
        }
        if input == "0" {
            input = btnVal
        } else if ini {
            input = btnVal
            ini = false
            sum = 0
        } else {
            input += btnVal
        }
        isCalc = false
        
        display()
    }
    @IBAction func equal() {
        guard let n = Int(input) else {
            return
        }
        if let o = ope {
            let res = calc(sum, n, o)
            sum = res
        }
        input = String(sum)
        ope = nil
        isCalc = true
        currentOpe = nil
        ini = true
        
        display()
    }
    @IBAction func operation(_ sender: UIButton) {
        guard let opeStr = sender.titleLabel?.text else {
            return
        }
        guard let n = Int(input) else {
            return
        }

        if let o = ope {
            // 一つ前の計算を確定させる
            if !isCalc {
                let res = calc(sum, n, o)
                sum = res
                isCalc = true
            }
        } else if sum == 0 {
            // 最初の数
            sum = n
        }
        switch opeStr {
            case "+":
                ope = .add
            case "-":
                ope = .sub
            case "×":
                ope = .mul
            case "÷":
                ope = .div
            default:
                break
        }
        currentOpe = sender

        input = "0"
        ini = false

        display()
    }
    
    private func display() {
        result.text = input
        
        
        opeButtons.forEach {
            $0.backgroundColor = UIColor(red: 255/255, green: 231/255, blue: 230/255, alpha: 1.0)
        }
        currentOpe?.backgroundColor = UIColor(red: 236/255, green: 214/255, blue: 213/255, alpha: 1.0)
    }
    
    // helper
    private func calc(_ a: Int, _ b: Int, _ ope: Operation) -> Int {
        switch ope {
            case .add:
                return a + b
            case .sub:
                return a - b
            case .mul:
                return a * b
            case .div:
                if b == 0 {
                    return 0
                }
                return a / b
        }
    }
}

