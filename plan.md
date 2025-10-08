# 📚 IIV MOI Kitoblar Platformasi (Flutter)

Minimalistik va zamonaviy dizaynga ega bo‘lgan **IIV MOI Kitoblar Platformasi** — bu o‘quvchilar va foydalanuvchilar uchun institut hamda umumiy adabiyotlarni raqamli tarzda o‘qish, izlash, saqlash va baholash imkoniyatini beruvchi mobil ilovadir.  
Loyiha Flutter 3.x yordamida yozilgan bo‘lib, **mock data** asosida ishlaydi va keyinchalik real API bilan integratsiyaga tayyor arxitekturaga ega.

---

## 🧭 Navigatsiya

- [📌 Loyihaning asosiy maqsadi](#-loyihaning-asosiy-maqsadi)  
- [🧱 Arxitektura](#-arxitektura)  
- [🧠 Tamoyillar](#-tamoyillar)  
- [🚀 Boshlash](#-boshlash)  
- [📂 Loyihaning tuzilmasi](#-loyihaning-tuzilmasi)  
- [📄 Asosiy sahifalar](#-asosiy-sahifalar)  
- [🔌 API bilan integratsiya](#-api-bilan-integratsiya)  
- [👨‍💻 Hissa qo‘shish](#-hissa-qo‘shish)  
- [📜 Litsenziya](#-litsenziya)

---

## 📌 Loyihaning asosiy maqsadi

- Institut va umumiy adabiyotlarni raqamli shaklda taqdim etish  
- Foydalanuvchilarga qulay, tezkor va zamonaviy o‘qish tajribasini yaratish  
- Mock data orqali ishga tushirish va keyinchalik REST API orqali backendga ulash imkoniyati

---

## 🧱 Arxitektura

Loyiha **Clean Architecture** tamoyillariga asoslanadi va quyidagi qatlamlardan iborat:

- `presentation/` — UI, sahifalar, widgetlar, GetX controllerlar  
- `domain/` — entitylar, repository interfeyslari, usecase logikasi  
- `data/` — model, repository implementatsiyasi, mock ma’lumotlar  
- `core/` — umumiy util, tema, constantlar

📌 **State Management:** [GetX](https://pub.dev/packages/get)  
📌 **Mock data:** `assets/mock/` ichidagi JSON fayllar orqali

---

## 🧠 Tamoyillar

Loyiha quyidagi dasturlash tamoyillariga qat’iy amal qiladi:

- **KISS** – soddalikni saqlash, keraksiz murakkabliklardan qochish  
- **DRY** – takrorlanadigan kodlarni umumlashtirish  
- **SOLID** – mustahkam arxitektura va kengaytiriluvchanlik  
- **Separation of Concerns** – UI, biznes logika va data qatlamlarini aniq ajratish  
- **Dependency Injection** – GetX orqali boshqariladi (`Get.put`, `Get.lazyPut`)

---

## 🚀 Boshlash

Loyihani lokalda ishga tushirish uchun quyidagi bosqichlarni bajaring:

```bash
# 1. Loyihani klonlash
git clone https://github.com/username/iiv-moi-books.git

# 2. Loyihaga kirish
cd iiv-moi-books

# 3. Kerakli paketlarni yuklash
flutter pub get

# 4. Mock ma’lumotlar uchun assetlarni qo‘shish
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Ilovani ishga tushirish
flutter run
📌 Eslatma: hozircha barcha ma’lumotlar assets/mock/ katalogidan olinadi. Backend API hali ulanmagan.

📂 Loyihaning tuzilmasi
plaintext
Copy code
lib/
 ├─ core/
 │   ├─ constants/
 │   ├─ theme/
 │   └─ utils/
 │
 ├─ data/
 │   ├─ models/
 │   ├─ repositories/
 │   └─ mock/
 │
 ├─ domain/
 │   ├─ entities/
 │   ├─ repositories/
 │   └─ usecases/
 │
 ├─ presentation/
 │   ├─ controllers/
 │   ├─ pages/
 │   ├─ widgets/
 │   └─ routes/
 │
 └─ main.dart
📄 Asosiy sahifalar
Sahifa nomi	Tavsif
🔐 Login / Register	Email, parol, Google/Apple login (mock)
🏠 Bosh sahifa	Institut va umumiy adabiyotlar kategoriyasi
🔍 Qidiruv	Real-time search (mock)
📖 Kitob tafsilotlari	Kitob haqida ma’lumot, baholash, izoh
📚 O‘qish sahifasi	Mock PDF reader, oq/qora fon, sozlamalar
🌟 Baholash/Izohlar	1–5 yulduzli baho va nested izohlar
📌 Saqlanganlar	Foydalanuvchi saqlagan kitoblar
👤 Profil	Foydalanuvchi ma’lumotlari, tahrirlash

🔌 API bilan integratsiya
Loyiha hozircha mock data bilan ishlaydi. Keyinchalik backend API ulanayotganda quyidagilarni bajarish kifoya:

data/repositories/ ichidagi mock implementatsiyalarni REST API implementatsiyasi bilan almashtiring.

dio paketidan foydalanib so‘rovlarni yuboring.

domain/repositories/ interfeyslarini saqlab qoling — shunchaki implementatsiyani almashtirish kifoya bo‘ladi.

Auth uchun JWT tokenlar GetX orqali global saqlanadi.

👨‍💻 Hissa qo‘shish
Har qanday Flutter dasturchi quyidagi tartibda loyihaga hissa qo‘shishi mumkin:

Fork qiling 🔀

Yangi branch yarating: feature/your-feature 🌿

O‘zgarishlar kiriting (Clean Architecture tamoyillariga amal qiling) ✍️

Pull Request yuboring 📨

Kodlar o‘qilishi oson, izohlangan va kengaytiriluvchan bo‘lishi shart.

📜 Litsenziya
Bu loyiha ochiq manbali bo‘lib, MIT litsenziyasi asosida tarqatiladi.
Batafsil: LICENSE

✨ Muallif
👨‍💻 Madaliyev Xikmatillo (Flutterchi aka)
📧 email@example.com
📱 Telegram | Instagram

📝 Eslatma: Loyihani ishlab chiqishda toza kod, soddalik va kengaytiriluvchanlik asosiy ustuvorlik bo‘lib xizmat qiladi. Kodni ko‘rgan har bir dasturchi uni tushunishi, o‘zgartirishi va kengaytirishi oson bo‘lishi kerak.