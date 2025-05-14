//
//  SceneDelegate.swift
//  CT_Native_IOS
//
//  Created by Henil Gandhi on 14/05/25.


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(identifier: "MainNavigationController") as? UINavigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        // Handle deep link if app is launched with a URL
        if let url = connectionOptions.urlContexts.first?.url {
          handleDeepLink(url)
        }
      }


    func handleDeepLink(_ url:URL){
       
        if url.scheme?.lowercased() == "ctsecond", url.host == "secondpage" {
            print("[Scene Deligate] Handling deep link for: \(url.absoluteString)")
            navigateToSecondPage()
        }
        
        
        if url.scheme?.lowercased() == "ctsecond", url.host == "firstpage" {
            print("[Scene Deligate] Handling deep link for: \(url.absoluteString)")
            navigateToFirstPage()
        }
    }
    





    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else { return }
        let url = urlContext.url
        print("[Sceene Deligate] Received URL: \(url)")
        
        handleDeepLink(url)
    }
    
    func navigateToSecondPage() {
        print("[Navigation] Navigating to Second Page")

        if let rootViewController = window?.rootViewController {
            // Dismiss any existing modals before presenting a new view
            rootViewController.dismiss(animated: true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
                    rootViewController.present(secondVC, animated: true)
                }
            }
        }
    }

    
    func navigateToFirstPage() {
           print("[Scene Deligate] Navigating to First Page")
           
           if let rootViewController = window?.rootViewController {
               rootViewController.dismiss(animated: true) {
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   if let secondVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                       rootViewController.present(secondVC, animated: true)
                   }
               }
           }
       }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
//    func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
//          print("Push Notification Tapped with Custom Extras: \(customExtras)")
//        CleverTap.sharedInstance()?.suspendInAppNotifications()
//    }


}

