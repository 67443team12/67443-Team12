# TogetherTrip

## Overview

TogetherTrip is a collaborative travel planning mobile app designed to enhance group travel experiences by enabling users to create, plan, organize, and share trips with friends and family. This mobile application allows travelers to explore posts from other users for inspiration, create a trip, search for locations that they want to visit, add them to their itineraries, and visualize planned destinations on an interactive map. We wanted to develop TogetherTrip as an application that provides an intuitive travel planning process that can be shared among friends and solve problems like having a hard time scheduling all events without a clear visualization of the routes or distances between locations.

## Design Decisions

### **1. Color Scheme**
There are 3 colors mainly used in our app aside from black and white. **Purple (#6A4C93)** was selected as the accent color for highlights, actionable buttons, and navigation elements, ensuring important components stand out. We also have another **Light Purple (#ECE6F0)** for interactive elements and echo with the Purple color, for example search bar color. **Cream (#FFFAF2)** is a color that is used mainly as the background color to provide some contrast to the accent color and also distinguish the app to an Apple-built application as the general design style is quite similar to the Apple standards.

### **2. User Interface**
We decided to follow the Apple design principles and ensure that the app is consistent on the front-end. We used rounded corners for buttons and cards to enhance the app’s modern aesthetic, added spacing and padding to improve readability and prevent visual clutter, and utilized the Apple-designed SF Pro icons largely to reduce cognitive load and improve readability for the users in the process.

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

### **2. Backend**
- **Firebase Firestore**:
  - Provides a scalable NoSQL database for storing user, trip, and post data.
  - Real-time updates for synchronization.
- **Firebase Storage**:
  - We use Firebase Storage to handle image uploads for profile photos, trip photo, and posts.

**Framework Problems**:
If you inspect the code, you would find that we actually do not have view models that handle the backend operations for the views. This is something that we are deeply aware of as it would be good coding practice to adopt the structure of MVVM and failing to do that might bring various problems, including difficulty in interpreting the code, difficuly in making changes to existing features and backend functions, and risk of messing up the database with unexpected actions that are made by the views. We started code development without clearly declaring the app’s architecture, so we avoided view models at first to streamline the development process. In addition, the communication during the development phases was not clear enough, that even though some of the team members raised the issue of including view models in the structure, the team did not reached a concensus on the view model issue due to our own personal matter and different pace for development. Therefore, when we tried to refactor the whole application to include view models at the end of version 1 delivery, we realized that it became very time-consuming and somewhat complicated to do so with the increasing number of dependencies and tightly coupled code. With the time constraints at the end, we decided to exclude view models and keep our initial architecture for stability and timely delivery. Similarly, since we included more expected features for version 2 that we want for the MVP of the application, we again did not arrange a time to discuss the matter and started development with the original problematic structure. Although the current architecture is functional and does not lead to major problems for us right now, it definitely reduces the code quality in terms of maintainability and scalability in the future. This is undesirable as it is not a good coding practice. Refactor the whole application to adopt view models would definitely be a better choice, but at the current time point (12/06/2024) we have very limited remaining time to account for the whole app. 

### **3. APIs**
- **MapKit**:
  - Interactive maps for viewing destinations planned for the day.
  - Annotation support for displaying trip events.

## Testing Instructions

All test files are located in the `TravelTests` folder. Use the shortcut `Command + U` to execute all tests. Coverage is located in the report navigator in XCode, which when opened the coverage for the backend compoenents should all have expected coverage (above 90%) similar to the following screenshots.

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

### **Firebase Tests**
- LocationRepository:
  ![Location Repository Coverage](./Screenshots/LocationRepository.png)
- PostRepository:
  ![Post Repository Coverage](./Screenshots/PostRepository.png) 

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
