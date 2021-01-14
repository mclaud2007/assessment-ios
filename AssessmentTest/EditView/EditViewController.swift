//
//  EditViewController.swift
//  AssessmentTest
//
//  Created by Михаил Юранов on 02.10.2020.
//  Copyright © 2020 Михаил Юранов. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, EditorViewInput {
        
    @IBOutlet weak var edit1: UITextField!
    @IBOutlet weak var edit2: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButtonBottomContraint: NSLayoutConstraint!
    
    var presenter: EditorViewPresenter?
    private var isKeyboardShown: Bool = false
    
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.subscribe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.subscribe()
    }
    
    deinit {
        self.unsubscribe()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        self.presenter?.didViewReady()
    }
    
    // MARK: Method
    func viewIsReady(notice: Notices?) {
        edit1.text = notice?.noticeTitle
        edit2.text = notice?.noticeText
    }
    
    // MARK: Action
    @IBAction func onClick(_ sender: Any) {
        let activityView = UIView(frame: view.bounds)
        activityView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        
        let activity = UIActivityIndicatorView(style: .large)
        activityView.addSubview(activity)
        activity.center = activityView.center
        
        view.addSubview(activityView)
        activity.startAnimating()
        
        self.presenter?.didAddButtonClicked(with: edit1.text ?? "", and: edit2.text ?? "")        
    }
}

// MARK: Keyboard
extension EditViewController {
    func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(willKeyboardShown(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(willKeyboardHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    func unsubscribe() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func willKeyboardShown(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo, !isKeyboardShown,
              let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? Constants.defaultKeyboardAnimationDuration
        let keyboardHeight = frameValue.cgRectValue.height
        
        scrollView.contentOffset.y -= keyboardHeight
        scrollView.contentInset.bottom += keyboardHeight
        isKeyboardShown = true
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.saveButtonBottomContraint.constant = -(keyboardHeight)
            self?.view.setNeedsLayout()
        }
    }

    @objc
    func willKeyboardHide(_ notification: NSNotification) {
        scrollView.contentInset = .zero
        isKeyboardShown = false
        
        guard let userInfo = notification.userInfo else {
            self.saveButtonBottomContraint.constant = Constants.defaultSaveButtonBottomOffset
            return
        }
        
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? Constants.defaultKeyboardAnimationDuration
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.saveButtonBottomContraint.constant = Constants.defaultSaveButtonBottomOffset
            self?.view.setNeedsLayout()
        }
        
    }
}

// MARK: Constants
private extension EditViewController {
    struct Constants {
        static let defaultKeyboardAnimationDuration: Double = 0.5
        static let defaultSaveButtonBottomOffset: CGFloat = -20
    }
}
