**Project Title and Description**
- **Title:** Union Shop
- **Description:** A simple Flutter storefront web/app for browsing and viewing product details. The app demonstrates a responsive landing page with hero banner, product grid, and individual product pages.


## Getting Started

**Clone and run the project:**
```bash
git clone https://github.com/Maheer-Basit/union_shop.git
cd union_shop/union_shop
flutter pub get
flutter run -d chrome
```

**Run tests:**
```bash
flutter test
```

## What's in the Project

The Union Shop is organized into clear folders so it's easy to find things:

**Main Screens** (`lib/screens/`)
- **Collections Page** — shows a grid of collection tiles with images and titles. It has the navigation bar at the top, a page title, and a footer at the bottom.
- **About Page** — tells visitors about the Union Shop. Same layout as Collections: navbar, title, content, and footer.
- **Winter Favourites** — another page to showcase seasonal products.

**Building Blocks** (`lib/widgets/`)
- **Navigation Bar** (`navbar.dart`) — the menu at the top of each page with links like "Home", "Shop", "About", etc. On desktop, links get an underline when you hover over them. On small screens, it hides itself so the mobile menu takes over.
- **Hero Section** (`hero_section.dart`) — the large banner at the top of the home page that automatically cycles through different images every few seconds, showing messages like "Essential range", "The Print Shack", etc.
- **Footer** (`footer.dart`) — appears at the bottom of every page with three columns of information and social media links. On small screens, these columns stack on top of each other.
- **Products Section** (`products_section.dart`) — a grid showing products in a nice layout with product cards.
- **Collection Tile** (`tile.dart`) — a small reusable piece that displays a collection image with a title on top. Used throughout the site.

**Pages & Routes** (`lib/main.dart`)
- The main file sets up all the pages and handles navigation. It's the entry point where everything starts.

**Tests** (`test/`)
- Tests make sure everything works correctly. The project includes tests for hover effects, navigation menus, and footer content.



**Smart Design Features:**
- **Responsive**: The layout changes automatically for different screen sizes. On big desktop screens, you see 3 columns; on tablets, 2 columns; on phones, 1 column.
- **Images work everywhere**: Local images (from the `assets/images/` folder) and online images both work the same way. This keeps tests running fast and reliable.
- **Hover effects**: When using a mouse on desktop, links and tiles respond to your hovering with visual feedback (underlines, etc).
- **Auto-scrolling hero**: The big banner at the home page automatically cycles through slides so you don't have to click.

## File Organization

```
lib/
  main.dart              ← where the app starts and routes are set up
  screens/               ← full pages (Collections, About, etc.)
  widgets/               ← reusable pieces (NavBar, Hero, Footer, etc.)
test/                    ← automatic tests to keep everything working
assets/images/           ← pictures and logos used in the app
```



- **To-do**
  - Static Homepage:
    - products section []




**Contact Information**
- **Repository owner:** Maheer-Basit
- **GitHub:** https://github.com/Maheer-Basit
- **Support / Issues:** Open an issue on the repository for bugs or feature requests.

---

