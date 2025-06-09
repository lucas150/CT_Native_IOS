//
//  LiveActivityManager.swift
//  CT_Native_IOS
//
//  Created by Henil Gandhi on 03/06/25.
//
import ActivityKit
import Combine
import Foundation

final class ActivityManager: ObservableObject {
    @MainActor @Published private(set) var activityID: String?
    @MainActor @Published private(set) var activityToken: String?
    
    static let shared = ActivityManager()
    
    func start() async {
        await endActivity()
        await startNewLiveActivity()
    }
    
    private func startNewLiveActivity() async {
        let attributes = MatchScoreAttributes(homeTeam: "Badger",
                                                  awayTeam: "Lion",
                                                  date: "12/09/2023")
        
        let initialContentState = ActivityContent(state: MatchScoreAttributes.ContentState(homeTeamScore: 0,
                                                                                               awayTeamScore: 0,
                                                                                               lastEvent: "Match Start"),
                                                  staleDate: nil)
        
        let activity = try? Activity.request(
            attributes: attributes,
            content: initialContentState,
            pushType: .token
        )
        
        guard let activity = activity else {
            return
        }
        await MainActor.run { activityID = activity.id }
        
        for await data in activity.pushTokenUpdates {
            let token = data.map {String(format: "%02x", $0)}.joined()
            print("Activity token: \(token)")
            await MainActor.run { activityToken = token }
            // HERE SEND THE TOKEN TO THE SERVER
        }
    }
    
    func updateActivityRandomly() async {
        guard let activityID = await activityID,
              let runningActivity = Activity<MatchScoreAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
        }
        let newRandomContentState = MatchScoreAttributes.ContentState(homeTeamScore: Int.random(in: 1...9),
                                                                          awayTeamScore: Int.random(in: 1...9),
                                                                          lastEvent: "Something random happened!")
        await runningActivity.update(using: newRandomContentState)
    }
    
    func endActivity() async {
        guard let activityID = await activityID,
              let runningActivity = Activity<MatchScoreAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
        }
        let initialContentState = MatchScoreAttributes.ContentState(homeTeamScore: 0,
                                                                        awayTeamScore: 0,
                                                                        lastEvent: "Match Start")

        await runningActivity.end(
            ActivityContent(state: initialContentState, staleDate: Date.distantFuture),
            dismissalPolicy: .immediate
        )
        
        await MainActor.run {
            self.activityID = nil
            self.activityToken = nil
        }
    }
    
    func cancelAllRunningActivities() async {
        for activity in Activity<MatchScoreAttributes>.activities {
            let initialContentState = MatchScoreAttributes.ContentState(homeTeamScore: 0,
                                                                            awayTeamScore: 0,
                                                                            lastEvent: "Match Start")
            
            await activity.end(
                ActivityContent(state: initialContentState, staleDate: Date()),
                dismissalPolicy: .immediate
            )
        }
        
        await MainActor.run {
            activityID = nil
            activityToken = nil
        }
    }
    
}
