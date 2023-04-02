//
//  LogInViewController.swift
//  MovieApp
//
//  Created by Petar on 23.03.2023..
//

import Foundation
import UIKit
import PureLayout

class LoginViewController: UIViewController {
    
    let backgroundColor = UIColor(red: 0.04, green: 0.14, blue: 0.247, alpha: 1.0)
    let textFieldColor = UIColor(red: 0.07, green: 0.23, blue: 0.39, alpha: 1.0)
    let buttonColor = UIColor(red: 0.30, green: 0.69, blue: 0.87, alpha: 1.0)
    
    private var signInLabel: UILabel!
    private var emailAdressLabel: UILabel!
    private var usernameField: UITextField!
    private var passwordLabel: UILabel!
    private var passwordField: UITextField!
    private var signInButton: UIButton!
    
    private var screenHeight: CGFloat!
    private var screenWidth: CGFloat!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        createViews()
        customizeViews()
        defineViewLayout()
        
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    
    private func createViews() {
        
        screenHeight = view.frame.height
        screenWidth = view.frame.width

        
        signInLabel = UILabel(frame: CGRect(x: 0, y: screenHeight*0.15, width: screenWidth, height: 35))
        emailAdressLabel = UILabel(frame: CGRect(x: screenWidth*0.05, y: screenHeight*0.25, width: screenWidth*0.9, height: 20))
        usernameField = UITextField()
        passwordLabel = UILabel()
        passwordField = UITextField()
        signInButton = UIButton()
        
    }
    
    private func customizeViews() {
        
        signInLabel.attributedText = NSAttributedString("Sign in")
        signInLabel.font = UIFont.boldSystemFont(ofSize: 30)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .white
        view.addSubview(signInLabel)
        
        emailAdressLabel.attributedText = NSAttributedString("Email address")
        emailAdressLabel.font = UIFont.systemFont(ofSize: 15)
        emailAdressLabel.textColor = .white
        view.addSubview(emailAdressLabel)
        
        usernameField.backgroundColor = textFieldColor
        usernameField.layer.cornerRadius = 10
        usernameField.attributedPlaceholder = NSAttributedString(string: " ex. Matt@ioscourse.com", attributes:[NSAttributedString.Key.foregroundColor: buttonColor])
        usernameField.font = UIFont.systemFont(ofSize: 24)
        usernameField.textColor = .white
        usernameField.layer.borderWidth = 0.4
        usernameField.layer.borderColor = buttonColor.cgColor
        view.addSubview(usernameField)
        
        passwordLabel.attributedText = NSAttributedString("Password")
        passwordLabel.font = UIFont.systemFont(ofSize: 15)
        passwordLabel.textColor = .white
        view.addSubview(passwordLabel)
        
        passwordField.backgroundColor = textFieldColor
        passwordField.layer.cornerRadius = 10
        passwordField.attributedPlaceholder = NSAttributedString(string: " Enter your password", attributes:[NSAttributedString.Key.foregroundColor: buttonColor])
        passwordField.font = UIFont.systemFont(ofSize: 24)
        passwordField.textColor = .white
        passwordField.isSecureTextEntry = true
        passwordField.layer.borderWidth = 0.4
        passwordField.layer.borderColor = buttonColor.cgColor
        view.addSubview(passwordField)
        
        signInButton.backgroundColor = buttonColor
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.titleLabel?.textColor = .white
        signInButton.titleLabel?.font = .systemFont(ofSize: 15)
        signInButton.layer.cornerRadius = 10
        view.addSubview(signInButton)
        
    }
    
    private func defineViewLayout() {
        
        usernameField.autoSetDimension(.height, toSize: 40)
        usernameField.autoMatch(.width, to: .width, of: emailAdressLabel)
        usernameField.autoPinEdge(.leading, to: .leading, of: emailAdressLabel)
        usernameField.autoPinEdge(.top, to: .bottom, of: emailAdressLabel, withOffset: 10)
        
        
        passwordLabel.autoMatch(.height, to: .height, of: emailAdressLabel)
        passwordLabel.autoMatch(.width, to: .width, of: emailAdressLabel)
        passwordLabel.autoPinEdge(.top, to: .bottom, of: usernameField, withOffset: 20)
        passwordLabel.autoPinEdge(.leading, to: .leading, of: emailAdressLabel)

        
        passwordField.autoSetDimension(.height, toSize: 40)
        passwordField.autoMatch(.width, to: .width, of: emailAdressLabel)
        passwordField.autoPinEdge(.leading, to: .leading, of: emailAdressLabel)
        passwordField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 10)
        

        signInButton.autoPinEdge(.top, to: .bottom, of: passwordField, withOffset: 50)
        signInButton.autoPinEdge(.leading, to: .leading, of: emailAdressLabel, withOffset: screenWidth*0.05)
        signInButton.autoSetDimension(.width, toSize: screenWidth*0.8)
        signInButton.autoMatch(.height, to: .height, of: usernameField, withMultiplier: 0.8)
        
    }
}
