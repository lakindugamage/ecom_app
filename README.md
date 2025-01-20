# Ecom app

A simple e-commerce application where users can browse products, add them to a cart, and proceed to checkout. Mock API service to fetch product data. BloC is used as the state management solution to manage the app's state (cart, product list and user data).

Light and dark theme is added, so that the user can choose the theme which is prefered. The splash screen is also changes according to the theme. The app logo and the splash screen logo is done using **Figma**.

## Features

- **Real-time Data**: Fetches product and user data using an external API.
- **Prouduct Search**: Products can be searched from the search products field.
- **Product Quantity Changer**: Product qunatities can be changed after the products are added to the cart and if the user presses the same product, the qunatity of the product changes without adding the same product to the cart. The qunatity can be changed in the order confirmation page.
- **Light and Dark Themes**: Toggle between light and dark modes for a personalized experience.
- **Data entry check**: Check whether the name contains only characters and the contact number can only contain digits.
- **Deleting Products**: Press the trash button for the selected product in the my cart screen to remove the product. This feature is also available in the order confirmation screen.

## Images of the user interface.

**Dark Mode and Light Mode**

<p float="center">
  <img src="lib/assets/ecom_dark_mode.png" width="30%" />
  <img src="lib/assets/ecom_light_mode.png" width="30%" /> 
</p>

## Getting Started

### Prerequisites

- Install the [Flutter SDK](https://flutter.dev/docs/get-started/install).
- Install an IDE like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
- Make sure you have a connected device or an emulator to run the app.

### Clone the Repository

Clone this repository to your local machine using Git:

```bash
git clone https://github.com/lakindugamage/ecom_app.git
