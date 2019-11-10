# Table of contents
1. [Requirements](#requirements)
2. [Description](#description)
    *  [Application](#application)
    *  [Architecture](#architecture)

## Requirements
Current supported version for RxMarvelApp:

* **Minimum OS**: iOS 13.1
* **Swift**: Swift 5

## Description

### Application

In this app you'll see a list of Marvel characters, this application include a search bar to filter the characters:

### Architecture

One of the requierements for this challenge was to implement a simple, not overengineered solution. The app only has two main views and it would have been really easy to have a simple storyboard with a segue, implement some MVC or MVP architecture and that's it. However, in order to show some of my iOS skills and my understanding of iOS programming I wanted to go one step further by implementing a kind of more layered MVVM architecture with RxSwift. 

I decided to use RxSwift first of all for show my skills also in last keynote Apple presents SwiftUI and Combine.
I think apple guide us to use MVVM with a reactive programming for this reason I decided to implement this app with RxSwift.

