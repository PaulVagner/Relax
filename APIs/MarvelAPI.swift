//
//  MarvelAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax


// Documentation : http://developer.marvel.com

public class MarvelAPI: API {
    
    public enum Endpoints: String {
        
        //Characters
        
        ///Fetches List of Characters
        case Characters
        ///Fetches a single character by id
        case CharacterId
        ///Fetches lists of comics filtered by a character id
        case CharacterIdComics
        ///Fetches lists of events filtered by a character id
        case CharacterIdEvents
        ///Fetches lists of series filtered by a character id
        case CharacterIdSeries
        ///Fetches lists of stories filtered by a character id
        case CharacterIdStories
        
        //Comics
        
        ///Fetches lists of comics
        case Comics
        ///Fetches a single comic by id
        case ComicId
        ///Fetches lists of characters filtered by a comic id
        case ComicIdCharacters
        ///Fetches lists of creators filtered by a comic id
        case ComicIdCreators
        ///Fetches lists of events filtered by a comic id
        case ComicIdEvents
        ///Fetches lists of stories filtered by a comic id
        case ComicIdStories
        
        //Creators
        
        ///Fetches lists of creators
        case Creators
        ///Fetches a single creator by id
        case CreatorId
        ///Fetches lists of comics filtered by a creator id
        case CreatorIdComics
        ///Fetches lists of events filtered by a creator id
        case CreatorIdEvents
        ///Fetches lists of series filtered by a creator id
        case CreatorIdSeries
        ///Fetches lists of stories filtered by a creator id
        case CreatorIdStories
        
        //Events
        
        ///Fetches lists of events
        case Events
        ///Fetches a single event by id
        case EventId
        ///Fetches lists of characters filtered by an event id
        case EventIdCharacter
        ///Fetches lists of comics filtered by an event id
        case EventIdComics
        ///Fetches lists of creators filtered by an event id
        case EventIdCreators
        ///Fetches lists of series filtered by an event id
        case EventIdSeries
        ///Fetches lists of stories filtered by an event id
        case EventIdStories
        
        //Series
        
        ///Fetches lists of series
        case Series
        ///Fetches a single comic series by id
        case SeriesId
        ///Fetches lists of characters filtered by a series id
        case SeiresIdCharacters
        ///Fetches lists of comics filtered by a series id
        case SeriesIdComics
        ///Fetches lists of creators filtered by a series id
        case SeriesIdCreators
        ///Fetches lists of events filtered by a series id
        case SeriesIdEvents
        ///Fetches lists of stories filtered by a series id
        case SeriesIdStories
        
        //Stories
        
        ///Fetches lists of stories
        case Stories
        ///Fetches a single comic story by id
        case StoryId
        ///Fetches lists of characters filtered by a story id
        case StoryIdCharacters
        ///Fetches lists of comics filtered by a story id
        case StoryIdComics
        ///Fetches lists of creators filtered by a story id
        case StoryIdCreators
        ///Fetches lists of events filtered by a story id
        case StoryIdEvents
        ///Fetches lists of series filtered by a story id
        case StoryIdSeries
        
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Characters
                
                .Characters : Endpoint(path: "characters"),
                .CharacterId : Endpoint(path: "characters/:character_Id"),
                .CharacterIdComics : Endpoint(path: "characters/:character_Id/comics"),
                .CharacterIdEvents : Endpoint(path: "characters/:character_Id/events"),
                .CharacterIdSeries : Endpoint(path: "characters/:character_Id/series"),
                .CharacterIdStories : Endpoint(path: "characters/:character_Id/stories")
            
                // Comics
                
                .Comics : Endpoint(path: "comics"),
                .ComicId : Endpoint(path: "comics/:comic_Id"),
                .ComicIdCharacters : Endpoint(path: "comics/:comic_Id/characters"),
                .ComicIdCreators : Endpoint(path: "comics/:comic_Id/creators"),
                .ComicIdEvents : Endpoint(path: "comics/:comic_Id/events"),
                .ComicIdStories : Endpoint(path: "comics/:comic_Id/stories")
            
                
                // Creators
                
                .Creators : Endpoint(path: "creators"),
                .CreatorId : Endpoint(path: "creators/:creator_Id"),
                .CreatorIdComics : Endpoint(path: "creators/:creator_Id/comics"),
                .CreatorIdEvents : Endpoint(path: "creators/:creator_Id/events"),
                .CreatorIdSeries : Endpoint(path: "creators/:creator_Id/series"),
                .CreatorIdStories : Endpoint(path: "creators/:creator_Id/stories")
                
                // Events
                
                .Events : Endpoint(path: "events"),
                .EventId : Endpoint(path: "events/:event_Id"),
                .EventIdCharacters : Endpoint(path: "events/:event_Id/characters"),
                .EventIdComics : Endpoint(path: "events/:event_Id/comics"),
                .EventIdCreators : Endpoint(path: "events/:event_Id/creators"),
                .EventIdSeries : Endpoint(path: "events/:event_Id/series"),
                .EventIdStories : Endpoint(path: "events/:event_Id/stories")
                
                // Series
                
                .Series : Endpoint(path: "series"),
                .SeriesId : Endpoint(path: "series/:series_Id"),
                .SeriesIdCharacters : Endpoint(path: "series/:series_Id/characters"),
                .SeriesIdComics : Endpoint(path: "series/:series_Id/comics"),
                .SeriesIdCreators : Endpoint(path: "series/:series_Id/creators"),
                .SeriesIdEvents : Endpoint(path: "series/:series_Id/events"),
                .SeriesIdStories : Endpoint(path: "series/:series_Id/stories")
                
                // Stories
                
                .Stories : Endpoint(path: "stories"),
                .StoryId : Endpoint(path: "stories/:story_Id"),
                .StoryIdCharacters : Endpoint(path: "stories/:story_Id/characters"),
                .StoryIdComics : Endpoint(path: "stories/:story_Id/comics"),
                .StoryIdCreators : Endpoint(path: "stories/:story_Id/creators"),
                .StoryIdEvents : Endpoint(path: "stories/:story_Id/events"),
                .StoryIdSeries : Endpoint(path: "stories/:story_Id/series"),
                
            
                
            ]
            
            
        }
        
    }
    
}

