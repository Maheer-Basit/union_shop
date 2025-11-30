**Project Title and Description**
- **Title:** Union Shop
- **Description:** A simple Flutter storefront web/app for browsing and viewing product details. The app demonstrates a responsive landing page with hero banner, product grid, and individual product pages.


- **Clone the repository:**
  - `git clone https://github.com/Maheer-Basit/union_shop.git`
  - `cd union_shop/union_shop`



- **Configuration options:**
  - No external configuration by default. To point to different assets or API endpoints, modify `lib/` code where `NetworkImage` URIs are used.

- **Running tests:**
  - The project includes unit/widget tests in the `test/` folder. Run tests with:
    ```bash
    flutter test
    ```

## Project structure (key files)
- `lib/main.dart`: App entry and `HomeScreen` composition (header, hero, product grid, footer).
- `lib/models/navbar.dart`: Desktop navigation; hover underline + dropdown menus.
- `lib/models/hero_section.dart`: Extracted `HeroSection` widget used on the home screen.
- `lib/models/footer.dart`: Responsive footer with three sections and social links.
- `lib/product_page.dart`: Product detail view.
- `test/widget_test.dart`: Widget tests for `NavBar` hover, dropdowns and footer content.

## Notable implementation details
- Navigation
  - Desktop nav uses `MouseRegion` + stateful underline widgets and `PopupMenuButton` for dropdowns.
  - Mobile navigation collapses into a single `Menu` icon and uses `showModalBottomSheet` + `ExpansionTile`.
- Hero
  - Moved to `lib/models/hero_section.dart`; background image with a dark overlay and a CTA button (configurable via `HeroSection` constructor).
- Footer
  - Responsive: three-column layout on wide screens (>= 800 px) and stacked sections on narrow screens.


## Tests
- Unit/widget tests are located in the `test/` directory. Example: `test/widget_test.dart` covers hover underline and footer content.
- Run tests with `flutter test`.

- **To-do**
  - Static Homepage:
    - products section []




**Contact Information**
- **Repository owner:** Maheer-Basit
- **GitHub:** https://github.com/Maheer-Basit
- **Support / Issues:** Open an issue on the repository for bugs or feature requests.

---

