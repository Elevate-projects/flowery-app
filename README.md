# Flowery 🌸💐  

The **Flowery App** is a Flutter-based e-commerce application designed to simplify and enhance the online flower shopping experience. Users can easily browse, buy, or gift flowers from a wide variety of curated collections. With categories, best sellers, and occasion-based selections, Flowery makes finding the perfect bouquet seamless and enjoyable.  

---

## Features ✨  

### Authentication & Access  
- **Login / Signup**: Secure authentication with email and password.  
- **Remember Me**: Stay logged in between sessions.  
- **Forgot Password Flow**: Reset password via email and OTP verification.  
- **Guest Mode**: Explore the app without login (restricted from cart & checkout).  

### Shopping Experience  
- **Home Screen**: View featured categories, best sellers, and occasion-based flowers with quick "View All" access.  
- **Search**: Find flowers easily by keywords.  
- **Categories**: Browse products by category with filtering (price, discount, new, old).  
- **Product Details**: Get complete details before purchasing.  

### Cart & Checkout  
- **Cart Management**: Add, view, and remove products from your cart.  
- **Checkout Flow**:  
  - Select or add a new shipping address.  
  - Choose payment method (**Cash on Delivery** or **Credit Card**).  
  - Place your order.  

### Profile & Settings  
- **Orders**: View order history and track purchases.  
- **Addresses**: Manage saved delivery addresses.  
- **Notifications**: Enable or disable app notifications.  
- **Language Support**: Switch between **English** and **Arabic**.  
- **About & Policies**: Access About Us and Terms & Conditions.  
- **Logout**: Securely log out anytime.  
- **Notifications Icon**: Quick access to your notifications list from the profile screen.  

---

## Technologies Used 🛠️  

- **Flutter**: Cross-platform UI toolkit.  
- **Dio + Retrofit**: Efficient and type-safe HTTP client for API communication.  
- **Bloc / Cubit (MVI Pattern)**: Structured state management with clear separation of responsibilities.  
- **Clean Architecture**: Ensures scalability, maintainability, and testability.  
- **Repository Pattern**: Abstraction for clean data management.  
- **Dependency Injection**: Improves modularity and testing.  

---

## 📂 Project Structure  

```bash
lib/
├── api/
│   └── client/           # Retrofit API client
│   └── models/           # Data models
│   └── responses/        # API responses
│   └── data_source_impl/ # API implementations
├── data/
│   └── data_source/      # Local/remote data sources
│   └── repositories/     # Repository implementations
├── domain/
│   └── entities/         # Domain entities
│   └── repositories/     # Repository contracts
│   └── usecases/         # Use cases with tests
├── presentation/
│   └── views/            # UI screens/widgets
│   └── view_models/      # Bloc/Cubit files

```

---

## 🛠️ Setup Instructions

### 1.Clone the repository
```bash
git clone https://github.com/Elevate-projects/flowery-app.git
```
### 2.Navigate into the project directory
```bash
cd flowery-app
```
### 3.Install dependencies
```bash
flutter pub get
```
### 4.Run the app
```bash
flutter run
```

---

## Screenshots 📸

