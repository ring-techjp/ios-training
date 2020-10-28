//
//  ViewController.swift
//  CountUp.Sample
//
//  Created by Masaki on R 2/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorViewController: UIViewController {
    
    
    @IBOutlet var zeroButton: UIButton!
    @IBOutlet var oneButton: UIButton!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    @IBOutlet var fiveButton: UIButton!
    @IBOutlet var sixButton: UIButton!
    @IBOutlet var sevenButton: UIButton!
    @IBOutlet var eightButton: UIButton!
    @IBOutlet var nineButton: UIButton!
    @IBOutlet var dotButton: UIButton!
    @IBOutlet var equalButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var timesButton: UIButton!
    @IBOutlet var dividedButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var numberLabel: UILabel!


    private var count: BehaviorRelay<String> = BehaviorRelay(value: "0")
    private let disposeBag: DisposeBag = DisposeBag()
    
    enum CalculationStatus {
        case none, plus, minus
    }
    
    var numberStg:String = "0"
    var calculationStatus: CalculationStatus = .none
    
    
    var floatNum:String = ""
    var plusNum:String = ""
    var minusNum:String = ""
    var previousNumber:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapedNumberButton()
        calculationProcess()
    }

    
    //計算の条件分岐
    private func calculationProcess(){
        
        //押した数字が変わる度の処理
            count.asObservable()
                .subscribe(onNext: { [weak self] count in
                    switch self?.calculationStatus{
                    case .none:
                        self?.previousNumber += count
                        self?.numberLabel.text = self?.previousNumber
                    case .plus:
                        self?.floatNum += count
                        self?.plusNum = String(Int(self?.previousNumber ?? "0")! + Int(self?.floatNum ?? "0")!)
                        self?.numberLabel.text = self?.floatNum
                    case .minus:
                        self?.floatNum += count
                        self?.minusNum = String(Int(self?.previousNumber ?? "0")! - Int(self?.floatNum ?? "0")!)
                        self?.numberLabel.text = self?.floatNum
                    case .some(.none):
                        self?.previousNumber += count
                        print("Count",self?.previousNumber as Any)
                        self?.numberLabel.text = self?.previousNumber
                    }
                })
        
        
        
        //=押したときの処理
            equalButton.rx.tap.subscribe({ [weak self] _ in
            switch self?.calculationStatus{
            
            case .none:
                print("none")
                return;
            case .plus:
                self?.numberLabel.text = self?.plusNum ?? "0"
                print("足し算計算結果",self?.plusNum)
                self?.resetProcess()
                self?.calculationStatus = .none
                    
            case .minus:
                self?.numberLabel.text = self?.minusNum ?? "0"
                print("引き算計算結果",self?.minusNum)
                self?.resetProcess()
                self?.calculationStatus = .none
            case .some(.none):
                print("none")
                return;
            }
            }).disposed(by: disposeBag)
        
        //クリアボタンを押したときのリセット処理
            resetButton.rx.tap.subscribe({ [weak self] _ in
            self?.resetProcess()
            self?.numberLabel.text = "0"
            print("c")
            }).disposed(by: disposeBag)
    }
    
    //リセット処理
    private func resetProcess(){
        self.previousNumber = "0"
//        self.followingNumber = "0"
        self.floatNum = ""
        self.calculationStatus = .none
    }
    
    
    // ボタンの処理
    private func tapedNumberButton() {
        
        zeroButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("0")
            print("0")
        }).disposed(by: disposeBag)
        
        oneButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("1")
            print("1")
        }).disposed(by: disposeBag)
        
        twoButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("2")
            print("2")
        }).disposed(by: disposeBag)
        
        threeButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("3")
            print("3")
        }).disposed(by: disposeBag)
        
        fourButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("4")
            print("4")
        }).disposed(by: disposeBag)
        
        fiveButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("5")
            print("5")
        }).disposed(by: disposeBag)
        
        sixButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("6")
            print("6")
        }).disposed(by: disposeBag)
        
        sevenButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("7")
            print("7")
        }).disposed(by: disposeBag)
        
        eightButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("8")
            print("8")
        }).disposed(by: disposeBag)
        
        nineButton.rx.tap.subscribe({ [weak self] _ in
            self?.count.accept("9")
            print("9")
        }).disposed(by: disposeBag)
        
        //＋を押したときのステータス変化
        plusButton.rx.tap.subscribe({ [weak self] _ in
        print("+")
        self?.calculationStatus = .plus
        }).disposed(by: disposeBag)
    
        //-を押したときのステータス変化
        minusButton.rx.tap.subscribe({ [weak self] _ in
        print("-")
        self?.calculationStatus = .minus
        }).disposed(by: disposeBag)
    }
}


