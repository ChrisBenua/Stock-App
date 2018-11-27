//
//  APIHelper.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import Alamofire
/// APIHelper for newsriver
class APIHelper {
    
    static var shared = APIHelper()
    
    static var QueryURL = "https://api.newsriver.io/v2/search?"
    //for testing
    /*static let json = """
    {
    "elements": [
            {
            "id": "nxtpzcbw_EqZVMpMEpE4TPMJGWlIInUFxEbv3Wb5D_dm1Q9xWLCj8QgZs_5a_qgjOw5amhs6HLCnknMrc1JDtA",
            "discoverDate": "2018-11-25T21:07:50.184+0000",
            "title": "Search For The Missing In California Wildfires Continues",
            "language": "en",
            "text": "More than two weeks after the nation's worst fire in a century erupted in Northern California, crews are still trying to find hundreds of people. The Camp Fire has claimed at least 85 lives and, as of Sunday, is 100 percent contained. But now dozens of disaster workers from across the country are coming to the town of Paradise to help out with the search mission. About two dozen search-and-rescue personnel in white jumpsuits and hardhats, wearing respirators walk through the ash-covered debris in Paradise. There are the remnants of some metal furniture. A fireplace is still standing. The whole search crew is just waiting to see if the cadaver dog finds any human remains. Chuck Williams with the Orange County Sheriff's Department is the cadaver dog handler. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck. \\"What we're hunting for is so minute,\\" says Williams, \\"Now if there is more remnants, the dogs can absolutely function, but the water has not helped the dogs.\\" This process could take months. The burn scar of the Camp Fire is immense: 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters and still, this scene takes him aback. \\"The magnitude,\\" he says. \\"It's like being in a war zone. It's like watching a war movie, unfortunately.\\" When remains are found, they are sent to a mortuary in Sacramento, where forensics experts try to identify them. Then they'll be returned to loved ones. Before Williams and his team embarked on the mission, they were debriefed by anthropologist Colleen Milligan. She's works with the Chico State Human Identification lab. She says many remains are found in places that suggest the victims were attempting to escape. \\"We're talking about front doors and porches. Those are most likely individuals leaving or trying to leave,\\" she says. As Williams searched street after street of Paradise, another thing quickly jumped out at him: the remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot: \\"Just by the level of ash. There's was literally nothing left. It had almost been like through a cremation process.\\" Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is just one of several other dire concerns, like finding a home, sometimes finding a job and for many of then, joining a new community. Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out and he hasn't been back since. When Grimm first looked at the missing list, his saw the name of his friend, who he knew made it out. \\"So we got a hold of his son, and his son said, ' Yeah, dad's OK,' And I said, well, you call your dad and tell him get his name off that list, give him a big hug for me. And let him know, even in the bad days, today's a good day because you're alive.\\" Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend wont' be the last. \\"All I have is hope,\\" he says, \\"That's all I have is hope.\\" Butte County officials have been equally as optimistic. But they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost. SACHA PFEIFFER, HOST: More than two weeks after the nation's deadliest fire in a century erupted in Northern California, crews are still trying to find hundreds of people. The Camp Fire has killed at least 85. It's now fully contained. But dozens of disaster workers from across the country are coming to the town of Paradise to help with the search mission. NPR's Bobby Allyn is there and followed a team of searchers as they scoured the incinerated city. BOBBY ALLYN, BYLINE: There's about two dozen search-and-rescue personnel in white jumpsuits and hardhats wearing respirators. You can see the remnants of some metal furniture, looks like a fireplace that is still standing. And the whole search crew is just waiting to see if the cadaver dog finds any human remains. Chuck Williams is the cadaver dog handler. He came up from the Orange County Sheriff's Department. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck. CHUCK WILLIAMS: What we're hunting for is so minute. Now, if there's more remnants, the dogs can absolutely function. But the water has not helped the dogs. ALLYN: This process could take months. The burn scar of the Camp Fire is immense - 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters. And still, this scene takes him aback. WILLIAMS: The magnitude - it's like being in a war zone. And it's like watching a war movie, unfortunately. ALLYN: When remains are found, they are sent to a mortuary in Sacramento where forensics experts try to identify them. Then they'll be returned to loved ones. As Williams searched street after street of Paradise, another thing quickly jumped out at him. The remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot. WILLIAMS: Just by the level of ash - there was literally nothing left. It had just almost been, like, through a cremation process. ALLYN: Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is being juggled with several other dire concerns, like finding a home, sometimes finding a job and, for many of them, joining a new community. Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out, and he hasn't been back since. When Grimm first looked at the missing list, he saw the name of his friend, who he knew made it out. BOB GRIMM: So we got a hold of his son, and his son said, yeah, dad's OK. And I said, well, you call your dad and tell him get his name off that list. Give him a big hug for me. And then also let him know that even in the bad days, today's a good day because you're alive. ALLYN: Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend won't be the last. GRIMM: All I have is hope. That's all I have is hope. ALLYN: Butte County officials have been equally as optimistic, but they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost. Bobby Allyn, NPR News, Paradise, Calif. Transcript provided by NPR, Copyright NPR.",
            "structuredText": "<div> \\n <p>More than two weeks after the nation's worst fire in a century erupted in Northern California, crews are still trying to find hundreds of people. </p> \\n <p>The Camp Fire has claimed at least 85 lives and, as of Sunday, is 100 percent contained. But now dozens of disaster workers from across the country are coming to the town of Paradise to help out with the search mission. </p> \\n <p>About two dozen search-and-rescue personnel in white jumpsuits and hardhats, wearing respirators walk through the ash-covered debris in Paradise. There are the remnants of some metal furniture. A fireplace is still standing. The whole search crew is just waiting to see if the cadaver dog finds any human remains. </p> \\n <p>Chuck Williams with the Orange County Sheriff's Department is the cadaver dog handler. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck. </p> \\n <p>\\"What we're hunting for is so minute,\\" says Williams, \\"Now if there is more remnants, the dogs can absolutely function, but the water has not helped the dogs.\\" </p> \\n <p>This process could take months. The burn scar of the Camp Fire is immense: 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters and still, this scene takes him aback. \\"The magnitude,\\" he says. \\"It's like being in a war zone. It's like watching a war movie, unfortunately.\\" </p> \\n <p>When remains are found, they are sent to a mortuary in Sacramento, where forensics experts try to identify them. Then they'll be returned to loved ones. </p> \\n <p>Before Williams and his team embarked on the mission, they were debriefed by anthropologist Colleen Milligan. She's works with the Chico State Human Identification lab. She says many remains are found in places that suggest the victims were attempting to escape. \\"We're talking about front doors and porches. Those are most likely individuals leaving or trying to leave,\\" she says. </p> \\n <p>As Williams searched street after street of Paradise, another thing quickly jumped out at him: the remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot: \\"Just by the level of ash. There's was literally nothing left. It had almost been like through a cremation process.\\" </p> \\n <p>Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is just one of several other dire concerns, like finding a home, sometimes finding a job and for many of then, joining a new community. </p> \\n <p>Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out and he hasn't been back since. </p> \\n <p>When Grimm first looked at the missing list, his saw the name of his friend, who he knew made it out. \\"So we got a hold of his son, and his son said, ' Yeah, dad's OK,' And I said, well, you call your dad and tell him get his name off that list, give him a big hug for me. And let him know, even in the bad days, today's a good day because you're alive.\\" </p> \\n <p>Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend wont' be the last. \\"All I have is hope,\\" he says, \\"That's all I have is hope.\\" </p> \\n <p>Butte County officials have been equally as optimistic. But they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost.<br></p> \\n <p> </p> \\n <p>SACHA PFEIFFER, HOST: </p> \\n <p>More than two weeks after the nation's deadliest fire in a century erupted in Northern California, crews are still trying to find hundreds of people. The Camp Fire has killed at least 85. It's now fully contained. But dozens of disaster workers from across the country are coming to the town of Paradise to help with the search mission. NPR's Bobby Allyn is there and followed a team of searchers as they scoured the incinerated city.</p> \\n <p>BOBBY ALLYN, BYLINE: There's about two dozen search-and-rescue personnel in white jumpsuits and hardhats wearing respirators. You can see the remnants of some metal furniture, looks like a fireplace that is still standing. And the whole search crew is just waiting to see if the cadaver dog finds any human remains.</p> \\n <p>Chuck Williams is the cadaver dog handler. He came up from the Orange County Sheriff's Department. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck.</p> \\n <p>CHUCK WILLIAMS: What we're hunting for is so minute. Now, if there's more remnants, the dogs can absolutely function. But the water has not helped the dogs.</p> \\n <p>ALLYN: This process could take months. The burn scar of the Camp Fire is immense - 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters. And still, this scene takes him aback.</p> \\n <p>WILLIAMS: The magnitude - it's like being in a war zone. And it's like watching a war movie, unfortunately.</p> \\n <p>ALLYN: When remains are found, they are sent to a mortuary in Sacramento where forensics experts try to identify them. Then they'll be returned to loved ones. As Williams searched street after street of Paradise, another thing quickly jumped out at him. The remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot.</p> \\n <p>WILLIAMS: Just by the level of ash - there was literally nothing left. It had just almost been, like, through a cremation process.</p> \\n <p>ALLYN: Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is being juggled with several other dire concerns, like finding a home, sometimes finding a job and, for many of them, joining a new community. Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out, and he hasn't been back since. When Grimm first looked at the missing list, he saw the name of his friend, who he knew made it out.</p> \\n <p>BOB GRIMM: So we got a hold of his son, and his son said, yeah, dad's OK. And I said, well, you call your dad and tell him get his name off that list. Give him a big hug for me. And then also let him know that even in the bad days, today's a good day because you're alive.</p> \\n <p>ALLYN: Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend won't be the last.</p> \\n <p>GRIMM: All I have is hope. That's all I have is hope.</p> \\n <p>ALLYN: Butte County officials have been equally as optimistic, but they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost. Bobby Allyn, NPR News, Paradise, Calif. Transcript provided by NPR, Copyright NPR.</p> \\n</div>",
            "url": "http://www.kbbi.org/post/search-missing-california-wildfires-continues",
            "elements": [
              {
                "type": "Image",
                "primary": true,
                "url": "http://mediad.publicbroadcasting.net/p/shared/npr/styles/medium/nprshared/201811/670681027.jpg",
                "width": null,
                "height": null,
                "title": null,
                "alternative": null
              }
            ],
            "metadata": {
              "finSentiment": {
                "type": "finSentiment",
                "sentiment": -0.02
              },
              "readTime": {
                "type": "readTime",
                "seconds": 272
              }
            },
            "highlight": " what was once rolling vineyards, <highlighted>apple</highlighted> orchards and rows of evergreen trees. Williams has spent his",
            "score": 3.7169688
          },
          {
            "id": "NQmvWd6Km0WE2xQGthmMtOlkv1JeRotpDSVUZS4ONl9kBPa_aBK0FgUyWq1Kv-93ReaRePi3ugXqz95oocZhxQ",
            "discoverDate": "2018-11-25T21:05:51.896+0000",
            "title": "9 Restaurants Open on Christmas Day in NYC",
            "language": "en",
            "text": "By Holly Cole on November 23, 2018 Celebrating Christmas day in the big apple? Then you'll need to check out our list of restaurants open on Christmas day in NYC! While you won't have the run of every restaurant in town, with a little planning you can still feast out with family or friends in an eclectic selection of restaurants and soak up some festive spirit. From Michelin starred dining to casual eateries, here are the best NYC restaurants open for Christmas. Take your pick of dishes, from spaghetti to dim sum and caviar to fried chicken. Find French and Italian influence food inside the swanky Langham Hotel overlooking 5th Avenue. There's a four-course prix fixe menu for $150 or tasting menu for $250 with no turkey! Ai Fiori 400 5th Avenue 2nd Level, The Langham NYC, New York City, NY 10018   Website For Chinese fine dining head to Red Farm for a dim sum lunch in the convivial dining area seated at farmhouse style banquet tables. Red Farm 2170 Broadway, New York, NY 10024  Website Dine on European style French fare at Alain Ducasse's New York re-incarnation. The Christmas menu boasts firm favourites like lobster salad, seared scallops and softly spiced duck breast for $95 a head. Benoit New York 60 West 55thstreetNew York, NY 10019 Website   Really splashing out? Try dining in two Michelin star style at this sophisticated urban restaurant where the menu focuses on Korean cooking technique with locally sourced ingredients. Jungsik 2 Harrison Street, New York, NY 10013  Website Go green with Georges Vongerichten’s carefully sourced haute cuisine and enjoy a guilt-free Christmas. ABC Kitchen 35 east 18th street new york, NY10003 Website   For hearty comfort fare with flair check out Samuelsson's Harlem eatery and let the good times roll. Red Rooster 310 Lenox Avenue (between 125th and 126th) Harlem, NY 10027 Website   Discover what chef Christina Leckihas created on the special four-course prix-fixe Christmas day menu for $105 a head. Wythe Hotel 80 Wythe Ave, Brooklyn, NY 11249 Website Soak up the festive spirit in this cosy gastropub preparing a special Christmas menu for the occasion. The Breslin Bar and Dining Room 16 west 29th street new york, new york 10001 Website For a relaxed neighbourhood vibe head to this Brooklyn institute which has been serving up locally sourced food, pizzas and beers since it first opened in 2008.  Roberta's 261 Moore Street, Brooklyn, NY 11206  Website",
            "structuredText": "<div> \\n <p>By Holly Cole on November 23, 2018</p> \\n <p></p> \\n <p> Celebrating Christmas day in the big apple? Then you'll need to check out our list of restaurants open on Christmas day in NYC!</p> \\n <p> While you won't have the run of every restaurant in town, with a little planning you can still feast out with family or friends in an eclectic selection of restaurants and soak up some festive spirit.</p> \\n <p> From Michelin starred dining to casual eateries, here are the best NYC restaurants open for Christmas. Take your pick of dishes, from spaghetti to dim sum and caviar to fried chicken.</p> \\n <p> Find French and Italian influence food inside the swanky Langham Hotel overlooking 5th Avenue. There's a four-course&nbsp;prix fixe&nbsp;<a href=\\"https://aifiorinyc.com/menus/8621\\">menu</a>&nbsp;for $150 or tasting menu for $250 with no turkey!</p> \\n <p> Ai Fiori 400 5th Avenue 2nd Level, The Langham NYC, New York City, NY 10018&nbsp;&nbsp; Website</p> \\n <p> For Chinese fine dining head to Red Farm for a dim sum lunch in the convivial dining area seated at farmhouse style banquet tables.</p> \\n <p> Red Farm 2170 Broadway, New York, NY 10024&nbsp; Website</p> \\n <p> Dine on European style French fare at Alain Ducasse's New York re-incarnation. The <a href=\\"https://www.benoitny.com/sites/default/files/bbny_christmas_2018_layout_1_0.pdf\\">Christmas menu</a>&nbsp;boasts firm favourites like lobster salad, seared scallops and softly spiced duck breast for $95 a head.</p> \\n <p> Benoit New York 60 West 55thstreetNew York, NY 10019 Website</p> \\n <p> &nbsp;</p> \\n <p> Really splashing out? Try dining in two Michelin star style at this sophisticated urban restaurant where the menu focuses on Korean&nbsp;cooking technique with locally sourced ingredients.</p> \\n <p> Jungsik<br> 2 Harrison Street, New York, NY 10013&nbsp;<br> <a href=\\"http://jungsik.com/\\">Website</a></p> \\n <p> Go green with Georges Vongerichten’s carefully sourced haute&nbsp;cuisine and enjoy a guilt-free Christmas.</p> \\n <p> ABC Kitchen 35 east 18th street new york,&nbsp;NY10003 Website</p> \\n <p> &nbsp;</p> \\n <p> For hearty comfort fare with flair check out Samuelsson's Harlem eatery and let the good times roll.</p> \\n <p> Red Rooster<br> 310 Lenox Avenue (between 125th and 126th) Harlem, NY 10027<br> <a href=\\"https://www.redroosterharlem.com\\">Website</a></p> \\n <p> &nbsp;</p> \\n <p> Discover what chef Christina Leckihas created on the special four-course prix-fixe&nbsp;Christmas day menu&nbsp;for $105 a head.</p> \\n <p> Wythe Hotel 80 Wythe Ave, Brooklyn, NY 11249 Website</p> \\n <p> Soak up the festive spirit in this cosy gastropub preparing a special&nbsp;<a href=\\"https://www.thebreslin.com/menus/\\">Christmas menu</a>&nbsp;for the occasion.</p> \\n <p> The Breslin Bar and Dining Room 16 west 29th street new york, new york 10001 Website</p> \\n <p> For a relaxed neighbourhood vibe head to this Brooklyn institute which has been serving up locally sourced food, pizzas and beers since it first opened in 2008.&nbsp;</p> \\n <p> Roberta's 261 Moore Street, Brooklyn, NY 11206&nbsp; Website</p> \\n</div>",
            "url": "https://www.finedininglovers.com/blog/culinary-stops/restaurants-open-on-christmas-day-in-nyc/",
            "elements": [
              {
                "type": "Image",
                "primary": true,
                "url": "http://img.finedininglovers.com/?img=http%3a%2f%2ffinedininglovers.cdn.crosscast-system.com%2fBlogPost%2fOriginal_18245_DSC00161.jpg&w=1200&h=660&lu=1543179762&ext=.jpg",
                "width": null,
                "height": null,
                "title": null,
                "alternative": null
              }
            ],
            "website": {
              "name": "finedininglovers.com/",
              "hostName": "www.finedininglovers.com",
              "domainName": "finedininglovers.com",
              "iconURL": null,
              "countryName": "",
              "countryCode": "",
              "region": null
            },
            "metadata": {
              "readTime": {
                "type": "readTime",
                "seconds": 100
              }
            },
            "highlight": "By Holly Cole on November 23, 2018 Celebrating Christmas day in the big <highlighted>apple</highlighted>? Then you'll need to",
            "score": 4.210771
            }
        ]
    }
    """*/
    static let json = """
    {
    "id": "nxtpzcbw_EqZVMpMEpE4TPMJGWlIInUFxEbv3Wb5D_dm1Q9xWLCj8QgZs_5a_qgjOw5amhs6HLCnknMrc1JDtA",
    "discoverDate": "2018-11-25T21:07:50.184+0000",
    "title": "Search For The Missing In California Wildfires Continues",
    "language": "en",
    "text": "More than two weeks after the nation's worst fire in a century erupted in Northern California, crews are still trying to find hundreds of people. The Camp Fire has claimed at least 85 lives and, as of Sunday, is 100 percent contained. But now dozens of disaster workers from across the country are coming to the town of Paradise to help out with the search mission. About two dozen search-and-rescue personnel in white jumpsuits and hardhats, wearing respirators walk through the ash-covered debris in Paradise. There are the remnants of some metal furniture. A fireplace is still standing. The whole search crew is just waiting to see if the cadaver dog finds any human remains. Chuck Williams with the Orange County Sheriff's Department is the cadaver dog handler. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck. \\"What we're hunting for is so minute,\\" says Williams, \\"Now if there is more remnants, the dogs can absolutely function, but the water has not helped the dogs.\\" This process could take months. The burn scar of the Camp Fire is immense: 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters and still, this scene takes him aback. \\"The magnitude,\\" he says. \\"It's like being in a war zone. It's like watching a war movie, unfortunately.\\" When remains are found, they are sent to a mortuary in Sacramento, where forensics experts try to identify them. Then they'll be returned to loved ones. Before Williams and his team embarked on the mission, they were debriefed by anthropologist Colleen Milligan. She's works with the Chico State Human Identification lab. She says many remains are found in places that suggest the victims were attempting to escape. \\"We're talking about front doors and porches. Those are most likely individuals leaving or trying to leave,\\" she says. As Williams searched street after street of Paradise, another thing quickly jumped out at him: the remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot: \\"Just by the level of ash. There's was literally nothing left. It had almost been like through a cremation process.\\" Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is just one of several other dire concerns, like finding a home, sometimes finding a job and for many of then, joining a new community. Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out and he hasn't been back since. When Grimm first looked at the missing list, his saw the name of his friend, who he knew made it out. \\"So we got a hold of his son, and his son said, ' Yeah, dad's OK,' And I said, well, you call your dad and tell him get his name off that list, give him a big hug for me. And let him know, even in the bad days, today's a good day because you're alive.\\" Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend wont' be the last. \\"All I have is hope,\\" he says, \\"That's all I have is hope.\\" Butte County officials have been equally as optimistic. But they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost. SACHA PFEIFFER, HOST: More than two weeks after the nation's deadliest fire in a century erupted in Northern California, crews are still trying to find hundreds of people. The Camp Fire has killed at least 85. It's now fully contained. But dozens of disaster workers from across the country are coming to the town of Paradise to help with the search mission. NPR's Bobby Allyn is there and followed a team of searchers as they scoured the incinerated city. BOBBY ALLYN, BYLINE: There's about two dozen search-and-rescue personnel in white jumpsuits and hardhats wearing respirators. You can see the remnants of some metal furniture, looks like a fireplace that is still standing. And the whole search crew is just waiting to see if the cadaver dog finds any human remains. Chuck Williams is the cadaver dog handler. He came up from the Orange County Sheriff's Department. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck. CHUCK WILLIAMS: What we're hunting for is so minute. Now, if there's more remnants, the dogs can absolutely function. But the water has not helped the dogs. ALLYN: This process could take months. The burn scar of the Camp Fire is immense - 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters. And still, this scene takes him aback. WILLIAMS: The magnitude - it's like being in a war zone. And it's like watching a war movie, unfortunately. ALLYN: When remains are found, they are sent to a mortuary in Sacramento where forensics experts try to identify them. Then they'll be returned to loved ones. As Williams searched street after street of Paradise, another thing quickly jumped out at him. The remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot. WILLIAMS: Just by the level of ash - there was literally nothing left. It had just almost been, like, through a cremation process. ALLYN: Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is being juggled with several other dire concerns, like finding a home, sometimes finding a job and, for many of them, joining a new community. Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out, and he hasn't been back since. When Grimm first looked at the missing list, he saw the name of his friend, who he knew made it out. BOB GRIMM: So we got a hold of his son, and his son said, yeah, dad's OK. And I said, well, you call your dad and tell him get his name off that list. Give him a big hug for me. And then also let him know that even in the bad days, today's a good day because you're alive. ALLYN: Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend won't be the last. GRIMM: All I have is hope. That's all I have is hope. ALLYN: Butte County officials have been equally as optimistic, but they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost. Bobby Allyn, NPR News, Paradise, Calif. Transcript provided by NPR, Copyright NPR.",
    "structuredText": " <div> \\n <p>More than two weeks after the nation's worst fire in a century erupted in Northern California, crews are still trying to find hundreds of people. </p> \\n <p>The Camp Fire has claimed at least 85 lives and, as of Sunday, is 100 percent contained. But now dozens of disaster workers from across the country are coming to the town of Paradise to help out with the search mission. </p> \\n <p>About two dozen search-and-rescue personnel in white jumpsuits and hardhats, wearing respirators walk through the ash-covered debris in Paradise. There are the remnants of some metal furniture. A fireplace is still standing. The whole search crew is just waiting to see if the cadaver dog finds any human remains. </p> \\n <p>Chuck Williams with the Orange County Sheriff's Department is the cadaver dog handler. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck. </p> \\n <p>\\"What we're hunting for is so minute,\\" says Williams, \\"Now if there is more remnants, the dogs can absolutely function, but the water has not helped the dogs.\\" </p> \\n <p>This process could take months. The burn scar of the Camp Fire is immense: 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters and still, this scene takes him aback. \\"The magnitude,\\" he says. \\"It's like being in a war zone. It's like watching a war movie, unfortunately.\\" </p> \\n <p>When remains are found, they are sent to a mortuary in Sacramento, where forensics experts try to identify them. Then they'll be returned to loved ones. </p> \\n <p>Before Williams and his team embarked on the mission, they were debriefed by anthropologist Colleen Milligan. She's works with the Chico State Human Identification lab. She says many remains are found in places that suggest the victims were attempting to escape. \\"We're talking about front doors and porches. Those are most likely individuals leaving or trying to leave,\\" she says. </p> \\n <p>As Williams searched street after street of Paradise, another thing quickly jumped out at him: the remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot: \\"Just by the level of ash. There's was literally nothing left. It had almost been like through a cremation process.\\" </p> \\n <p>Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is just one of several other dire concerns, like finding a home, sometimes finding a job and for many of then, joining a new community. </p> \\n <p>Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out and he hasn't been back since. </p> \\n <p>When Grimm first looked at the missing list, his saw the name of his friend, who he knew made it out. \\"So we got a hold of his son, and his son said, ' Yeah, dad's OK,' And I said, well, you call your dad and tell him get his name off that list, give him a big hug for me. And let him know, even in the bad days, today's a good day because you're alive.\\" </p> \\n <p>Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend wont' be the last. \\"All I have is hope,\\" he says, \\"That's all I have is hope.\\" </p> \\n <p>Butte County officials have been equally as optimistic. But they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost.<br></p> \\n <p> </p> \\n <p>SACHA PFEIFFER, HOST: </p> \\n <p>More than two weeks after the nation's deadliest fire in a century erupted in Northern California, crews are still trying to find hundreds of people. The Camp Fire has killed at least 85. It's now fully contained. But dozens of disaster workers from across the country are coming to the town of Paradise to help with the search mission. NPR's Bobby Allyn is there and followed a team of searchers as they scoured the incinerated city.</p> \\n <p>BOBBY ALLYN, BYLINE: There's about two dozen search-and-rescue personnel in white jumpsuits and hardhats wearing respirators. You can see the remnants of some metal furniture, looks like a fireplace that is still standing. And the whole search crew is just waiting to see if the cadaver dog finds any human remains.</p> \\n <p>Chuck Williams is the cadaver dog handler. He came up from the Orange County Sheriff's Department. The dog, a black lab named Cinder, has been trained to sit if she detects any remains. But rain over the last three days here has turned mounds of ash into a muddy muck.</p> \\n <p>CHUCK WILLIAMS: What we're hunting for is so minute. Now, if there's more remnants, the dogs can absolutely function. But the water has not helped the dogs.</p> \\n <p>ALLYN: This process could take months. The burn scar of the Camp Fire is immense - 240 square miles across what was once rolling vineyards, apple orchards and rows of evergreen trees. Williams has spent his career responding to disasters. And still, this scene takes him aback.</p> \\n <p>WILLIAMS: The magnitude - it's like being in a war zone. And it's like watching a war movie, unfortunately.</p> \\n <p>ALLYN: When remains are found, they are sent to a mortuary in Sacramento where forensics experts try to identify them. Then they'll be returned to loved ones. As Williams searched street after street of Paradise, another thing quickly jumped out at him. The remnants of this fire were unlike anything he's seen before, and he's visited countless fire scenes. Williams says this fire was exceptionally hot.</p> \\n <p>WILLIAMS: Just by the level of ash - there was literally nothing left. It had just almost been, like, through a cremation process.</p> \\n <p>ALLYN: Meanwhile, for Paradise residents who evacuated, keeping tabs on the missing list is being juggled with several other dire concerns, like finding a home, sometimes finding a job and, for many of them, joining a new community. Bob Grimm lived in Paradise for 40 years. He and his wife left for a dentist appointment right before the fire broke out, and he hasn't been back since. When Grimm first looked at the missing list, he saw the name of his friend, who he knew made it out.</p> \\n <p>BOB GRIMM: So we got a hold of his son, and his son said, yeah, dad's OK. And I said, well, you call your dad and tell him get his name off that list. Give him a big hug for me. And then also let him know that even in the bad days, today's a good day because you're alive.</p> \\n <p>ALLYN: Many others have been removed from the unaccounted list in the same way. Grimm says he's confident his friend won't be the last.</p> \\n <p>GRIMM: All I have is hope. That's all I have is hope.</p> \\n <p>ALLYN: Butte County officials have been equally as optimistic, but they also acknowledge, because of the magnitude of this catastrophe, some people will be forever lost. Bobby Allyn, NPR News, Paradise, Calif. Transcript provided by NPR, Copyright NPR.</p> \\n</div>",
    "url": "http://www.kbbi.org/post/search-missing-california-wildfires-continues",
    "elements": [
      {
        "type": "Image",
        "primary": true,
        "url": "http://mediad.publicbroadcasting.net/p/shared/npr/styles/medium/nprshared/201811/670681027.jpg",
        "width": null,
        "height": null,
        "title": null,
        "alternative": null
      }
    ],
    "metadata": {
      "finSentiment": {
        "type": "finSentiment",
        "sentiment": -0.02
      },
      "readTime": {
        "type": "readTime",
        "seconds": 272
      }
    },
    "highlight": " what was once rolling vineyards, <highlighted>apple</highlighted> orchards and rows of evergreen trees. Williams has spent his",
    "score": 3.7169688
    }
    """
    
