//
//  CounterViewController.swift
//  UIKitTema
//
//  Created by Denis Horvat  on 31.07.2023.
//

import UIKit

class CounterViewController: UIViewController {
    
    var buttonsView = UIView()
    var labelView = UIView()
    var buttonsStackView = UIStackView()
    var labelsStackView = UIStackView()
    var buttons: [UIButton] = []
    var label: UILabel = UILabel(frame: .zero)
    var resultLabel: UILabel = UILabel(frame: .zero)
    
    var operations: String = String()
    var operationsLabel = String()
    var resultString: String = String()
    let spacer:Double = 5
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        setupViews()
        setupButtons()
        setupLabel()
        
        
    }
}

extension CounterViewController {
    
    @objc func buttonAction(buttonPressed: UIButton) {
        print("Pressed: \(buttonPressed.tag)")
        
        switch buttonPressed.tag {
        case 0:
            operations = operations + "0"
            operationsLabel = operationsLabel + "0"
            label.text = operationsLabel
        case 1:
            operations = operations + "0"
            operationsLabel = operationsLabel + "0"
            label.text = operationsLabel
        case 2:
            if isLastCharNumber(op: operations){
                operations = operations + "."
                operationsLabel = operationsLabel + "."
            }
            else{
                if !operations.isEmpty{
                    operations.removeLast()
                    operationsLabel.removeLast()
                    operations = operations + "."
                    operationsLabel = operationsLabel + "."
                }
            }
            label.text = operationsLabel
            
        case 3: //=
            if !isLastCharNumber(op: operations){
                operations.removeLast()
                operationsLabel.removeLast()
            } //27.2/3 + 2 / 3 =
            
            var modifiedOperations = ""
            var lastCharIsDot = false
            
            for char in operations {  //makes every "/" to ".0/" if the number before / is int
                if char == "/" && !lastCharIsDot {
                        modifiedOperations += ".0/"
                    print(3)
                }
                else {
                    modifiedOperations.append(char)
                }
                if char == "/" || char == "*" || char == "+" || char == "-" {
                    lastCharIsDot = false
                    print(1)
                }
                else if char == "." {
                    lastCharIsDot = true
                    print(2)
                }
            }
            //operations = operations.replacingOccurrences(of: "/", with: ".0/")
            operations = modifiedOperations
            
            let mathExpression = NSExpression(format: operations)
            let result = mathExpression.expressionValue(with: nil, context: nil) as! Double
        
            
            if result.truncatingRemainder(dividingBy: 1) == 0{
                resultString = String(format: "%.0f", result)
            }
            else {
                resultString = String(format: "%.2f", result)
            }
                
            resultLabel.text = resultString
            label.text = operationsLabel + "=" + resultString
            operations = resultString
            operationsLabel = resultString
            
            
        case 4:
            operations = operations + "1"
            operationsLabel = operationsLabel + "1"
            label.text = operationsLabel
        case 5:
            operations = operations + "2"
            operationsLabel = operationsLabel + "2"
            label.text = operationsLabel
        case 6:
            operations = operations + "3"
            operationsLabel = operationsLabel + "3"
            label.text = operationsLabel
        case 7:
            if isLastCharNumber(op: operations){
                operations = operations + "+"
                operationsLabel = operationsLabel + "+"
            }
            else{
                if !operations.isEmpty{
                    operations.removeLast()
                    operationsLabel.removeLast()
                    operations = operations + "+"
                    operationsLabel = operationsLabel + "+"
                }
            }
            
            label.text = operationsLabel
        case 8:
            operations = operations + "4"
            operationsLabel = operationsLabel + "4"
            label.text = operationsLabel
        case 9:
            operations = operations + "5"
            operationsLabel = operationsLabel + "5"
            label.text = operationsLabel
        case 10:
            operations = operations + "6"
            operationsLabel = operationsLabel + "6"
            label.text = operationsLabel
        case 11:
            if isLastCharNumber(op: operations){
                operations = operations + "-"
                operationsLabel = operationsLabel + "-"
            }
            else{
                if !operations.isEmpty{
                    operations.removeLast()
                    operationsLabel.removeLast()
                }
                operations = operations + "-"
                operationsLabel = operationsLabel + "-"
            }
            label.text = operationsLabel
        case 12:
            operations = operations + "7"
            operationsLabel = operationsLabel + "7"
            label.text = operationsLabel
        case 13:
            operations = operations + "8"
            operationsLabel = operationsLabel + "8"
            label.text = operationsLabel
        case 14:
            operations = operations + "9"
            operationsLabel = operationsLabel + "9"
            label.text = operationsLabel
        case 15:
            if isLastCharNumber(op: operations){
                operations = operations + "/"
                operationsLabel = operationsLabel + "÷"
            }
            else{
                if !operations.isEmpty{
                    operations.removeLast()
                    operationsLabel.removeLast()
                    operations = operations + "/"
                    operationsLabel = operationsLabel + "÷"
                }
                
            }
            label.text = operationsLabel
        case 16:
            clearAll()
        case 18:
            if (!operations.isEmpty) {
                operations.removeLast()
                operationsLabel.removeLast()
            }
            label.text = operationsLabel
        case 19:
            if isLastCharNumber(op: operations){
                operations = operations + "*"
                operationsLabel = operationsLabel + "×"
            }
            else{
                if !operations.isEmpty{
                    operations.removeLast()
                    operationsLabel.removeLast()
                    operations = operations + "*"
                    operationsLabel = operationsLabel + "×"
                }
            }
            label.text = operationsLabel
        default: print("Pressed: \(buttonPressed.tag)")
        }
    }
    
// READ ME: view frame/bounds/ position / anchor point
}

