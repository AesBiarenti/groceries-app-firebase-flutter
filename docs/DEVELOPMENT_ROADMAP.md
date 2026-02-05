# Groceries App — Geliştirme Yol Haritası ve Mimari

Bu döküman, Flutter + Firebase ile geliştirilecek groceries uygulamasının **Clean Architecture** yapısını, **dizin organizasyonunu** ve **baştan sona yapılacaklar sırasını** tanımlar.

---

## 1. Özellikler Özeti

| Özellik               | Açıklama                                           |
| --------------------- | -------------------------------------------------- |
| **Google ile giriş**  | Firebase Auth + Google Sign-In                     |
| **Ürün listesi**      | Kategoriler, arama (Firestore)                     |
| **Sepet**             | Sepete ekleme, adet güncelleme, silme              |
| **Sipariş verme**     | Sepetten sipariş oluşturma, ödeme/teslimat bilgisi |
| **Geçmiş siparişler** | Kullanıcıya ait sipariş listesi ve detay           |
| **Profil / Ayarlar**  | Çıkış, isteğe bağlı profil bilgisi                 |

**Paketler:** Riverpod, Firebase (Core, Auth, Firestore), Google Sign-In. İsteğe bağlı: Hive (offline), intl (tarih/para formatı).

**Routing:** GoRouter kullanılmayacak; `Navigator` + named routes veya `push`/`pop`.

---

## 2. Dizin Yapısı (Clean Architecture)

```
lib/
├── main.dart
├── app.dart                          # MaterialApp, ProviderScope, routes
├── firebase_options.dart
│
├── core/                             # Tüm feature'ların ortak kullandığı
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── firestore_constants.dart   # Collection/document path sabitleri
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│   ├── utils/
│   │   └── validators.dart
│   ├── extensions/
│   │   └── context_extensions.dart
│   └── errors/
│       ├── failures.dart
│       └── exceptions.dart
│
├── shared/                           # Paylaşılan widget ve base'ler
│   └── widgets/
│       ├── app_button.dart
│       ├── app_loading.dart
│       └── empty_state.dart
│
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── auth_remote_datasource.dart   # Firebase Auth + Google
    │   │   ├── models/
    │   │   │   └── user_model.dart
    │   │   └── repositories/
    │   │       └── auth_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── user_entity.dart
    │   │   ├── repositories/
    │   │   │   └── auth_repository.dart          # abstract
    │   │   └── usecases/
    │   │       ├── sign_in_with_google.dart
    │   │       └── sign_out.dart
    │   └── presentation/
    │       ├── providers/
    │       │   └── auth_provider.dart
    │       ├── screens/
    │       │   ├── login_screen.dart
    │       │   └── splash_screen.dart
    │       └── widgets/
    │
    ├── products/                     # Ürün kataloğu / liste
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── products_remote_datasource.dart
    │   │   ├── models/
    │   │   │   └── product_model.dart
    │   │   └── repositories/
    │   │       └── products_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── product_entity.dart
    │   │   ├── repositories/
    │   │   │   └── products_repository.dart
    │   │   └── usecases/
    │   │       ├── get_products.dart
    │   │       └── get_products_by_category.dart
    │   └── presentation/
    │       ├── providers/
    │       │   └── products_provider.dart
    │       ├── screens/
    │       │   ├── home_screen.dart
    │       │   └── product_detail_screen.dart
    │       └── widgets/
    │           └── product_card.dart
    │
    ├── cart/                         # Sepet
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   ├── cart_local_datasource.dart    # Hive/SharedPrefs opsiyonel
    │   │   │   └── cart_remote_datasource.dart   # Firestore: users/{uid}/cart
    │   │   ├── models/
    │   │   │   └── cart_item_model.dart
    │   │   └── repositories/
    │   │       └── cart_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── cart_item_entity.dart
    │   │   ├── repositories/
    │   │   │   └── cart_repository.dart
    │   │   └── usecases/
    │   │       ├── add_to_cart.dart
    │   │       ├── update_cart_item_quantity.dart
    │   │       ├── remove_from_cart.dart
    │   │       └── get_cart.dart
    │   └── presentation/
    │       ├── providers/
    │       │   └── cart_provider.dart
    │       ├── screens/
    │       │   └── cart_screen.dart
    │       └── widgets/
    │           └── cart_badge.dart
    │
    ├── orders/                       # Sipariş verme + geçmiş siparişler
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── orders_remote_datasource.dart # Firestore: users/{uid}/orders
    │   │   ├── models/
    │   │   │   ├── order_model.dart
    │   │   │   └── order_item_model.dart
    │   │   └── repositories/
    │   │       └── orders_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── order_entity.dart
    │   │   │   └── order_item_entity.dart
    │   │   ├── repositories/
    │   │   │   └── orders_repository.dart
    │   │   └── usecases/
    │   │       ├── create_order.dart
    │   │       ├── get_orders.dart
    │   │       └── get_order_by_id.dart
    │   └── presentation/
    │       ├── providers/
    │       │   └── orders_provider.dart
    │       ├── screens/
    │       │   ├── checkout_screen.dart
    │       │   ├── order_confirmation_screen.dart
    │       │   └── order_history_screen.dart
    │       └── widgets/
    │           └── order_card.dart
    │
    └── profile/                      # Profil / çıkış
        ├── data/                      # Gerekirse (profil güncelleme vs.)
        ├── domain/
        └── presentation/
            ├── providers/
            ├── screens/
            │   └── profile_screen.dart
            └── widgets/
```

---

## 3. Firestore Yapısı (Önerilen)

