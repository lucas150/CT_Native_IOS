//
//  ViewController.swift
//  CT_IOS_Try2
//
//  Created by Henil Gandhi on 07/02/25.
//

import UIKit
import CleverTapSDK
import SDWebImage
//import SignedCallSDK

class ViewController: UIViewController,CleverTapInboxViewControllerDelegate,CleverTapDisplayUnitDelegate {

    @IBOutlet weak var OnuserLoin: UIButton!
    @IBOutlet weak var event: UIButton!
    @IBOutlet weak var Inapp: UIButton!
    @IBOutlet weak var NativeDisplay: UIImageView!
    @IBOutlet weak var Inbox: UIButton!
    @IBOutlet weak var Native_Button: UIButton!
    @IBOutlet weak var Call: UIButton!
    
    
    @IBAction func Native_Button(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Native Display")
        
    }
        
    var latestDisplayUnit: CleverTapDisplayUnit?

//    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
//        print("🔹 Native Display Units Updated: \(displayUnits.count)")
//
//        for unit in displayUnits {
//            latestDisplayUnit = unit  // Store the latest unit
//
//            if let unitID = unit.unitID {
//                print("📢 Received Display Unit ID: \(unitID)")
//
//                let contents = unit.contents ?? []
//                for content in contents {
//                    if let imageUrl = content.mediaUrl {
//                        print("✅ Image URL: \(imageUrl)")
//
//                        DispatchQueue.main.async {
//                            self.NativeDisplay.sd_setImage(with: URL(string: imageUrl), completed: nil)
//
//                            // 🔹 Record Notification Viewed Event
//                            CleverTap.sharedInstance()?.recordDisplayUnitViewedEvent(forID: unitID)
//                            print("📢 Notification Viewed Event Recorded for ID: \(unitID)")
//                        }
//                    }
//                }
//            }
//        }
//    }



    
    
    
    @IBAction func SecondViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondcontroller = storyboard.instantiateViewController(withIdentifier:"SecondViewController") as! SecondViewController
        self.present(secondcontroller, animated: true, completion: nil)
    }
    
    @IBAction func OnUserLogin(_ sender: Any) {
        let profile: Dictionary<String, AnyObject> = [
            //Update pre-defined profile properties
            "name": "Henil Gandhi" as AnyObject,
            "email": "tettx@gmail.com" as AnyObject,
            "identity": 828 as AnyObject,
            //Update custom profile properties
            "Plan type": "Silver" as AnyObject,
            "Favorite Food": "Pizza" as AnyObject,
        ]

        CleverTap.sharedInstance()?.onUserLogin(profile)
    }
    
    @IBAction func eventpush(_ sender: Any) {
        
        CleverTap.sharedInstance()?.recordEvent("Internal Deep Link")
    }
    
    @IBAction func InApp(_ sender: Any) {
//        CleverTap.sharedInstance()?.recordEvent("In-app_2 Notification Triggered")
        CleverTap.sharedInstance()?.recordEvent("In-app Notification Triggered")

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
        print("🔹 Display Unit Delegate Set!")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nativeDisplayTapped(_:)))
           NativeDisplay.isUserInteractionEnabled = true  // Enable touch interaction
           NativeDisplay.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
//        NotificationCenter.default.addObserver(self, selector: #selector(self.callStatus(notification:)), name: NSNotification.Name(rawValue: "MessageReceived"), object: nil)
    }
    
//    @objc func callStatus(notification: Notification) {
//        let message = notification.userInfo?["callStatus"] as? SCCallStatus
//
//        if message == SCCallStatus.CALL_DECLINED {
//            print("📞 Call Declined")
//            //when the call is declined from the receiver's end
//
//        } else if message == SCCallStatus.CALL_MISSED {
//            print("📞 Call Missed")
//            //when the call is missed at the receiver's end
//
//        } else if message == SCCallStatus.CALL_OVER {
//            print("📞 Call Over - Disconnecting Signalling Socket")
//            SignedCall.disconnectSignallingSocket()
//            //when the call has been disconnected
//
//        }
//        else if message == SCCallStatus.CALL_ANSWERED {
//            print("📞 Call Answered")
//
//            // when call is answered
//
//        } else if message == SCCallStatus.CALLEE_BUSY_ON_ANOTHER_CALL {
//            print("📞 Receiver is Busy on Another Call")
//
//            //when the receiver is busy on another call
//
//        } else if message ==
//                    SCCallStatus.CALLEE_MICROPHONE_PERMISSION_NOT_GRANTED {
//            print("🚨 Microphone Permission Not Granted")
//
//            //this message is thrown if microphone permission is denied while receiving a call.
//        }
//    }
    @IBAction func Call(_ sender: Any) {
//        print("📞 Call Button Pressed")
//        let customMetaData = SCCustomMetadata(remoteContext: "String", initiatorImage: "String", receiverImage: "String")
//
//        let callOptions = SCCallOptionsModel(context: "String", receiverCuid: "String", customMetaData: customMetaData)
//
//        SignedCall.call(callOptions: callOptions) { result in
//                    switch result {
//                    case .success(let success):
//                        //Handle call initiated
//
//                    case .failure(let error):
//                        //Handle call failure
//                    }
//                }

        
    }
    
    @IBAction func nativeDisplayTapped(_ sender: UITapGestureRecognizer) {
        // 🔹 Ensure we have a valid `displayUnit`
        if let displayUnit = latestDisplayUnit, let unitID = displayUnit.unitID {
            CleverTap.sharedInstance()?.recordDisplayUnitClickedEvent(forID: unitID)
            print("📢 Notification Clicked Event Recorded for ID: \(unitID)")
        } else {
            print("⚠️ No Display Unit Available for Click Event")
        }
    }


    
    

    @IBAction func Inbox(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Inbox")
        // config the style of App Inbox Controller
        let style = CleverTapInboxStyleConfig.init()
        style.title = "App Inbox"
        style.backgroundColor = UIColor.orange
        style.messageTags = ["tag1", "tag2"]
        style.navigationBarTintColor = UIColor(red: 1.0, green: 0.7, blue: 0.4, alpha: 1.0)
        style.navigationTintColor = UIColor.black
        style.tabUnSelectedTextColor = UIColor.blue
        style.tabSelectedTextColor = UIColor.black
        style.tabSelectedBgColor = UIColor.white
        style.firstTabTitle = "My First Tab"
            
        if let inboxController = CleverTap.sharedInstance()?.newInboxViewController(with: style, andDelegate: self) {
            let navigationController = UINavigationController.init(rootViewController: inboxController)
                self.present(navigationController, animated: true, completion: nil)
          }
    }
    
    
}

