# TogetherTrip

## Overview

TogetherTrip is a collaborative travel planning mobile app designed to enhance group travel experiences by enabling users to create, plan, organize, and share trips with friends and family. This all-in-one platform allows travelers to explore posts from other users for inspiration, create a trip, search for restaurants and attractions, add them to their itineraries, and visualize planned destinations on an interactive map. With its intuitive interface and real-time updates, TogetherTrip simplifies the travel planning process and revolutionizes group coordination by consolidating features from multiple apps into one cohesive experience.

## Design Decisions

### **1. Color Scheme**
- A **Cream (#FFFAF2)** color background was chosen for a calming and elegant aesthetic.
- Consistent use of **Light Purple (#ECE6F0)** for interactive elements ensures brand identity.
- **Purple (#6A4C93)** was selected as the accent color for highlights, actionable buttons, and navigation elements, ensuring important components stand out.

### **2. User Interface**
- Focused on clean and minimalistic design principles:
  - A carefully planned layout for all pages to ensure consistency and a seamless user experience across the app.
  - Rounded corners for buttons and cards to enhance the app’s modern aesthetic.
  - Padding and spacing to improve readability and prevent visual clutter.
  - Easy-to-understand icons and clearly labeled text to ensure accessibility and clarity for all users.

### **3. User Experience**
- **Splash Screen**:  
  - The app opens with a visually appealing splash screen displaying the **TogetherTrip** logo on a **Light Purple (#ECE6F0)** background, setting a welcoming and cohesive tone for the user.

- **Trip Management**:  
  - Users can easily create, edit, and organize trips.  
  - Trips are displayed with visually engaging cards, showcasing trip details like the destination, dates, and a customizable cover image. 

- **Interactive Itinerary**:  
  - Each day of the trip features an itinerary where users can add activities and view them on a timeline.
  - Activities can be easily edited by clicking into the event in itinerary, providing flexibility for changing travel plans. 

- **Map Integration**:    
  - Planned locations in the itinerary are plotted on an interactive map, allowing users to see the geographical distribution of their activities.
  - The map view integrates with event details, making navigation easier.  

- **Collaboration Features**:  
  - Users can invite companions to join a trip by selecting friends from their contact list.
  - Users can also remove companions from a trip when plans change.

- **Posts for Inspiration**:  
  - Users can create and view posts shared by others, offering travel inspiration and insights.  
  - Each post includes photos, contents, and comments, providing a way for users to engage and share experiences.
  - Bookmark funtion of the posts allow users to save content for future reference, seamlessly integrating with trip planning.

- **Profile Customization**:  
  - Users can update their profile pictures and names through an easy-to-use profile editor.
  - A streamlined design ensures that profile updates reflect immediately across the app.
  - Users can access their previous posts and bookmarked posts easily on their profile page for reference.

## Tech Decisions

### **1. Frontend**
- **SwiftUI**:
  - A declarative framework was chosen to build the app's user interface due to its seamless integration with modern Apple platforms and its declarative syntax.
  - Direct binding of UI components to the data layer was implemented using `@State`, `@ObservedObject`, and `@Binding` properties for simplicity and real-time data updates.
- **No View Models**:
  - The app architecture avoids the MVVM (Model-View-ViewModel) pattern typically seen in iOS applications. Instead, the views interact directly with the data layer.
  - **Reasoning**:
    - Reduced development complexity, allowing the team to focus on implementing core features.
    - Faster prototyping and iteration cycles without the overhead of creating intermediary view models.
  - **Implications**:
    - The direct binding approach can lead to tightly coupled code, making refactoring and scalability more challenging.
    - Limited testability for UI components, as business logic resides closer to the views.
  - **Future Considerations**:
    - As the app grows, adopting view models would improve code modularity, testability, and maintainability.

### **2. Backend**
- **Firebase Firestore**:
  - Provides a scalable NoSQL database for storing user, trip, and post data.
  - Real-time updates for seamless synchronization.
- **Firebase Storage**:
  - Handles image uploads for profile photos and posts.

### **3. APIs**
- **MapKit**:
  - Interactive maps for viewing destinations planned for the day.
  - Annotation support for displaying trip events.

## Testing Instructions

All test files are located in the `TravelTests` folder. Using the shortcut `Command + U` to execute all tests. Below are screenshots of expected coverage (above 90%).

### **Model Tests**
- Comment: 
  ![Comment Coverage](./Screenshots/Comment.png)
- Day:
  ![Day Coverage](./Screenshots/Day.png)
- Event:
  ![Event Coverage](./Screenshots/Event.png)
- Location:
  ![Location Coverage](./Screenshots/Location.png)
- Post:
  ![Post Coverage](./Screenshots/Post.png)
- SimpleUser:
  ![SimpleUser Coverage](./Screenshots/SimpleUser.png)
- Travel App:
  ![Travel App Coverage](./Screenshots/TravelApp.png)
- Trip:
  ![Trip Coverage](./Screenshots/Trip.png)
- User:
  ![User Coverage](./Screenshots/User.png)

## Extraneous Features

While the app incorporates a wide range of features, several planned functionalities were left out due to time constraints. These features are essential for creating a more complete and polished iOS app experience and are listed below for future consideration:

- **Expanded Trip Management:**
  - Allow users to expand and shrink trip lists segregated by year for better organization and navigation.

- **Enhanced Post Functionality:**
  - Enable users to post with multiple pictures to capture diverse aspects of their trips.
  - Show the number of comments and bookmarks on posts to indicate engagement.
  - Provide the ability to sort posts by their popularity (e.g., based on the number of bookmarks).
  - Add a feature to view posts of a specific friend directly in their profile.

- **Advanced Map Feature:**
  - Display the route of the day on the map based on the order in the itinerary.

- **Itinerary Management:**
  - Allow users to click on the calendar and view an enlarged itinerary or calendar for better planning.
  - Implement functionality to delete existing events from itineraries.

- **User Authentication:**
  - Add the ability for users to login, logout, and create accounts within the app for a personalized experience.

- **Visual Feedback and Animations:**
  - Introduce animations such as confetti when a trip, event, or post is created, added, or modified to enhance user satisfaction and engagement.

These features are valuable additions to the TogetherTrip app, and their implementation would significantly enhance the user experience, offering greater functionality, flexibility, and engagement.

## Contributors

- **Team 12 Members**:
  - Cindy Jiang
  - Kailan Mao
  - Emma Shi

<!-- ChatGPT assists with the README -->
