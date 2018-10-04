//
//  ViewController.swift
//  SecureImage
//
//  Created by Adolfo Vera Blasco on 03/10/2018.
//  Copyright © 2018 desappstre {estudio}. All rights reserved.
//

import UIKit
import Foundation
import LocalAuthentication

internal class SecureViewController: UIViewController
{
    ///
    @IBOutlet private weak var imageViewSecret: UIImageView!
    ///
    @IBOutlet private weak var blurredView: UIVisualEffectView!
    ///
    @IBOutlet private weak var buttonUnlock: UIButton!
    
    ///
    private var authenticationContext: LAContext?
    
    //
    // MARK: - Life Cycle
    //
    
    /**
     
     */
    override internal func viewDidLoad() -> Void
    {
        super.viewDidLoad()
        
        //self.authenticationContext = LAContext()
        //self.authenticationContext?.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
    
    /**
     
     */
    override internal func viewWillAppear(_ animated: Bool) -> Void
    {
        super.viewWillAppear(animated)
        
        self.prepareUI()
    }
    
    //
    // MARK: - UI Methods
    //
    
    /**
     
     */
    private func prepareUI() -> Void
    {
        self.buttonUnlock.tintColor = UIColor.white
        self.buttonUnlock.backgroundColor = UIColor.black
        self.buttonUnlock.layer.cornerRadius = 8.0
        self.buttonUnlock.layer.masksToBounds = true
        
        self.blurredView.layer.cornerRadius = 8.0
        self.blurredView.layer.masksToBounds = true
        
        self.imageViewSecret.layer.cornerRadius = 8.0
        self.imageViewSecret.layer.masksToBounds = true
    }
    
    //
    // MARK : -Animations
    //
    
    /**
     
     */
    private func presentImage() -> Void
    {
        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .easeOut)
        
        animator.addAnimations() {
            self.blurredView.alpha = 0.0
        }
        
        animator.startAnimation()
    }
    
    /**
     
     */
    private func hideImage() -> Void
    {
        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .easeOut)
        
        animator.addAnimations() {
            self.blurredView.alpha = 1.0
        }
        
        animator.startAnimation()
    }
    
    //
    // MARK: - Actions
    //
    
    /*
     
     */
    @IBAction private func handleUnlockButtonTap(sender: UIButton) -> Void
    {
        // Get a fresh context for each login. If you use the same context on multiple attempts
        //  (by commenting out the next line), then a previously successful authentication
        //  causes the next policy evaluation to succeed without testing biometry again.
        //  That's usually not what you want.
        self.authenticationContext = LAContext()
        
        var errorPolicy: NSError?
        
        if let authenticationContext = self.authenticationContext,
           authenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &errorPolicy)
        {
            authenticationContext.localizedCancelTitle = NSLocalizedString("CONTEXT_CANCEL_TITLE", comment: "")
            authenticationContext.localizedFallbackTitle = NSLocalizedString("CONTEXT_FALLBACK_TITLE", comment: "")
            
            let authenticationReason = NSLocalizedString("CONTEXT_REASON", comment: "")
            
            authenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: authenticationReason ) { (success: Bool, error: Error?) -> Void in
                if success
                {
                    print(NSLocalizedString("AUTHENTICATION_SUCCESS_MESSAGE", comment: ""))
                    
                    DispatchQueue.main.async
                    {
                        self.presentImage()
                    }
                }
                else
                {
                    if let error = error
                    {
                        print(error.localizedDescription)
                        
                        if let contextError = LAError.Code(rawValue: error._code)
                        {
                            print(contextError.localizedDescription)
                        }
                        
                        DispatchQueue.main.async
                        {
                            self.hideImage()
                        }
                    }
                    else
                    {
                        print(NSLocalizedString("AUTHENTICATION_ERROR_MESSAGE", comment: ""))
                        
                        DispatchQueue.main.async
                        {
                            self.hideImage()
                        }
                    }
                }
            }
        }
        else
        {
            let message = errorPolicy?.localizedDescription ?? NSLocalizedString("AUTHENTICATION_POLICY_ERROR_MESSAGE", comment: "")
            print(message)
        }
    }}