extension CounterViewController {
    func setupViews() {
        view.addSubview(buttonsView)
        view.addSubview(labelView)
        buttonsView.addSubview(buttonsStackView)
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            buttonsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
        
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            labelView.bottomAnchor.constraint(equalTo: buttonsView.topAnchor),
            labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            labelView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            labelView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    func setupButtons(){
        var view1 = UIView() // 2 views for the bottom buttons
        var view2 = UIView()
        buttonsStackView.axis = .vertical
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = spacer

        for _ in 0...19 {
            let button = UIButton()
            buttons.append(button)
        }
        
        for i in stride(from: 4, through: 0, by: -1) {
            let horizontalSv = UIStackView()
            horizontalSv.axis = .horizontal
            horizontalSv.alignment = .fill
            horizontalSv.distribution = .fillEqually
            horizontalSv.spacing = spacer
            
            for j in 0...3{
                if(i*4+j < 4){ //bottom row
                    buttons[i*4+j].setTitle("\(0)", for: .normal)
                    buttons[i*4+j].backgroundColor = .orange
                    buttons[i*4+j].tag = i*4+j
                    buttons[i*4+j].addTarget(self, action: #selector(buttonAction(buttonPressed:)), for: .touchUpInside)
                    buttons[i*4+j].layer.cornerRadius = 15
                    buttons[i*4+j].titleLabel?.font = UIFont.systemFont(ofSize: 30)
                    buttons[i*4+j].widthAnchor.constraint(equalTo: buttons[i*4+j].heightAnchor).isActive = true
                    buttons[i*4+j].translatesAutoresizingMaskIntoConstraints = false
                    
                    if(i*4+j == 3){
                        view1.addSubview(buttons[0])
                        view2.addSubview(buttons[2])
                        view2.addSubview(buttons[3])
                        
                        horizontalSv.addArrangedSubview(view1)
                        horizontalSv.addArrangedSubview(view2)
                        
                        buttons[1].translatesAutoresizingMaskIntoConstraints = false
                        buttons[0].translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            buttons[0].rightAnchor.constraint(equalTo: view1.rightAnchor),
                            buttons[0].bottomAnchor.constraint(equalTo: view1.bottomAnchor),
                            buttons[0].topAnchor.constraint(equalTo: view1.topAnchor),
                            buttons[0].leftAnchor.constraint(equalTo: view1.leftAnchor)
                        ])
                        NSLayoutConstraint.activate([
                            buttons[2].rightAnchor.constraint(equalTo: view2.centerXAnchor, constant: -spacer/2),
                            buttons[2].bottomAnchor.constraint(equalTo: view2.bottomAnchor),
                            buttons[2].topAnchor.constraint(equalTo: view2.topAnchor),
                            buttons[2].leftAnchor.constraint(equalTo: view2.leftAnchor)
                        ])
                        NSLayoutConstraint.activate([
                            buttons[3].rightAnchor.constraint(equalTo: view2.rightAnchor),
                            buttons[3].bottomAnchor.constraint(equalTo: view2.bottomAnchor),
                            buttons[3].topAnchor.constraint(equalTo: view2.topAnchor),
                            buttons[3].leftAnchor.constraint(equalTo: view2.centerXAnchor, constant: spacer/2)
                        ])
                        //buttons[0].widthAnchor.constraint(equalTo:buttons[3].widthAnchor, multiplier: 2.0 ).isActive = true
                    }
                }
                else {
                    buttons[i*4+j].setTitle("\(0)", for: .normal)
                    buttons[i*4+j].backgroundColor = .orange
                    buttons[i*4+j].tag = i*4+j
                    buttons[i*4+j].addTarget(self, action: #selector(buttonAction(buttonPressed:)), for: .touchUpInside)
                    buttons[i*4+j].layer.cornerRadius = 15
                    buttons[i*4+j].titleLabel?.font = UIFont.systemFont(ofSize: 30)
                    buttons[i*4+j].widthAnchor.constraint(equalTo: buttons[i*4+j].heightAnchor).isActive = true
                    
                    horizontalSv.addArrangedSubview(buttons[i*4+j])
                }
                
//                buttons[i*4+j].translatesAutoresizingMaskIntoConstraints = false
//                buttons[i*4+j].widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
//                buttons[i*4+j].heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
//                view.addSubview(buttons[i*4+j])
//
//                switch i*4+j{
//                case 0:
//                    buttons[0].bottomAnchor.constraint(equalTo: viewButtons.safeAreaLayoutGuide.bottomAnchor, constant: -spacer).isActive = true
//                    buttons[0].leftAnchor.constraint(equalTo: viewButtons.safeAreaLayoutGuide.leftAnchor, constant: spacer).isActive = true
//                case 1...3:
//                    buttons[i*4+j].leftAnchor.constraint(equalTo: buttons[(i*4+j)-1].rightAnchor, constant: spacer).isActive = true
//                    buttons[i*4+j].bottomAnchor.constraint(equalTo: viewButtons.safeAreaLayoutGuide.bottomAnchor, constant: -spacer).isActive = true
//                case 4,8,12,16:
//                    buttons[i*4+j].leftAnchor.constraint(equalTo: viewButtons.safeAreaLayoutGuide.leftAnchor, constant: spacer).isActive = true
//                    buttons[i*4+j].bottomAnchor.constraint(equalTo: buttons[(i*4+j)-4].topAnchor, constant: -spacer).isActive = true
//                default:
//                    buttons[i*4+j].leftAnchor.constraint(equalTo: buttons[(i*4+j)-1].rightAnchor, constant: spacer).isActive = true
//                    buttons[i*4+j].bottomAnchor.constraint(equalTo: buttons[(i*4+j)-4].topAnchor, constant: -spacer).isActive = true
//                }
                //buttons[0].frame = CGRect(x: (width/4)*(CGFloat(j))+5, y: (height-(CGFloat(i+1)*100))-50, width: 90, height: 90)
            }
            buttonsStackView.addArrangedSubview(horizontalSv)
        }
        
        var k: Int = 0
        for i in 0...3{
            for j in 0...3{
                if j<3 { //numeroteaza titlul butonele de la 1 la 9
                    buttons[(i*4+j)+4].setTitle("\(k+1)", for: .normal)
                    buttons[(i*4+j)+4].backgroundColor = .gray
                    k += 1
                }
            }
        }
        buttons[16].backgroundColor = .darkGray
        buttons[17].backgroundColor = .darkGray
        buttons[18].backgroundColor = .darkGray
        buttons[0].backgroundColor = .gray
        buttons[2].backgroundColor = .gray
        
        buttons[0].setTitle("0", for: .normal)
        buttons[1].setTitle("0", for: .normal)
        buttons[2].setTitle(".", for: .normal)
        buttons[3].setTitle("=", for: .normal)
        buttons[7].setTitle("+", for: .normal)
        buttons[11].setTitle("-", for: .normal)
        buttons[15].setTitle("÷", for: .normal)
        buttons[16].setTitle("C", for: .normal)
        buttons[17].setTitle("", for: .normal)
        buttons[18].setTitle("⌫", for: .normal)
        buttons[19].setTitle("×", for: .normal)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            buttonsStackView.rightAnchor.constraint(equalTo: buttonsView.rightAnchor),
            buttonsStackView.leftAnchor.constraint(equalTo: buttonsView.leftAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: buttonsView.topAnchor)
        ])
        buttons[1].translatesAutoresizingMaskIntoConstraints = false
        buttons[0].translatesAutoresizingMaskIntoConstraints = false
        //buttons[0].rightAnchor.constraint(equalTo: buttons[1].rightAnchor).isActive = true
        //buttons[0].widthAnchor.constraint(equalTo:buttons[3].widthAnchor, multiplier: 2.0 ).isActive = true
    }
    
            
                
    
    func setupLabel() {
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .fill
        labelsStackView.distribution = .fillEqually
        labelsStackView.spacing = spacer
        labelsStackView.addArrangedSubview(label)
        labelsStackView.addArrangedSubview(resultLabel)
        

        label.text = operations
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)

        label.textAlignment = .center
        //label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false

        
        resultLabel.text = resultString
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 40)
        resultLabel.textAlignment = .center
        //resultLabel.layer.cornerRadius = 10
        resultLabel.clipsToBounds = true
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelsStackView.bottomAnchor.constraint(equalTo: labelView.bottomAnchor),
            labelsStackView.rightAnchor.constraint(equalTo: labelView.rightAnchor),
            labelsStackView.leftAnchor.constraint(equalTo: labelView.leftAnchor),
            labelsStackView.topAnchor.constraint(equalTo: labelView.topAnchor)
        ])
        
    }
    
    func clearAll() {
        operations = ""
        resultString = ""
        operationsLabel = ""
        label.text = operationsLabel
        resultLabel.text = resultString
    }
    
}

func isLastCharNumber(op: String) -> Bool {
    if op.hasSuffix("+") || op.hasSuffix("-") || op.hasSuffix("*") || op.hasSuffix("/") ||  op.hasSuffix(".") || op.isEmpty {
        return false
    }
    else{
        return true
    }
}

//func addChar (op: String) {
//    if op = "*" || op = "/" || op = "+" || op = "-" {
//
//    }
//}
