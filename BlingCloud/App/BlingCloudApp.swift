//
//  BlingCloudApp.swift
//  BlingCloud
//
//  Created by RUMEN GUIN on 28/01/23.
//

import SwiftUI
import Firebase

@main
struct BlingCloudApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("log_Status") var status = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                if status {
                    //Home View
                    Home()
                }else {
                    NavigationView {
                        Login()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }
}

//initializing firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    //needed for firebase phone auth
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}
