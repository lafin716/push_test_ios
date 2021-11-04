//
//  ViewController.swift
//  test01
//
//  Created by wonjong hong on 2021/11/02.
//

import UIKit
import Firebase

@objc(ViewController)
class ViewController: UIViewController {
    @IBOutlet var fcmTokenMessage: UILabel!
    @IBOutlet var remoteFCMTokenMessage: UILabel!

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(displayFCMToken(notification:)),
            name: Notification.Name("FCMToken"),
            object: nil
        )
    }
    
    @IBAction func handleLogTokenTouch(_ sender: UIButton) {
        // [START log_fcm_reg_token]
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        // [END log_fcm_reg_token]
        fcmTokenMessage.text = "Logged FCM token: \(token ?? "")"

        // [START log_iid_reg_token]
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching remote FCM registration token: \(error)")
          } else if let token = token {
            print("파이어베이스 토큰 : \(token)")
            self.remoteFCMTokenMessage.text = "파이어베이스 토큰 : \(token)"
          }
        }
        // [END log_iid_reg_token]
      }

      @IBAction func handleSubscribeTouch(_ sender: UIButton) {
        // [START subscribe_topic]
        Messaging.messaging().subscribe(toTopic: "notify") { error in
          print("Subscribed to weather topic")
        }
        // [END subscribe_topic]
      }
    
      @IBAction func handleSubscribe(_ sender: Any) {
        // [START subscribe_topic]
        Messaging.messaging().subscribe(toTopic: "notify") { error in
          print("Subscribed to weather topic")
        }
        // [END subscribe_topic]
      }
    
      @objc func displayFCMToken(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        if let fcmToken = userInfo["token"] as? String {
            print("Received FCM token: \(fcmToken)")
        } else {
            print("Received FCM token: nil")
        }
      }


}

