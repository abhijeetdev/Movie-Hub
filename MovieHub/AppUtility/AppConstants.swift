//
//  AppConstants.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 08/12/2023.
//


import UIKit

struct Colors {
    static let appGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
}

struct Key {
    struct ReusableIdentifiers {
        static let movieCell = "MovieCell"
    }
    
    struct NibNames {
        static let peopleCell = "PeopleCell"
        static let SectionHeaderTextReusableView = "SectionHeaderTextReusableView"
    }
}

struct Strings {
    static let YOUTUBE = "YouTube"
    static let DIRECTOR = "director"
    static let PRODUCER = "producer"
    static let STORY = "story"
    static let NA = "n/a"
    static let TAB_ONE_TITLE = "Movie"
    static let TAB_TWO_TITLE = "Search"
    static let STARTING = "Starting"
    static let DIRECTOS = "Dirctor(s)"
    static let PRODUCERS = "Producers(s)"
    static let SCREEN_WRITES = "ScreenWriter(s)"
    static let TRAILERS = "Trailers"
    static let DASH = "-"
    static let APP_TITLE = "Movie Hub"
}
