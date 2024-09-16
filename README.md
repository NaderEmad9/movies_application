# Movies Application

This **Movies Application** is a Flutter app designed to help users discover and manage movies. It integrates with The Movie Database (TMDB) API to provide up-to-date information on popular, top-rated, and newly released movies. Users can search for movies, view details, bookmark their favorites, and manage their watchlist.

## Features

- **Movie Search**: Search for movies by title and explore detailed information.
- **Movie Details**: View detailed information about each movie, including cast, synopsis, and ratings.
- **Watchlist**: Add movies to a personal watchlist for easy tracking.
- **Bookmarks**: Save favorite movies and quickly access them later.
- **Movie Categories**: Discover varius options of categories to find recommendations based on your favourite category.
- **Responsive UI**: Adaptable design for various screen sizes and orientations.

## Technologies Used

- **Flutter**: Framework for building cross-platform applications.
- **TMDB API**: Provides movie data and images.
- **Provider**: State management for efficient data handling.
- **Google Fonts**: Enhances text styling.
- **Dart**: Programming language used in Flutter.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0 or later)
- [Dart](https://dart.dev/get-dart)
- TMDB API key (for fetching movie data)

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/NaderEmad9/movies_application.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd movies_application
   ```

3. **Install Dependencies**

   Run the following command to fetch the required packages:

   ```bash
   flutter pub get
   ```

4. **API Key Configuration**

   - Obtain an API key from [TMDB](https://www.themoviedb.org/documentation/api).
   - Add the API key to your project configuration.

5. **Run the Application**

   To run the application on your preferred device, use:

   ```bash
   flutter run
   ```

## Screenshots

<p align="center">
  <img src="https://github.com/NaderEmad9/movies_application/raw/main/assets/screenshots/search.png" alt="Task List View Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/movies_application/raw/main/assets/screenshots/watchlist.png" alt="Task List View Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/movies_application/raw/main/assets/screenshots/details.png" alt="Task List View Dark" width="220" style="margin: 10px;"/>
</p>

<p align="center">
  <img src="https://github.com/NaderEmad9/movies_application/raw/main/assets/screenshots/home.png" alt="Task List View Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/movies_application/raw/main/assets/screenshots/category.png" alt="Task List View Dark" width="220" style="margin: 10px;"/>
</p>

## Team Contributions

This project was developed as a team effort, with contributions from:

- **Nader Emad**: Handled the integration of the TMDB API, built the search screen, managed movie details, and implemented the watchlist and bookmark features.
  
- **Abdelrahman Sallamy**: Implemented Browse, also worked on optimizing the app’s performance, fixing bugs, and adding new features.

- **Rofida Ahmed**: Worked on Home tab,also handeld some exceptions and API in Home tab.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