| Collection / Path    | Açıklama                                     |
| -------------------- | -------------------------------------------- |
| `products`           | Tüm ürünler (admin tarafından yönetilebilir) |
| `users/{uid}`        | Kullanıcı profil (opsiyonel)                 |
| `users/{uid}/cart`   | Kullanıcı sepeti (alt koleksiyon)            |
| `users/{uid}/orders` | Kullanıcı siparişleri (alt koleksiyon)       |

Her **order** dokümanında: `items` (order line'lar), `total`, `status`, `createdAt`, teslimat adresi vb. alanlar tutulabilir.

---

## 4. Baştan Sona Yapılacaklar Sırası

### Faz 0 — Hazırlık

1. **Paketleri ekle** (`pubspec.yaml`):  
   `flutter_riverpod`, `firebase_auth`, `cloud_firestore`, `google_sign_in`.  
   İsteğe bağlı: `hive`, `intl`.
2. **Assets:** Figma’dan gelen görselleri `assets/` altına koy; `pubspec.yaml` içinde `flutter.assets` tanımla.
3. **Core klasörlerini oluştur:** `core/constants`, `core/theme`, `core/utils`, `core/errors`, `core/extensions`.
4. **Shared widget’lar:** Gerek duydukça `shared/widgets` (buton, loading, empty state).

---

### Faz 1 — Uygulama iskeleti ve Auth

5. **`app.dart`:** `ProviderScope` + `MaterialApp` (theme: `core/theme`). Routes: splash, login, home (placeholder).
6. **`main.dart`:** Firebase init + `runApp(ProviderScope(child: App()))`.
7. **Auth feature — domain:** `User` entity, `AuthRepository` abstract (signInWithGoogle, signOut, currentUser stream).
8. **Auth feature — data:** Firebase Auth + Google Sign-In kullanarak `AuthRepositoryImpl`, `UserModel`.
9. **Auth feature — presentation:** Login ekranı, splash ekranı, `authStateProvider` (Riverpod). Giriş yoksa login, varsa home’a yönlendirme.

---

### Faz 2 — Ürünler ve ana ekran

10. **Firestore:** `products` koleksiyonu (ve gerekirse seed data).
11. **Products feature — domain:** `Product` entity, `ProductsRepository` (getProducts, getById, getByCategory).
12. **Products feature — data:** `ProductsRepositoryImpl`, `ProductModel`, Firestore datasource.
13. **Products feature — presentation:** Home ekranı (ürün listesi), ürün kartı widget’ı, detay ekranı. Riverpod ile liste/detay.

---

### Faz 3 — Sepet

14. **Firestore:** `users/{uid}/cart` alt koleksiyonu tasarımı (productId, quantity, price snapshot vb.).
15. **Cart feature — domain:** `CartItem` entity, `CartRepository` (getCart, add, updateQuantity, remove).
16. **Cart feature — data:** `CartRepositoryImpl`, `CartItemModel`, Firestore cart datasource.
17. **Cart feature — presentation:** Sepet ekranı, sepete ekle butonu, adet +/- , sepet badge (AppBar). Cart provider’ları.

---

### Faz 4 — Sipariş ve geçmiş

18. **Firestore:** `users/{uid}/orders` yapısı (order doc: items, total, status, createdAt, address vb.).
19. **Orders feature — domain:** `Order`, `OrderItem` entity, `OrdersRepository` (createOrder, getOrders, getOrderById).
20. **Orders feature — data:** `OrdersRepositoryImpl`, `OrderModel`, `OrderItemModel`, Firestore orders datasource.
21. **Orders feature — presentation:** Checkout ekranı (sepet özeti + adres/not), sipariş onay ekranı, geçmiş siparişler listesi ve sipariş detay. Orders provider’ları.
22. **Sipariş oluşturma akışı:** Checkout’ta “Siparişi ver” → CreateOrder use case → sepeti temizle → Order confirmation ekranına git.

---

### Faz 5 — Profil ve son dokunuşlar

23. **Profile feature:** Profil ekranı (kullanıcı bilgisi, çıkış). Çıkışta Auth signOut + login ekranına yönlendirme.
24. **Navigation:** Bottom navigation veya drawer: Home, Sepet, Siparişlerim, Profil. Named routes veya Navigator ile ekran geçişleri.
25. **Tema ve asset’ler:** Figma’ya göre renkler, fontlar, asset kullanımı (core/theme + ekranlarda).
26. **intl (opsiyonel):** Sipariş tarihleri ve para birimi formatı için kullan.

---

## 5. Bağımlılık Yönü (Clean Architecture)

- **Presentation** → sadece **domain** (entity, repository interface).
- **Domain** → hiçbir dış katmana bağımlı değil.
- **Data** → domain’deki repository’leri **implement** eder; Firebase/Firestore, Auth, (opsiyonel Hive) burada kalır.

Böylece testlerde repository’ler kolayca mock’lanır.

---

## 6. Paket Listesi (Özet)

| Paket              | Amaç                                 |
| ------------------ | ------------------------------------ |
| `flutter_riverpod` | State management                     |
| `firebase_core`    | Firebase init                        |
| `firebase_auth`    | Giriş                                |
| `cloud_firestore`  | Ürünler, sepet, siparişler           |
| `google_sign_in`   | Google ile giriş                     |
| `intl`             | Tarih/para formatı (siparişler için) |
| `hive`             | Opsiyonel; sepet/offline cache       |

GoRouter ve Dio bu planda yok; routing için `Navigator`, ağ için Firebase SDK’lar kullanılacak.

---

## 7. Doküman Güncellemesi

Yeni feature veya koleksiyon eklendikçe bu dosyayı güncelleyebilirsin. Sorular için: önce ilgili feature’ın domain → data → presentation sırasını takip et.
