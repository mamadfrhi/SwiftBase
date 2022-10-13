## Learned ☺️

### Special Concept
* How to make view compatible to iPads as well
* accentColor and loading resources correctly
* Make eye-catching launch screen
* Make compatible views for dark mode
* Deal with JSON (Codeable)
* Generic
* Make reuseable views
* MapKit
* Computer Properties
* Haptics

### Wrappers

### Controls
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
### Modifiers

* .previewLayout(.fixed(width: 400, height: 300))
* .previewLayout(.sizeThatFits)
* .previewDevice("iPhone 11 Pro")

## Showcase 📱

### iPad
https://user-images.githubusercontent.com/28094207/190652362-c0f6fb13-14b4-4eae-9b8f-059aa4280c09.mp4

### iOS
https://user-images.githubusercontent.com/28094207/190652053-f20cabc9-6bd5-486b-a4df-a665a208afd7.mp4

