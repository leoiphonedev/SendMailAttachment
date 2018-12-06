//
//  ViewController.swift
//  SendMailAttachment
//
//  Created by Aman Aggarwal on 03/12/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.setSubject("Update about ios tutorials")
            mailComposer.setMessageBody("What is the update about ios tutorials on youtube", isHTML: false)
            mailComposer.setToRecipients(["abc@test.com"])
            guard let filePath = Bundle.main.path(forResource: "SimplePDF", ofType: "pdf") else {
                return
            }
            let url = URL(fileURLWithPath: filePath)
            
            do {
            let attachmentData = try Data(contentsOf: url)
                mailComposer.addAttachmentData(attachmentData, mimeType: "application/pdf", fileName: "SimplePDF")
                mailComposer.mailComposeDelegate = self
                self.present(mailComposer, animated: true
                    , completion: nil)
            } catch let error {
                print("We have encountered error \(error.localizedDescription)")
            }
            
           
            
            
        } else {
            print("Email is not configured in settings app or we are not able to send an email")
        }
    }
    
    //MARK:- MailcomposerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("User cancelled")
            break
            
        case .saved:
            print("Mail is saved by user")
            break
            
        case .sent:
            print("Mail is sent successfully")
            break
            
        case .failed:
            print("Sending mail is failed")
            break
        default:
            break
        }
        
        controller.dismiss(animated: true) 
        
    }


}

