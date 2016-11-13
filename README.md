DatabasesCrimeApp
=================

1. In your terminal, in the root directory, run `pod install`
2. Open up Hawk.xcworkspace, not Hawk.xcodeproj

## Networking

Currently, Networking class has two methods, register and login. To use them, you would just call it, for example:

```swift
Networking.login(userId : "some username", password : "some password", completionHandler: {response, error in
  if let json = response.result.value {
    print("JSON: \(json)")
  }
}
```
