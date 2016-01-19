//
//  MarvelAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax
import CryptoSwift

// Documentation : http://developer.marvel.com

private let _m = MarvelAPI()

public class MarvelAPI: API {
    
    public override class func session() -> MarvelAPI { return _m }
    
    var ts: String { return "\(Int(NSDate().timeIntervalSince1970))" }
    var hash: String { return "\(ts)\(MARVEL_CLIENT_SECRET)\(MARVEL_CLIENT_ID)".md5() }
    
    public override func start() {
        
        baseURL = "https://gateway.marvel.com/v1/public/"
        authTokenKey = "Marvel"
        authBasic = [
            
            "apikey" : MARVEL_CLIENT_ID,
            "ts" : ts,
            "hash" : hash
            
        ]
        
    }
    
    public enum Endpoints: String {
        
        // Characters
        
        /// Fetches List of Characters
        case Characters
        /// Fetches a single character by :character_id
        case CharacterId
        /// Fetches lists of comics filtered by a :character_id
        case CharacterIdComics
        /// Fetches lists of events filtered by a :character_id
        case CharacterIdEvents
        /// Fetches lists of series filtered by a :character_id
        case CharacterIdSeries
        /// Fetches lists of stories filtered by a :character_id
        case CharacterIdStories
        
        // Comics
        
        /// Fetches lists of comics
        case Comics
        /// Fetches a single comic by :comic_id
        case ComicId
        /// Fetches lists of characters filtered by a :comic_id
        case ComicIdCharacters
        /// Fetches lists of creators filtered by a :comic_id
        case ComicIdCreators
        /// Fetches lists of events filtered by a :comic_id
        case ComicIdEvents
        /// Fetches lists of stories filtered by a :comic_id
        case ComicIdStories
        
        // Creators
        
        /// Fetches lists of creators
        case Creators
        /// Fetches a single creator by :creator_id
        case CreatorId
        /// Fetches lists of comics filtered by a :creator_id
        case CreatorIdComics
        /// Fetches lists of events filtered by a :creator_id
        case CreatorIdEvents
        /// Fetches lists of series filtered by a :creator_id
        case CreatorIdSeries
        /// Fetches lists of stories filtered by a :creator_id
        case CreatorIdStories
        
        // Events
        
        /// Fetches lists of events
        case Events
        /// Fetches a single event by :event_id
        case EventId
        /// Fetches lists of characters filtered by an :event_id
        case EventIdCharacters
        /// Fetches lists of comics filtered by an :event_id
        case EventIdComics
        /// Fetches lists of creators filtered by an :event_id
        case EventIdCreators
        /// Fetches lists of series filtered by an :event_id
        case EventIdSeries
        /// Fetches lists of stories filtered by an :event_id
        case EventIdStories
        
        // Series
        
        /// Fetches lists of series
        case Series
        /// Fetches a single comic series by :series_id
        case SeriesId
        /// Fetches lists of characters filtered by a :series_id
        case SeriesIdCharacters
        /// Fetches lists of comics filtered by a :series_id
        case SeriesIdComics
        /// Fetches lists of creators filtered by a :series_id
        case SeriesIdCreators
        /// Fetches lists of events filtered by a :series_id
        case SeriesIdEvents
        /// Fetches lists of stories filtered by a :series_id
        case SeriesIdStories
        
        // Stories
        
        /// Fetches lists of stories
        case Stories
        /// Fetches a single comic story by :story_id
        case StoryId
        /// Fetches lists of characters filtered by a :story_id
        case StoryIdCharacters
        /// Fetches lists of comics filtered by a :story_id
        case StoryIdComics
        /// Fetches lists of creators filtered by a :story_id
        case StoryIdCreators
        /// Fetches lists of events filtered by a :story_id
        case StoryIdEvents
        /// Fetches lists of series filtered by a :story_id
        case StoryIdSeries
        
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Characters
                
                .Characters : Endpoint(path: "characters"),
                .CharacterId : Endpoint(path: "characters/:character_id"),
                .CharacterIdComics : Endpoint(path: "characters/:character_id/comics"),
                .CharacterIdEvents : Endpoint(path: "characters/:character_id/events"),
                .CharacterIdSeries : Endpoint(path: "characters/:character_id/series"),
                .CharacterIdStories : Endpoint(path: "characters/:character_id/stories"),
            
                // Comics
                
                .Comics : Endpoint(path: "comics"),
                .ComicId : Endpoint(path: "comics/:comic_id"),
                .ComicIdCharacters : Endpoint(path: "comics/:comic_id/characters"),
                .ComicIdCreators : Endpoint(path: "comics/:comic_id/creators"),
                .ComicIdEvents : Endpoint(path: "comics/:comic_id/events"),
                .ComicIdStories : Endpoint(path: "comics/:comic_id/stories"),
            
                
                // Creators
                
                .Creators : Endpoint(path: "creators"),
                .CreatorId : Endpoint(path: "creators/:creator_id"),
                .CreatorIdComics : Endpoint(path: "creators/:creator_id/comics"),
                .CreatorIdEvents : Endpoint(path: "creators/:creator_id/events"),
                .CreatorIdSeries : Endpoint(path: "creators/:creator_id/series"),
                .CreatorIdStories : Endpoint(path: "creators/:creator_id/stories"),
                
                // Events
                
                .Events : Endpoint(path: "events"),
                .EventId : Endpoint(path: "events/:event_id"),
                .EventIdCharacters : Endpoint(path: "events/:event_id/characters"),
                .EventIdComics : Endpoint(path: "events/:event_id/comics"),
                .EventIdCreators : Endpoint(path: "events/:event_id/creators"),
                .EventIdSeries : Endpoint(path: "events/:event_id/series"),
                .EventIdStories : Endpoint(path: "events/:event_id/stories"),
                
                // Series
                
                .Series : Endpoint(path: "series"),
                .SeriesId : Endpoint(path: "series/:series_id"),
                .SeriesIdCharacters : Endpoint(path: "series/:series_id/characters"),
                .SeriesIdComics : Endpoint(path: "series/:series_id/comics"),
                .SeriesIdCreators : Endpoint(path: "series/:series_id/creators"),
                .SeriesIdEvents : Endpoint(path: "series/:series_id/events"),
                .SeriesIdStories : Endpoint(path: "series/:series_id/stories"),
                
                // Stories
                
                .Stories : Endpoint(path: "stories"),
                .StoryId : Endpoint(path: "stories/:story_id"),
                .StoryIdCharacters : Endpoint(path: "stories/:story_id/characters"),
                .StoryIdComics : Endpoint(path: "stories/:story_id/comics"),
                .StoryIdCreators : Endpoint(path: "stories/:story_id/creators"),
                .StoryIdEvents : Endpoint(path: "stories/:story_id/events"),
                .StoryIdSeries : Endpoint(path: "stories/:story_id/series")
                
            ]
            
        }
        
    }
    
}

