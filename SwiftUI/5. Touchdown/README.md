## Learned ☺️

### Special Concept 😊
* Make multi-platform views for iPhone, iPad and Mac
* Bring iPad app to Mac using Catalyst

### Controls 🕹
* **Grid**
  * Simple LazyVGrid
  * LazyVGrid with custom GridItem
* **VideoPlayer(player: AVPlayer())**
  * ```
    { Text(videoTitle) }
    .overlay(
      Image("logo")
        .resizable()
        .scaledToFit()
        .frame(width: 32, height: 32),
         alignment: .topLeading
           )
    ```

### Modifiers

* .previewLayout(.fixed(width: 400, height: 300))
* .previewLayout(.sizeThatFits)
* .previewDevice("iPhone 11 Pro")

## Showcase 📱

### iPad
https://user-images.githubusercontent.com/28094207/190652362-c0f6fb13-14b4-4eae-9b8f-059aa4280c09.mp4

### iOS
https://user-images.githubusercontent.com/28094207/190652053-f20cabc9-6bd5-486b-a4df-a665a208afd7.mp4
