# 📱 iTunes Search App with SwiftUI

An app built in SwiftUI that uses iTunes Search API to searcg albums, songs and films.

The goal of this app is to learn how to use SwiftUI. There is no particular focus on architectural patterns (use of CLEAN or other complexities)

## 🎧 iTunes Search API Documentation

+ https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/
    + Fetch Albums: https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=10
    + Fetch Songs: https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
    + Fetch Movies: https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5
    
**NOTE**: API are not well documented. Some properties on `Movie`, `Albums` and `Song` should be converted to `Optional` to avoid decoding error

## 🔨 TODO & Improvements

+ [] Add some unit tests
+ [] Check Dark/Light mode implementation
+ [] Strings catalogs with Xcode 15 and SwiftUI (https://developer.apple.com/videos/play/wwdc2023/10155/) 

## 📰 Articles, resources

+ https://app.quicktype.io/
+ https://fuckingswiftui.com/


