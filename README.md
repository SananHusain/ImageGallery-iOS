# 🖼️ Image Gallery – iOS App (SwiftUI)

A modern, lightweight **iOS image gallery** built using **SwiftUI** and **Clean MVVM architecture**.  
The app fetches photos from a free public API, displays them in a responsive grid, and provides a fullscreen detail viewer with smooth swipe gestures and animations.

---

## 🚀 Features

- 📸 **Dynamic Image Grid**
  - Displays remote images in a clean, adaptive grid (4–5 images per row)
  - Supports infinite scrolling with prefetching

- 🔍 **Fullscreen Detail View**
  - Swipe left/right to browse images
  - Smooth page transitions and animations
  - Floating info bar showing author and image size

- ⚡ **Async Networking + Local Caching**
  - Asynchronous data fetching using `async/await`
  - Caching for improved performance and reduced network usage

- 🔁 **Pull-to-Refresh**
  - Quickly refresh the image gallery content

- 💬 **Error Handling**
  - Gracefully displays alerts for network errors

- 🧱 **Clean Architecture (MVVM)**
  - Fully decoupled layers for UI, business logic, and networking

---

## 🧠 Architecture Summary

**Pattern:** MVVM + Clean Architecture  

| Layer | Description |
|-------|--------------|
| **Model** | Defines core data structures (e.g., `ImageItem`) |
| **ViewModel** | Handles logic, pagination, and data state management |
| **View** | SwiftUI screens for grid and detail views |
| **Service** | Networking and caching logic (async image loader) |
| **Utility** | Image prefetching and error handling helpers |

> This structure ensures modularity, testability, and separation of concerns.

---

## 🌐 API Used

**Picsum Photos API** – free, open-source image API  
🔗 [https://picsum.photos/v2/list](https://picsum.photos/v2/list)

**Example Endpoint:**
https://picsum.photos/v2/list?page=1&limit=20


---

## 🛠️ Build Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/SananHusain/ImageGallery-iOS.git
   cd ImageGallery-iOS
2. **Open in Xcode**
   - Requires **Xcode 15 or later**
   - Open `Gallery App.xcodeproj` or `Gallery App.xcworkspace`

3. **Run the app**
   - Select a simulator (e.g., *iPhone 15 Pro*)
   - Press ▶️ **Run**

No external dependencies required — everything uses native Swift libraries.

---

## 💭 Key Design Decisions

- **SwiftUI** chosen for declarative UI and simplicity.  
- **Async/await** used for modern, concise asynchronous networking.  
- **URLCache** provides efficient image caching and prefetch optimization.  
- **Adaptive Grid Layout** ensures clean, non-overlapping image thumbnails.  
- **Fullscreen Detail View** ignores safe areas for immersive photo experience.

---

## 🧩 Assumptions

- API requires no authentication (public **Picsum Photos API**).  
- Cached images persist for the current app session.  
- App primarily optimized for portrait orientation.  
- Internet connection required for initial data fetch.

---

## 🎁 Bonus Features

✅ Pull-to-refresh support  
✅ Fullscreen detail view with info overlay  
✅ Prefetching for smooth swipe navigation  
✅ Clean UI with transitions and drop shadows  

---

## 🔮 Future Improvements (Optional)

- Offline (cached-only) mode  
- Skeleton loading placeholders  
- Unit tests for networking and caching layers  
- Favorites or image search functionality  

---

## 👨‍💻 Author

**Sanan Husain**  
📧 [sananhusain.sh@gmail.com](mailto:sananhusain.sh@gmail.com)  
🔗 [GitHub: SananHusain](https://github.com/SananHusain)

---

## 📄 License

This project is open source under the **MIT License**.  
You are free to use, modify, and distribute it.

---

⭐ **If you like this project, give it a star on GitHub!**

---

## 🧠 Architecture Overview (Optional Visual)

```text
┌─────────────┐
│   View      │  ← SwiftUI Screens (GalleryView, DetailView)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ ViewModel   │  ← Handles business logic, pagination, and data state
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Service    │  ← Networking, API calls, caching
└─────────────┘

   
