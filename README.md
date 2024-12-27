# 🏡 **ImobiliariaGerais**

## 📚 **Overview**  
**ImobiliariaGerais** is a mobile application designed to facilitate the search, visualization, and management of real estate properties for sale or rent. Created in **2016**, the app provides a seamless experience for users to filter properties, view detailed descriptions, explore image galleries, and directly contact real estate agents.

---

## 🚀 **Features**  
- **Authentication System:** User login for individuals (**Pessoal Física**) and legal entities (**Pessoal Jurídica**).  
- **Property Listing:** Browse through property highlights with image galleries.  
- **Property Details:** Detailed view with descriptions, prices, and contact options.  
- **Advanced Filters:** Search properties based on price, rooms, location, and purpose (rent or buy).  
- **Interactive Map Integration:** View property locations on an integrated map.  
- **Contact Agents:** Direct call button for quick communication.  

---

## 📱 **Screenshots**  
1. **Login Screen**  
   - Separate options for Individual and Legal Entity access.  
2. **Property Details**  
   - Full property descriptions with prices, location, and additional details.  
3. **Highlights Screen**  
   - Featured properties with quick navigation.  
4. **Filter Screen**  
   - Advanced search with customizable criteria.  

---

## 🛠️ **Technologies Used**  
- **Language:** Objective-C  
- **UI Framework:** UIKit  
- **Networking:** NSURLSession  
- **Dependency Manager:** CocoaPods  

### 📦 **CocoaPods Libraries**  
```ruby
pod 'SDWebImage'          # Image caching and asynchronous loading  
pod 'DACircularProgress'  # Circular progress indicator  
pod 'pop'                 # Animation library  
pod 'IDMPhotoBrowser'     # Photo browser for image galleries  
pod 'TSMessages'          # In-app notifications  
pod 'UCZProgressView'     # Custom progress view  
pod 'FCAlertView'         # Customizable alert views  
pod 'Firebase/Core'       # Firebase Core for backend integration  
pod 'Firebase/Messaging'  # Firebase Cloud Messaging for notifications  
pod 'VMaskTextField'      # Masked input fields (e.g., phone, CPF)  
```

---

## ⚙️ **Setup and Installation**  
1. Clone the repository:  
   ```bash
   git clone https://github.com/fabersp/ImobiliariaGerais.git
   ```  
2. Navigate to the project directory:  
   ```bash
   cd ImobiliariaGerais
   ```  
3. Install dependencies:  
   ```bash
   pod install
   ```  
4. Open the project in Xcode:  
   ```bash
   open ImobiliariaGerais.xcworkspace
   ```  
5. Build and run the project.  

---

## 🔑 **Environment Configuration**  
Update the configuration files for API and Firebase:  
- API URL in `Constants.h`  
- Firebase configuration in `GoogleService-Info.plist`  

---

## 🧠 **How It Works**  
- **Authentication:** User logs in with CPF or credentials.  
- **Property Listing:** Browse through featured properties or apply filters.  
- **Details Page:** View detailed property information and contact agents directly.  
- **Image Gallery:** Explore high-resolution property images.  
- **Filtering:** Apply advanced search filters.  

---

## 🐞 **Known Issues**  
- Some images may take time to load without stable internet.  
- Filtering by location may return delayed results.  

---

## 📄 **License**  
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.  

---

## 📧 **Contact**  
- **App Name:** ImobiliariaGerais  
- **Developer:** Fabricio Padua  
- **Email:** fabricio_0505_@hotmail.com
- **Linkedin:** www.linkedin.com/fabricio-padua
- **Year of Creation:** **2016**


