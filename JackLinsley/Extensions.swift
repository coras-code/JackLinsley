//
//  Extensions.swift
//  JackLinsley
//
//  Created by My Apps on 11/01/2021.
//

import UIKit

public extension UITextField {
    
  func addAccessory(numberpad: Bool) {
        
        let numberToolbar = UIToolbar()
        numberToolbar.barStyle = UIBarStyle.default
        
        var accessories : [UIBarButtonItem] = []
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
        target: nil, action: nil)
        
        if numberpad {
            let plusMinusButton = UIBarButtonItem(title: "+/-", style: UIBarButtonItem.Style.plain, target: self, action: #selector(plusMinusPressed))
       
            let pointButton = UIBarButtonItem(title: ".", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pointPressed))
            
            accessories.append(pointButton)
            accessories.append(plusMinusButton)
            
        }
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                                    target: self, action: #selector(doneButtonPressed))
        
        accessories.append(flexSpace)
        accessories.append(doneButton)
      
        //or alternately skip itialising and add to directly to the array and intialise there
       // accessories.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        numberToolbar.items = accessories //numberToolbar.setItems([flexSpace, doneButton], animated: true)
        numberToolbar.sizeToFit()
        inputAccessoryView = numberToolbar
    }
    
    @objc func doneButtonPressed() {
       self.resignFirstResponder() //self.endEditing(true)
    }
    
    @objc func plusMinusPressed() {
        guard let currentText = self.text else {
            return
        }
        if currentText.hasPrefix("-") {
            let offsetIndex = currentText.index(currentText.startIndex, offsetBy: 1)
            let substring = currentText[offsetIndex...]  //remove first character
            self.text = String(substring)
        }
        else {
            self.text = "-" + currentText
        }
    }
    
    @objc func pointPressed() {
          guard let currentText = self.text else {
              return
          }
              self.text = currentText + "."
    }
      
}

public extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

