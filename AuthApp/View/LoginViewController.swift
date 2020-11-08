//
//  LoginViewController.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 27/10/2020.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

import FirebaseAuth


class LoginViewController: UIViewController {

    // MARK: - Properites
    let loginViewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
//    public let userEmail : PublishSubject<String> = PublishSubject()
    
     init(){
        self.loginViewModel = LoginViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    // App Name
    var appName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.text = "MyAuth"
        label.textColor = .black
        label.font = UIFont(name: "ArialMT", size: 27.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // message label
    var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.text = ""
        label.textColor = .red
        label.font = UIFont(name: "ArialMT", size: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // email text feild
    var emailTextFeild: UITextField = {
        let email =  UITextField()
        email.placeholder = "Email"
        email.font = UIFont.systemFont(ofSize: 15)
        email.borderStyle = UITextField.BorderStyle.roundedRect
        email.autocorrectionType = UITextAutocorrectionType.no
        email.keyboardType = UIKeyboardType.default
        email.returnKeyType = UIReturnKeyType.done
        email.clearButtonMode = UITextField.ViewMode.whileEditing
        email.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return email
    }()
    
    // password text feild
    var passwordTextFeild: UITextField = {
        let password =  UITextField()
        password.placeholder = "Password"
        password.font = UIFont.systemFont(ofSize: 15)
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.autocorrectionType = UITextAutocorrectionType.no
        password.keyboardType = UIKeyboardType.default
        password.returnKeyType = UIReturnKeyType.done
        password.clearButtonMode = UITextField.ViewMode.whileEditing
        password.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        password.isSecureTextEntry = true
        return password
    }()
    
    // login button
    let loginButton: UIButton = {
        let loginBtn = UIButton()
        loginBtn.backgroundColor = .gray
        loginBtn.tintColor = .white
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.layer.cornerRadius = 5
        return loginBtn
    }()


    // signup button
    let signupButton: UIButton = {
        let signupBtn = UIButton(frame: CGRect(x: 20, y: 330, width: 300, height: 40))
        signupBtn.backgroundColor = .gray
        signupBtn.tintColor = .white
        signupBtn.setTitle("Signup", for: .normal)
        signupBtn.layer.cornerRadius = 5
        return signupBtn
    }()
    
    
    // MARK: - view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.emailTextFeild.becomeFirstResponder()
    
        setupUI()
        setupBinding()
        print("START...")
      
        
        
    }
    
    
    // MARK: - Setup UI
    func setupUI() {
        
        view.addSubview(appName)
        appName.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(100)
        }
    

        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(appName.snp.top).offset(60)
        }
        
        view.addSubview(emailTextFeild)
        emailTextFeild.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(messageLabel.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(60)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.height.equalTo(40)
        }
        
        view.addSubview(passwordTextFeild)
        passwordTextFeild.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(emailTextFeild.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(60)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.height.equalTo(40)
        }
        
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        loginButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(passwordTextFeild.snp.bottom).offset(60)
            make.leading.equalTo(view.snp.leading).offset(60)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.height.equalTo(40)
        }
        
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(60)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.height.equalTo(40)
        }
    }
    
    
    // MARK: - Setup Binding
    func setupBinding() {
        
        self.emailTextFeild.rx.text.orEmpty.bind(to: self.loginViewModel.email)
        .disposed(by: disposeBag)
        
        self.passwordTextFeild.rx.text.orEmpty.bind(to: self.loginViewModel.password)
        .disposed(by: disposeBag)
        
        self.loginViewModel.isValid.map { $0 }
        .bind(to: loginButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        self.loginViewModel.isValid.map{ $0 ? 1 : 0.4}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
        
        
        loginViewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    self.messageLabel.text = message
                case .serverMessage(let message):
                    self.messageLabel.text = message
                }
            }).disposed(by: disposeBag)
        
        
        loginViewModel
            .successLogin
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (data) in
               print("Data : \(data)")
                
                let homeViewController = HomeViewController()
                homeViewController.modalPresentationStyle = .fullScreen
                self.present(homeViewController, animated: true)
                switch data {
                case .redirectToHome(let email):
                    homeViewController.userEmail.onNext("Welcome, you logged in with \(email)")
                }
            }).disposed(by: disposeBag)

        loginViewModel.showLoading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
    
    }
    
    // MARK: - Execute login process
    @objc func loginClicked(_: Any) {
        self.loginViewModel.login(email: self.emailTextFeild.text ?? "", password: self.passwordTextFeild.text ?? "")
    }

}



