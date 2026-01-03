# Year Progress Widget

A minimalist iOS widget that visualizes the passage of time throughout the year. Each day is represented as a dot in an elegant grid, making it easy to see at a glance how much of the year has passed and how much remains.

## Features

### 📱 Multiple Widget Sizes
- **Large Home Screen Widget**: Full year visualization with 365/366 dots arranged in a beautiful grid
- **Lock Screen Widget**: Compact progress bar showing year completion percentage

### 🎨 Design Philosophy
- **Minimalist Aesthetic**: Clean, distraction-free interface with a dark theme
- **Visual Clarity**: Each day is a dot - blue for passed days, gray for days ahead
- **Elegant Typography**: Serif font (Palatino) for a timeless, sophisticated look
- **Real-time Updates**: Widget refreshes daily at midnight to stay current

### ⚡ Key Capabilities
- Automatic leap year detection and handling (366 days vs 365)
- Days remaining counter with percentage completion
- No configuration needed - just add and go
- Optimized for iOS performance

## Screenshots

### Home Screen Widget
The large widget displays the entire year as a grid of dots, with the current year prominently displayed at the top. Passed days appear in a soft indigo blue, while future days remain gray.

### Lock Screen Widget
A compact rectangular widget perfect for your lock screen, showing a progress bar and percentage of the year that has elapsed.

## Installation

### Requirements
- iOS 16.0 or later
- Xcode 14.0 or later (for building from source)

### Building from Source

1. **Clone the repository**
   ```bash
   git clone https://github.com/mozzdevv/YearProgressWidget.git
   cd YearProgressWidget
   ```

2. **Open in Xcode**
   ```bash
   open YearProgressWidget.xcodeproj
   ```
   
   If there's no Xcode project file, create a new iOS App project in Xcode and add all the Swift files.

3. **Configure Signing**
   - Select the project in Xcode
   - Go to "Signing & Capabilities"
   - Select your development team
   - Ensure "Automatically manage signing" is checked

4. **Build and Run**
   - Select your target device (iPhone or simulator)
   - Press `Cmd + R` to build and run
   - The app will install on your device

5. **Add the Widget**
   - Long-press on your home screen
   - Tap the `+` button in the top-left corner
   - Search for "Year Progress"
   - Select your preferred widget size
   - Tap "Add Widget"

## Project Structure

```
YearProgressWidget/
├── YearProgressApp.swift      # Main app entry point
├── ContentView.swift           # Main app view (full-screen year visualization)
├── YearModel.swift            # Core logic for year calculations
├── YearWidget.swift           # Widget implementation (home & lock screen)
└── YearWidgetBundle.swift     # Widget bundle configuration
```

## How It Works

### Year Model
The `YearModel` struct handles all date calculations:
- Determines if the current year is a leap year
- Calculates total days (365 or 366)
- Tracks days passed and days remaining
- Computes completion percentage
- Provides day-by-day status for grid visualization

### Widget Updates
The widget uses iOS's `TimelineProvider` to schedule updates:
- Refreshes automatically at the start of each new day
- Minimal battery impact due to smart scheduling
- No background processing required

### Visual Design
- **Color Palette**: 
  - Passed days: Light indigo blue `rgb(0.5, 0.6, 1.0)`
  - Future days: Gray with 30% opacity
  - Days remaining: Red accent
  - Background: Pure black for OLED optimization
- **Grid Layout**: 18 columns × ~20 rows (adjusts for leap years)
- **Dot Size**: 6-8px circles with consistent spacing

## Technical Details

### Technologies Used
- **SwiftUI**: Modern declarative UI framework
- **WidgetKit**: Native iOS widget framework
- **Foundation**: Date and calendar calculations

### Supported Widget Families
- `.systemLarge` - Large home screen widget (full year grid)
- `.accessoryRectangular` - Lock screen widget (progress bar)

### Performance Optimizations
- Lazy grid rendering for efficient memory usage
- Minimal computational overhead (calculations done once per day)
- Static timeline updates reduce battery consumption

## Customization

Want to customize the widget? Here are some easy modifications:

### Change Colors
Edit the color values in `YearWidget.swift` and `ContentView.swift`:
```swift
// Passed days color
Color(red: 0.5, green: 0.6, blue: 1.0)

// Future days color
Color.gray.opacity(0.3)
```

### Adjust Grid Density
Modify the column count in the `LazyVGrid`:
```swift
LazyVGrid(columns: Array(repeating: GridItem(...), count: 18), ...)
```

### Change Typography
Update the font in the header:
```swift
.font(.custom("Palatino-Roman", size: 20))
```

## Philosophy

This widget embodies the concept of **memento mori** - a reminder of time's passage and the importance of making each day count. By visualizing the year as individual dots, it creates a tangible representation of time that encourages mindfulness and intentionality.

Each dot represents a day - a finite, irreplaceable unit of time. The visual contrast between passed days (blue) and remaining days (gray) serves as a gentle reminder to live purposefully.

## Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Share your customizations

## License

MIT License - feel free to use this project however you'd like.

## Acknowledgments

Created with the goal of bringing mindful time awareness to iOS devices through elegant, minimalist design.

---

**Made with ❤️ by [mozzdevv](https://github.com/mozzdevv)**

*"Time is what we want most, but what we use worst." - William Penn*
