//
//  SecondViewController.swift
//  CT_IOS_Try2
//
//  Created by Henil Gandhi on 28/02/25.
//

import UIKit
import UIKit
import ActivityKit
import UserNotifications

public struct PeriodInfo: Codable, Hashable {
    public let name: String
    public let currentTime: Date
    public let timeLeft: TimeInterval

    public var endTime: Date { currentTime.addingTimeInterval(timeLeft) }

    public init(name: String, currentTime: Date, timeLeft: TimeInterval) {
        self.name = name
        self.currentTime = currentTime
        self.timeLeft = timeLeft
    }
}


class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        print("📢 Second View Controller is being showned")
    }
    
    @IBOutlet weak var Done: UIButton!
    @IBAction func Done(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }

    @IBOutlet weak var LiveActivity: UIButton!
//    @IBAction func LiveActivity(_ sender: Any) {
//        let demoContent = DemoContent()
//
//        if currentActivity == nil {
//            startActivity()
//
//            // After starting, update with first state after a delay
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
//                guard let self = self else { return }
//                let newState = demoContent.matchStart()
//                self.updateActivity(with: newState)
//            }
//        } else {
//            // If already started, update with a new state
//            let newState = demoContent.firstGoal()
//            updateActivity(with: newState)
//        }
//    }


    

//
//    var currentActivity: Activity<ScoreActivityAttributes>?
//
//    func startActivity() {
//        let blueTeam = ScoreActivityAttributes.Team(name: "Blue Team", imageName: "blue_team_image")
//        let redTeam = ScoreActivityAttributes.Team(name: "Red Team", imageName: "red_team_image")
//
//        let attrs = ScoreActivityAttributes(blueTeam: blueTeam, redTeam: redTeam, matchStartTime: Date())
//
//        let initialContent = ScoreActivityAttributes.ContentState(
//            matchState: .notYetStarted,
//            blueTeamScore: 0,
//            redTeamScore: 0
//        )
//
//        let content = ActivityContent(state: initialContent, staleDate: nil)
//
//        do {
//            currentActivity = try Activity.request(attributes: attrs, content: content, pushType: .token)
//            print("Started activity: \(currentActivity!.id)")
//        } catch {
//            print("Failed to start activity: \(error)")
//        }
//    }

//    func updateActivity(with newState: ScoreActivityAttributes.ContentState) {
//        guard let activity = currentActivity else { return }
//
//        Task {
//            let content = ActivityContent(state: newState, staleDate: nil)
//            await activity.update(content)
//            print("Activity updated")
//        }
//    }

//    func finishActivity() {
//        guard let activity = currentActivity else { return }
//
//        Task {
//            let finalState = ScoreActivityAttributes.ContentState(
//                matchState: .finished,
//                blueTeamScore: 2,
//                redTeamScore: 1
//            )
//            await activity.end(ActivityContent(state: finalState, staleDate: nil))
//            currentActivity = nil
//            print("Activity ended")
//        }
//    }
}
