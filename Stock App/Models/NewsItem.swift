//
//  NewsItem.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

public class SearchResults : Decodable {
    var elements : [NewsItem]
    
    init() {
        elements = [NewsItem]()
    }
    
    init(items : [NewsItem]) {
        elements = items
    }
    
    enum CodingKeys : String, CodingKey {
        case elements = "elements"
    }
    
    required init?(coder aDecoder : Decoder) {
        do {
            let container = try aDecoder.container(keyedBy : CodingKeys.self)
            elements = try container.decode([NewsItem].self, forKey: .elements)
        } catch let err {
            elements = [NewsItem]()
            print("Error while parsing news array in SearchResults init(coder:) ", err)
        }
    }
}

public class NewsItem : Decodable {
    var id : String
    var publishDate : String
    var title : String
    var text : String
    
    var externalUrl : String
    //var nestedElems : NestedElementArray
    var nestedElems : [NestedElement]
    
    
    init() {
        id = ""
        publishDate = ""
        title = ""
        text = ""
        externalUrl = ""
        //nestedElems = NestedElementArray()
        nestedElems = [NestedElement]()
    }
    
    init(id : String, publishDate : String, title : String, text : String, externalUrl : String) {
        self.id = id
        self.publishDate = publishDate
        self.title = title
        self.text = text
        self.externalUrl = externalUrl
        //nestedElems = NestedElementArray()
        nestedElems = [NestedElement]()
    }
    
    init(id : String, publishDate : String, title : String, text : String, externalUrl : String, nestedElems : [NestedElement]) {
        self.id = id
        self.publishDate = publishDate
        self.title = title
        self.text = text
        self.externalUrl = externalUrl
        //self.nestedElems = NestedElementArray(elems: nestedElems)
        self.nestedElems = nestedElems
    }
    
    required init?(coder aDecoder: Decoder) {
        do {
            let container = try aDecoder.container(keyedBy : CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.publishDate = try container.decode(String.self, forKey: .publishDate)
            self.title = try container.decode(String.self, forKey: .title)
            self.text = try container.decode(String.self, forKey: .text)
            self.externalUrl = try container.decode(String.self, forKey: .externalUrl)
            
            self.nestedElems = try container.decode([NestedElement].self, forKey: .nestedElems)
            //self.nestedElems = try container.decode(NestedElementArray.self, forKey: .nestedElems)
        } catch let err {
            id = ""
            publishDate = ""
            title = ""
            text = ""
            externalUrl = ""
            
            nestedElems = [NestedElement]()
            //nestedElems = NestedElementArray()
            print("Error in decoding NewsItem ", err)
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case publishDate = "discoverDate"
        case title = "title"
        case text = "text"
        case externalUrl = "url"
        case nestedElems = "elements"
    }
}

class NestedElement : Decodable {
    var type : String
    var url : String
    
    enum CodingKeys : String, CodingKey {
        case type = "type"
        case url = "url"
    }
    
    init() {
        type = ""
        url = ""
    }
    
    init(type : String, url : String) {
        self.type = type
        self.url = url
    }
    
    required init?(coder aDecoder: Decoder) {
        do {
            let container = try aDecoder.container(keyedBy : CodingKeys.self)
            self.type = try container.decode(String.self, forKey: .type)
            self.url = try container.decode(String.self, forKey: .url)
            
        } catch let err {
            type = ""
            url = ""
            print("Error in decoding NestedElement ", err)
        }
    }
}

class NestedElementArray : Decodable {
    var elements : [NestedElement]
    
    init() {
        elements = [NestedElement]()
    }
    
    init(elems : [NestedElement]) {
        elements = elems
    }
    
    required init?(coder aDecoder: Decoder) {
        do {
            let container = try aDecoder.container(keyedBy : CodingKeys.self)
            self.elements = try container.decode([NestedElement].self, forKey: .elements)
            
        } catch let err {
            self.elements = [NestedElement]()
            print("Error in decoding NestedElement ", err)
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case elements = "elements"
    }
}