<img src="https://github.com/user-attachments/assets/86cf7ed4-73d0-442d-8b8a-87272bc7dd33" alt="Screenshot 1" width="300"/>
<img src="https://github.com/user-attachments/assets/6fa6becc-4c14-4544-a5d5-c5573cc25dad" alt="Screenshot 2" width="300"/>
<img src="https://github.com/user-attachments/assets/76600437-6567-411b-847b-f65027c4c732" alt="Screenshot 3" width="300"/>
<img src="https://github.com/user-attachments/assets/11de084f-e633-4e8e-bf16-11a56ce5ef9b" alt="Screenshot 4" width="300"/>
<img src="https://github.com/user-attachments/assets/c5af0a6e-04d8-40d5-8086-936858b50604" alt="Screenshot 5" width="300"/>
<img src="https://github.com/user-attachments/assets/8dc014a4-a3fc-418f-9f51-19943dcd6cb3" alt="Screenshot 6" width="300"/>
<img src="https://github.com/user-attachments/assets/caea321b-e92b-4ea3-b771-a03703974811" alt="Screenshot 7" width="300"/>
<img src="https://github.com/user-attachments/assets/20aa9be0-94b5-48ac-b90a-0efb7a91465a" alt="Screenshot 8" width="300"/>
<img src="https://github.com/user-attachments/assets/b3c2d8a9-6467-45dd-900a-19f724a97da8" alt="Screenshot 9" width="300"/>
<img src="https://github.com/user-attachments/assets/29c9ecba-ff07-49ec-9079-0a2b7d85f0ea" alt="Screenshot 10" width="300"/>
<img src="https://github.com/user-attachments/assets/1083f6fa-da53-44d8-86f8-f5a3b4e149f2" alt="Screenshot 11" width="300"/>
<img src="https://github.com/user-attachments/assets/9874d3bb-d3f7-40e0-bf01-c2bc422d0630" alt="Screenshot 12" width="300"/>
<img src="https://github.com/user-attachments/assets/4342aff9-3304-4f58-8721-e1a4ac8d93c5" alt="Screenshot 13" width="300"/>
<img src="https://github.com/user-attachments/assets/3989561b-ca88-4646-bc94-dd8f63da4b73" alt="Screenshot 14" width="300"/>
<img src="https://github.com/user-attachments/assets/2933fcca-f14d-4a24-90e6-bb45b90f3972" alt="Screenshot 15" width="300"/>
<img src="https://github.com/user-attachments/assets/625073f8-02ca-4450-8fa5-e7886443bd92" alt="Screenshot 16" width="300"/>
<img src="https://github.com/user-attachments/assets/c2d65d4b-4635-4dcb-aef0-4f14a11dfeca" alt="Screenshot 17" width="300"/>
<img src="https://github.com/user-attachments/assets/50f3c4f7-52b1-4e13-8dae-603c671fb4b0" alt="Screenshot 18" width="300"/>
<img src="https://github.com/user-attachments/assets/649af285-6a54-4d04-b9fd-7462aafb557e" alt="Screenshot 19" width="300"/>
<img src="https://github.com/user-attachments/assets/037be275-8eac-43d0-b2ab-277b1ab632aa" alt="Screenshot 20" width="300"/>
<img src="https://github.com/user-attachments/assets/f8d2f591-b925-4f11-9c25-42c1fd5b6069" alt="Screenshot 21" width="300"/>
<img src="https://github.com/user-attachments/assets/a8695c37-1414-400a-917e-171f80ecd58c" alt="Screenshot 22" width="300"/>
<img src="https://github.com/user-attachments/assets/275a6298-661c-4640-a2e2-c97ab0c1fd17" alt="Screenshot 23" width="300"/>
<img src="https://github.com/user-attachments/assets/b0984cbe-0dc0-40c9-8439-1aae808f4f03" alt="Screenshot 24" width="300"/>
<img src="https://github.com/user-attachments/assets/b20ce587-1cc0-4f95-b19f-a8fcaec1214c" alt="Screenshot 25" width="300"/>
<img src="https://github.com/user-attachments/assets/493a8b84-2c4a-46dc-9003-6e5bf11c9270" alt="Screenshot 26" width="300"/>
<img src="https://github.com/user-attachments/assets/3e40e5a3-c3b6-43ed-a8a5-19ac57332d9b" alt="Screenshot 27" width="300"/>
<img src="https://github.com/user-attachments/assets/f535241f-df2b-4943-b760-20044127e4cf" alt="Screenshot 28" width="300"/>
<img src="https://github.com/user-attachments/assets/62e574c5-57b2-4369-931d-2efa34c9c892" alt="Screenshot 29" width="300"/>
<img src="https://github.com/user-attachments/assets/7aaf334e-bae2-4bd7-884a-0dddc6004041" alt="Screenshot 30" width="300"/>
<img src="https://github.com/user-attachments/assets/8194cd37-3b1a-4f1d-9023-9a8a8ed7f9bc" alt="Screenshot 31" width="300"/>
<img src="https://github.com/user-attachments/assets/37472c04-3753-4451-ba86-a95d31f64b7c" alt="Screenshot 32" width="300"/>

---

## Download 📥
- Coming Soon...