    func GetNews() -> [NewsItem] {
        //var goodJson : String = "{ elements=" + APIHelper.json + "}"
        /*var goodJson : String = APIHelper.json
        var toDelete : [String.Index] = [String.Index]()
        for i in 1..<goodJson.count-1 {
            let index = goodJson.index(goodJson.startIndex, offsetBy: i)
            let prev = goodJson.index(goodJson.startIndex, offsetBy: i - 1)
            let next = goodJson.index(goodJson.startIndex, offsetBy: i + 1)
            if (goodJson[index] == Character("\\"")) {
                if (goodJson[next] == Character(" ") || goodJson[next].isUpper()) {
                    toDelete.append(index)
                }
            }
        }
        var cnt = 0
        for el in toDelete {
            goodJson.remove(at: goodJson.index(el, offsetBy: -cnt))
            cnt += 1
        }
        print("\\\\"")*/
        /*guard let jsonArray = goodJson as? [[String: Any]] else {
            return [NewsItem]()
        }
        var response = [NewsItem]()
        do {
        for el in jsonArray {
            response.append(try JSONDecoder().decode(NewsItem.self, from: goodJson.data(using: .utf8)!))
        }
        } catch let err {
            print("Error while fetching news " , err)
            return [NewsItem]()
        }
        return response*/
        /*print(goodJson.prefix(203))

        var ans : SearchResults
        do {
            ans = try JSONDecoder().decode(SearchResults.self, from: goodJson.data(using: .utf8)!)
        } catch let err {
            print("Error while fetching news " , err)
            return [NewsItem]()
        }
        return ans.elements*/
        print(APIHelper.json.prefix(7061))
        do {
            let newsItem = try JSONDecoder().decode(NewsItem.self, from: APIHelper.json.data(using: .utf8)!)
            newsItem.externalUrl = newsItem.externalUrl.makeSafeUrl()
            return [newsItem]
        } catch let err {
            print(err)
            return [NewsItem]()
        }
    }
    
    
    func fetchAllNews(params : [String : Any], completionHandler: @escaping (_ : [NewsItem]) -> ()) {
        let headers : HTTPHeaders = [
            "Authorization" : "sBBqsGXiYgF0Db5OV5tAw3To7PPsmyRAgIa73y4U1x2URrasZJ5GlR1abYpo_jlNn2pHZrSf1gT2PUujH1YaQA"
        ]
        var parsedParams : String = ""
        
        for el in params.keys {
            parsedParams += el
            parsedParams += ":"
            parsedParams += params[el] as! String
            parsedParams += " AND "
        }
        parsedParams = String(parsedParams.prefix(parsedParams.count - 5))
        Alamofire.request(APIHelper.QueryURL,
                          method: .get,
                          parameters: ["query" : parsedParams], headers: headers)
            .responseJSON { (resp) in
                let dict = resp.result.value as! [[String : Any]]
                var items : [NewsItem] = [NewsItem]()
                do {
                    for el in dict {
                        let data : Data = try JSONSerialization.data(withJSONObject : el)
                        items.append(try JSONDecoder().decode(NewsItem.self, from: data))
                    }
                    completionHandler(items)
                } catch let err {
                    print(err)
                }
                print(resp.result.value)
        }
        
    }
}

