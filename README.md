# Movie Hub

Movie Hub is a iOS app that lets you browse the movie and and watch trailer on Youtube. It's built with a combination of SwiftUI and UIKit, using the MVVM design pattern and Auto Layout for responsive UI. The app is written completely in Swift and leverages [TMDB's free API](https://developer.themoviedb.org/docs) .

![Screen Recording](MovieHub/Resources/screenRecording.mp4)

## Key Features

- Home Screen: Discover trending movies, upcoming releases, and popular actors.
- Movie Detail Screen: View detailed information about a movie, including trailers, cast, and reviews.
  Safari View Controller Integration: Watch movie trailers in YouTube without leaving the app.

## Technical Details

- Written in Swift
- Uses both SwiftUI and UIKit
- Follows the MVVM design pattern
- No external dependencies
- Auto layout-based UI
- Built with Xcode 15
- Leverages The Movie Database (TMDB) API (free tier)

## Testing

- Unit tests for core functionalities
- UI tests to ensure consistent user experience

## Known Issues

Layout constraints warning at runtime

## Next Steps

- Show alert when error occure
- Implement full search functionality
- Implement Populer People detail screen
- Implement detail screen for each section with pagination support
- UI Tetsting
