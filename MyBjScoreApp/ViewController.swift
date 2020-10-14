//
//  ViewController.swift
//  MyBjScoreApp
//
//  Created by Shugo Matsuo on 2020/09/04.
//  Copyright © 2020 smatsuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var userCollection: [UITextField]!
    @IBOutlet var totalScoreCollection: [UILabel]!
    @IBOutlet var scoreCollection: [UITextField]!
    @IBOutlet var uiStepperCollection: [UIStepper]!
    @IBOutlet weak var allClearButton: UIButton!
    @IBOutlet weak var scoreClearButton: UIButton!
    @IBOutlet weak var scoreAddButton: UIButton!
    let userDefaults = UserDefaults.standard
    
    // 得点加算ボタン
    @IBAction func addScore(_ sender: UIButton) {
        var addTotalScore: Int = 0
        for score in scoreCollection {
            if let intScore = Int(score.text!){
                addTotalScore += intScore
            }
        }
        print("addTotalScore : \(addTotalScore)")
        
        if addTotalScore == 0 {
            for index in 0..<scoreCollection.count {
                if scoreCollection[index].text! != "" {
                    var totalScore = Int(totalScoreCollection[index].text!)
                    if let intScore = Int(scoreCollection[index].text!) {
                        totalScore! += intScore
                        viewTotalScore(index: index, totalScore: totalScore!)
                        print("totalScore : \(totalScore!)")
                    }
                }
            }
            // 得点入力欄を初期化
            clearScoreField()
            // UserDefaultsに保存
            var saveUser: [String] = []
            var saveScore: [String] = []
            for index in 0..<userCollection.count {
                if userCollection[index].text! != "" {
                    saveUser.append(userCollection[index].text!)
                    saveScore.append(totalScoreCollection[index].text!)
                }
            }
            print("saveUser : \(saveUser)")
            print("saveScore : \(saveScore)")
            userDefaults.set(saveUser, forKey: "userName")
            userDefaults.set(saveScore, forKey: "userScore")
        }
        else {
            // 入力スコア不正ダイアログ表示
            let scoreErrorAlert: UIAlertController = UIAlertController(title: "入力得点の合計が合いません", message: "確認お願いします", preferredStyle: UIAlertController.Style.alert)
            
            scoreErrorAlert.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(scoreErrorAlert, animated: true, completion: nil)
        }
    }
    
    // 得点入力欄クリアボタン
    @IBAction func clearScore(_ sender: UIButton) {
        clearScoreField()
    }
    
    // オールクリアボタン
    @IBAction func clearAllScore(_ sender: UIButton) {
        // クリア確認ダイアログ表示
        let clearAlert: UIAlertController = UIAlertController(title: "本当に合計得点をクリアしますか？", message: "", preferredStyle: UIAlertController.Style.alert)
        // クリア実行
        let confirmAction: UIAlertAction = UIAlertAction(title: "消去", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) -> Void in
            print("Clear total score")
            self.clearUserField()
            self.clearTotalScoreField()
            self.clearScoreField()
        })
        // クリアキャンセル
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in
            print("Cancel clear total score")
        })
        clearAlert.addAction(confirmAction)
        clearAlert.addAction(cancelAction)
        
        self.present(clearAlert, animated: true, completion: nil)
    }
    
    func clearUserField() {
        for userField in userCollection {
            userField.text! = ""
        }
        self.userDefaults.removeObject(forKey: "userName")
    }
    
    func clearTotalScoreField() {
        for totalScoreField in totalScoreCollection {
            totalScoreField.text! = "0"
            totalScoreField.textColor! = UIColor.black
        }
        self.userDefaults.removeObject(forKey: "userScore")
    }
    
    func clearScoreField() {
        for scoreField in scoreCollection {
            scoreField.text! = ""
        }
        for stepper in uiStepperCollection {
            stepper.value = 0
        }
    }
    
    func viewTotalScore(index: Int, totalScore: Int){
        totalScoreCollection[index].text! = String(totalScore)
        switch totalScore {
        case (let score) where score < 0:
            totalScoreCollection[index].textColor = UIColor.red
        case (let score) where score > 0:
            totalScoreCollection[index].textColor = UIColor.blue
        default:
            totalScoreCollection[index].textColor = UIColor.black
        }
    }
    
    @IBAction func changeScore1(_ sender: UITextField) {
        changeScore(index: 0)
    }
    @IBAction func changeScore2(_ sender: UITextField) {
        changeScore(index: 1)
    }
    @IBAction func changeScore3(_ sender: UITextField) {
        changeScore(index: 2)
    }
    @IBAction func changeScore4(_ sender: UITextField) {
        changeScore(index: 3)
    }
    @IBAction func changeScore5(_ sender: UITextField) {
        changeScore(index: 4)
    }
    @IBAction func changeScore6(_ sender: UITextField) {
        changeScore(index: 5)
    }
    @IBAction func changeScore7(_ sender: UITextField) {
        changeScore(index: 6)
    }
    
    func changeScore(index: Int) {
        print("score\(index + 1) : " + scoreCollection[index].text!)
        if let doubleScore = Double(scoreCollection[index].text!){
            self.uiStepperCollection[index].value = doubleScore
        }
        else {
            print("[WAR]scoreField input not double!!!" )
        }
    }
    
    @IBAction func changeUiStepper1(_ sender: UIStepper) {
        changeUiStepper(index: 0, stepper: sender)
    }
    @IBAction func changeUiStepper2(_ sender: UIStepper) {
        changeUiStepper(index: 1, stepper: sender)
    }
    @IBAction func changeUiStepper3(_ sender: UIStepper) {
        changeUiStepper(index: 2, stepper: sender)
    }
    @IBAction func changeUiStepper4(_ sender: UIStepper) {
        changeUiStepper(index: 3, stepper: sender)
    }
    @IBAction func changeUiStepper5(_ sender: UIStepper) {
        changeUiStepper(index: 4, stepper: sender)
    }
    @IBAction func changeUiStepper6(_ sender: UIStepper) {
        changeUiStepper(index: 5, stepper: sender)
    }
    @IBAction func changeUiStepper7(_ sender: UIStepper) {
        changeUiStepper(index: 6, stepper: sender)
    }
    
    func changeUiStepper(index: Int, stepper: UIStepper){
        let num = Int(stepper.value)
        print("uiSetpper\(index + 1) : " + String(num))
        self.scoreCollection[index].text = String(num)
    }
    
    // ボタン修飾
    func modifyButton(button: UIButton) {
        button.backgroundColor = UIColor.systemBlue
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20.0
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ユーザー名入力欄設定
        for userField in userCollection {
            // returnキー押下でキーボードを収納するためのデリゲート設定
            userField.delegate = self
        }
        
        // 得点入力欄設定
        for scoreField in scoreCollection {
            // 数値入力キーボード設定
            scoreField.keyboardType = UIKeyboardType.numberPad
            // returnキー押下でキーボードを収納するためのデリゲート設定
            scoreField.delegate = self
        }
        // ボタン修飾
        modifyButton(button: allClearButton)
        modifyButton(button: scoreClearButton)
        modifyButton(button: scoreAddButton)
        
        // UserDefaluts読み込み
        let readUser = userDefaults.stringArray(forKey: "userName") ?? [""]
        let readScore = userDefaults.stringArray(forKey: "userScore") ?? ["0"]
        print("readUser : \(readUser)")
        print("readScore : \(readScore)")
        
        // 合計得点表示
        if !readUser.isEmpty {
            for index in 0..<readUser.count {
                userCollection[index].text! = readUser[index]
                viewTotalScore(index: index, totalScore: Int(readScore[index])!)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
}

