## Learned ☺️

### Special Concept
* How to make views compatible to iPads as well
* accentColor and loading resources correctly
* Make eye-catching launch screen
* Make compatible views for dark mode
* Deal with JSON (Codeable)
* Generic
* Make reuseable views
* Computed Properties
* Haptics
* AVKit
* MapKit
  * Custom Annotation
* GeometryReader
* Complex Animations
* Grid
  * Simple LazyVGrid
  * LazyVGrid with custom GridItem
### Wrappers

### Controls
* VideoPlayer(player: AVPlayer())
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
* Map(coordinateRegion: $region)
  * ```
    .overlay(
      NavigationLink(destination: MapView()) {
        Image(systemName: "mappin.circle")
      })
      ```
* Group{}
* GroupBox{} -> it makes a nice background behind of its children
* TabView {}
  * .tabItem
  * .tabViewStyle(PageTabViewStyle())
  * .frame(minWidth: 148, idealWidth: 168, maxHeight: 180)

* List {}
  * .listRowInsets(EdgeInsets())
  * .listStyle(.insetGrouped)
* ``` 
  NavigationLink(
    destination: AnimalDetailView(animal: animal)) {
        AnimalListItemView(animal: animal)
    }
  ```

* NavigationView {}
  * .navigationTitle("Africa")
  * .navigationBarTitleDisplayMode(.large)
  * Modifiers above should be on view inside of the NavigationView
  * ```
    .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                      Button {
                          videos.shuffle()
                      } label: {
                          Image(systemName: "arrow.2.squarepath")
                      }
                  }
              }
    ```
* Image
  * .clipShape(RoundedRectangle(cornerRadius: 12))
  * .imageScale(.large)
  * .clipShape(Circle())

* Text("Lion")
  * .font(.title2)
  * .fontWeight(.heavy)
  * .foregroundColor(.accentColor)
  * .multilineTextAlignment(.leading)
  * .lineLimit(2)
  * .padding(.trailing, 8)
  * ``` 
    .background(
      Color.accentColor
      .frame(height: 6)
      .offset(y: 24)
      ) // -> it makes an underline under the text
    ```


* Circle()
  * .stroke(Color.accentColor, lineWidth: 2)
  * center)
  * .scaleEffect(1 + CGFloat(animation))
  * .opacity(1 - animation)
  * .drawingGroup() // dispatch animation go GPU which cause better performance
  * ```
    .onAppear {
      withAnimation(Animation.easeIn(duration: 2).repeatForever(autoreverses: false)) {
        animation = 1
      }
    }
    ```
* Slider(value: $gridColumn, in: 2...4)
### Modifiers

* .previewLayout(.fixed(width: 400, height: 300))
* .previewLayout(.sizeThatFits)
* .previewDevice("iPhone 11 Pro")

## Showcase 📱

### iPad
https://user-images.githubusercontent.com/28094207/190652362-c0f6fb13-14b4-4eae-9b8f-059aa4280c09.mp4

### iOS
https://user-images.githubusercontent.com/28094207/190652053-f20cabc9-6bd5-486b-a4df-a665a208afd7.mp4

