//
//  LAError.Code+Description.swift
//  SecureImage
//
//  Created by Adolfo Vera Blasco on 03/10/2018.
//  Copyright © 2018 desappstre {estudio}. All rights reserved.
//

import Foundation
import LocalAuthentication

extension LAError.Code
{
    ///
    var localizedDescription: String
    {
        switch self
        {
        case .appCancel:
            return "The app canceled authentication."
        case .systemCancel:
            return "The system canceled authentication."
        case .userCancel:
            return "The user tapped the cancel button in the authentication dialog."
        case .biometryLockout:
            return "Biometry is locked because there were too many failed attempts."
        case .biometryNotAvailable:
            return "Biometry is not available on the device."
        case .biometryNotEnrolled:
            return "The user has no enrolled biometric identities."
        case .authenticationFailed:
            return "The user failed to provide valid credentials."
        case .invalidContext:
            return "The context was previously invalidated."
        case .notInteractive:
            return "Displaying the required authentication user interface is forbidden."
        case .passcodeNotSet:
            return "A passcode isn’t set on the device."
        case .userFallback:
            return "No fallback is available for the authentication policy."
        default:
            return "Other reason..."
        }
    }
}
