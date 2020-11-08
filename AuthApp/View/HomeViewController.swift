//
//  ViewController.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 27/10/2020.
//

import UIKit
import SnapKit
import FirebaseAuth
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {
    
    // MARK: - Properites
    public let userEmail : PublishSubject<String> = PublishSubject()
    let disposeBag = DisposeBag()
    
    
    let logoutButton: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.backgroundColor = .gray
        logoutBtn.tintColor = .white
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.layer.cornerRadius = 5
        return logoutBtn
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "ArialMT", size: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupUI()
        setBinding()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        self.view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view.snp.center)
        }
        
        self.view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(logoutClicked), for: .touchUpInside)
        logoutButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(messageLabel.snp.bottom).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(self.view.frame.width / 2)
        }
    }
    
    
    // MARK: - Setup Binding
    func setBinding(){
        self.userEmail.bind(to: self.messageLabel.rx.text).disposed(by: disposeBag)
    }
    
    
    // MARK: - Logout 
    @objc func logoutClicked(_: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

