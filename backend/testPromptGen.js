// ----->>>>    NOTE    <<<<-----

// This file was created for testing purposes. This follows a different approach for Web Generation i.e Raw Structured Prompt -> Web Files
// Feel free to use this as per your convenience :-)

// const { GoogleGenerativeAI } = require("@google/generative-ai");
// require("dotenv").config();

// const apiKey = process.env.api_key;
// const genAI = new GoogleGenerativeAI(apiKey);

// const model = genAI.getGenerativeModel({
//   model: "gemini-1.5-flash",
// });

// const generationConfig = {
//   temperature: 1,
//   topP: 0.95,
//   topK: 64,
//   maxOutputTokens: 8192,
//   responseMimeType: "text/plain",
// };

// async function extractRelevantInfo(domain, description) {
//   try {
//     let url;
//     if (domain == "xyz") {
//       url = `url${description}`;
//     } else if (domain == "xyz") {
//       url = `url${description}`;
//     } else if (domain == "xyz") {
//       url = `url${description}`;
//     } else {
//       throw new Error("Unsupported Domain");
//     }
//     const response = await axios.get(url);
//     console.log(response);
//     if (!response) {
//       throw new Error("Failed to extract info Trying Fallback Urls");
//     }
//   } catch (error) {
//     const fallbackResponse = await axios.get(
//       FallbackHelper(domain, description)
//     );
//     console.log(fallbackResponse);
//   }
// }

// async function FallbackHelper(domain, description) {
//   // backup urls wiki
//   // same if else ladder logic as extractRelevantInfo
//   let url;
//   url = `wiki url for reference ${description}`;
//   const response = await axios.get(url);
//   console.log(response);
// }

// async function generateWebsite(
//   description
//   // colorScheme,
//   // layoutPreferences,
//   // features
//   // domain,
//   // storedImageUrls
// ) {
//   const prompt =
//     `User provides the following details:\n\n` +
//     `Description: ${description}\n\n` +
//     // `Color scheme: ${colorScheme}\n\n` +
//     // `Layout preferences: ${layoutPreferences}\n\n` +
//     // `Any specific features: ${features}\n\n` +
//     // `Relevant Reference Repo: ${extractRelevantInfo(domain, description)}\n\n` +
//     `Create the following files for the website:\n\n` +
//     `1. HTML file content (index.html)\n` +
//     `2. CSS file content (styles.css)\n` +
//     // `3. JS file content (scripts.js)\n\n` +
//     `Requirements:\n` +
//     `1. Ensure the HTML, CSS are fully compatible with each other.\n` +
//     // `2. Ensure there are no unknown variables or syntax errors in the JS file.\n` +
//     `3. Return the output in a JSON format with no extra characters or line breaks that would cause parsing errors.\n` +
//     `4. Use the following JSON structure for the output:\n` +
//     `{\n` +
//     `"html": "<html content>",\n` +
//     `"css": "<css content>",\n` +
//     // `"js": "<js content>"\n` +
//     `}`;
//   // `I should not get any errors like SyntaxError: Expected ',' or '}' after property value in JSON at position 3313
//   // at JSON.parse (<anonymous> while parsing the JSON so make sure to keep that in mind. I have provided you with many examples before. So avoid giving me the incorrect JSON file and Synctactical Errors while parsing
//   // Ensure that the JavaScript code is properly escaped or handled correctly in the JSON string.`;
//   // `JavaScript file content (scripts.js)\n\n` +
//   // `Make sure to generate only the code for each file with complete logic without any explanations, so that the user can simply run the index.html file without any errors.
//   // Also give these files in json format so that I can access each one of them using variable.html,.css and .js
//   // Make sure to not give the user anything to work on as in don't declare any variable or style for which user have to write something. I'm using this prompt to directly generate the file and run it without any edits. So it should not have any of the Undeclared styles or something undefined in the JS script. Its fine if the logic is not complete, the code should be complete. Also make sure to don't give any extra unnecessary spaces in the .js file.`;

//   const chatSession = model.startChat({
//     generationConfig,
//     history: [
//       {
//         role: "user",
//         parts: [
//           {
//             text: "`User provides the following details:\\n\\n` +\n    `Website name: ${title}\\n\\n` +\n    `Description: ${description}\\n\\n` +\n    `Color scheme: ${colorScheme}\\n\\n` +\n    `Layout preferences: ${layoutPreferences}\\n\\n` +\n    `Any specific features: ${features}\\n\\n` +\n    `Create the following files for the website:\\n\\n` +\n    `HTML file content (index.html)\\n\\n` +\n    `CSS file content (styles.css)\\n\\n` +\n    `JavaScript file content (scripts.js)\\n\\n` +\n    `Make sure to generate only the code for each file with complete logic without any explanations, so that the user can simply run the index.html file without any errors.\n    Also give these files in json format so that I can access each one of them using variable.html,.css and .js\n    Make sure to not give the user anything to work on as in don't declare any variable or style for which user have to write something. I'm using this prompt to directly generate the file and run it without any edits. So it should not have any of the Undeclared styles or something undefined in the JS script. Its fine if the logic is not complete, the code should be complete. Also make sure to don't give any extra unnecessary spaces in the .js file. Give one big block for the JS file.`\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{\n  "html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>${title}</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>",\n  "css": "/* General Styles */\\nbody {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: ${colorScheme.backgroundColor};\\n  color: ${colorScheme.textColor};\\n}\\n\\n/* Layout Styles (Based on user\'s layout preferences) */\\n/* Example: */\\n.container {\\n  width: 80%;\\n  margin: 0 auto;\\n}\\n\\n/* Feature-specific Styles (Based on user\'s features) */\\n/* Example: */\\n.feature-1 {\\n  /* Styles for feature 1 */\\n}\\n\\n/* ... other features */",\n  "js": "/* JavaScript Logic (Based on user\'s features) */\\n/* Example: */\\nconst feature1Element = document.querySelector(\'.feature-1\');\\nfeature1Element.addEventListener(\'click\', () => {\\n  // Logic for feature 1\\n});\\n\\n/* ... other features */"\n}\n``` \n',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "User provides the following details:\n\nWebsite name: Tech Blog\n\nDescription: A blog dedicated to the latest in technology and innovation.\n\nColor scheme: White background with black and blue accents.\n\nLayout preferences: Single-column layout with a sidebar.\n\nAny specific features: Search bar, recent posts widget.\n\nCreate the following files for the website:\n\nHTML file content (index.html)\n\nCSS file content (styles.css)\n\nJavaScript file content (scripts.js)\n\nMake sure to generate only the code for each file with complete logic without any explanations, so that the user can simply run the index.html file without any errors. Also give these files in json format so that I can access each one of them using variable.html,.css and .js. Make sure to not give the user anything to work on as in don't declare any variable or style for which user have to write something. I'm using this prompt to directly generate the file and run it without any edits. So it should not have any of the Undeclared styles or something undefined in the JS script. Its fine if the logic is not complete, the code should be complete. Also make sure to don't give any extra unnecessary spaces in the .js file. Also, keep the given format same for all this answer and all of the upcoming ones. Also give the json in the correct format without any unnecessary white spaces so that it can be correctly parsed by the JSON parser without any errors.\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{\n  "html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Tech Blog</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Tech Blog</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Home</a></li>\\n        <li><a href=\\"#\\">About</a></li>\\n        <li><a href=\\"#\\">Contact</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"content\\">\\n      <!-- Blog Posts will go here -->\\n    </section>\\n    <aside class=\\"sidebar\\">\\n      <div class=\\"widget\\">\\n        <h3>Search</h3>\\n        <input type=\\"text\\" placeholder=\\"Search...\\">\\n      </div>\\n      <div class=\\"widget\\">\\n        <h3>Recent Posts</h3>\\n        <!-- Recent posts list will go here -->\\n      </div>\\n    </aside>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Tech Blog</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>",\n  "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: white;\\n  color: black;\\n}\\n\\nheader {\\n  background-color: #007bff;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  display: flex;\\n  padding: 20px;\\n}\\n\\n.content {\\n  flex: 1;\\n  margin-right: 20px;\\n}\\n\\n.sidebar {\\n  width: 300px;\\n}\\n\\n.widget {\\n  background-color: #f2f2f2;\\n  padding: 20px;\\n  margin-bottom: 20px;\\n}\\n\\nfooter {\\n  background-color: #333;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}",\n  "js": "/* Example JavaScript Logic (Replace with actual functionality) */\\nconst searchInput = document.querySelector(\'input[type=\\"text\\"]\');\\nsearchInput.addEventListener(\'input\', () => {\\n  // Search functionality (e.g., filter posts based on search term)\\n});\\n\\nconst recentPostsWidget = document.querySelector(\'.widget h3:nth-child(2)\');\\nrecentPostsWidget.addEventListener(\'click\', () => {\\n  // Recent posts functionality (e.g., load more recent posts)\\n});"\n}\n```',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "User provides the following details:\n\nWebsite name: Food Recipes\n\nDescription: A collection of delicious and easy-to-make recipes.\n\nColor scheme: Light beige background with green and brown accents.\n\nLayout preferences: Grid layout with recipe cards.\n\nAny specific features: Search bar, category filter.\n\nCreate the following files for the website:\n\nHTML file content (index.html)\n\nCSS file content (styles.css)\n\nJavaScript file content (scripts.js) Also give the json in the correct format without any unnecessary white spaces so that it can be correctly parsed by the JSON parser without any errors.\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{\n  "html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Food Recipes</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Food Recipes</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Home</a></li>\\n        <li><a href=\\"#\\">About</a></li>\\n        <li><a href=\\"#\\">Contact</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"search-filter\\">\\n      <input type=\\"text\\" placeholder=\\"Search recipes...\\">\\n      <select>\\n        <option value=\\"all\\">All Categories</option>\\n        <option value=\\"appetizers\\">Appetizers</option>\\n        <option value=\\"main-course\\">Main Course</option>\\n        <option value=\\"desserts\\">Desserts</option>\\n      </select>\\n    </section>\\n    <section class=\\"recipes-grid\\">\\n      <!-- Recipe Cards will go here -->\\n    </section>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Food Recipes</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>",\n  "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: #f5f5f0;\\n  color: #333;\\n}\\n\\nheader {\\n  background-color: #4CAF50;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  padding: 20px;\\n}\\n\\n.search-filter {\\n  display: flex;\\n  justify-content: space-between;\\n  align-items: center;\\n  margin-bottom: 20px;\\n}\\n\\n.recipes-grid {\\n  display: grid;\\n  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));\\n  gap: 20px;\\n}\\n\\n.recipe-card {\\n  background-color: #fff;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nfooter {\\n  background-color: #663300;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}",\n  "js": "const searchInput = document.querySelector(\'input[type=\\"text\\"]\');\\nconst categorySelect = document.querySelector(\'select\');\\nconst recipesGrid = document.querySelector(\'.recipes-grid\');\\n\\nsearchInput.addEventListener(\'input\', () => {\\n  // Filter recipes based on search term\\n});\\n\\ncategorySelect.addEventListener(\'change\', () => {\\n  // Filter recipes based on selected category\\n});\\n\\n// Fetch and display recipe data (e.g., from an API or local data)\\nfetchRecipes();\\n\\nfunction fetchRecipes() {\\n  // Placeholder for recipe fetching logic\\n  // Example: fetching data from an API\\n  fetch(\'https://api.example.com/recipes\')\\n    .then(response => response.json())\\n    .then(data => {\\n      displayRecipes(data);\\n    })\\n    .catch(error => {\\n      console.error(\'Error fetching recipes:\', error);\\n    });\\n}\\n\\nfunction displayRecipes(recipes) {\\n  // Clear previous recipes\\n  recipesGrid.innerHTML = \'\';\\n\\n  // Create recipe cards for each recipe\\n  recipes.forEach(recipe => {\\n    const recipeCard = document.createElement(\'div\');\\n    recipeCard.classList.add(\'recipe-card\');\\n    recipeCard.innerHTML = `\\n      <h2>${recipe.title}</h2>\\n      <img src="${recipe.image}" alt="${recipe.title}">\\n      <p>${recipe.description}</p>\\n      <a href="${recipe.url}" target=\\"_blank\\">View Recipe</a>\\n    `;\\n    recipesGrid.appendChild(recipeCard);\\n  });\\n}"\n}\n```',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "you can add random image urls on your own. Dont give the files in such a way that If I run the index.html file directly ill get errors. So please either dont include images or give urls of real images from the globe.\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{\n  "html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Food Recipes</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Food Recipes</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Home</a></li>\\n        <li><a href=\\"#\\">About</a></li>\\n        <li><a href=\\"#\\">Contact</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"search-filter\\">\\n      <input type=\\"text\\" placeholder=\\"Search recipes...\\">\\n      <select>\\n        <option value=\\"all\\">All Categories</option>\\n        <option value=\\"appetizers\\">Appetizers</option>\\n        <option value=\\"main-course\\">Main Course</option>\\n        <option value=\\"desserts\\">Desserts</option>\\n      </select>\\n    </section>\\n    <section class=\\"recipes-grid\\">\\n      <!-- Recipe Cards will go here -->\\n    </section>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Food Recipes</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>",\n  "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: #f5f5f0;\\n  color: #333;\\n}\\n\\nheader {\\n  background-color: #4CAF50;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  padding: 20px;\\n}\\n\\n.search-filter {\\n  display: flex;\\n  justify-content: space-between;\\n  align-items: center;\\n  margin-bottom: 20px;\\n}\\n\\n.recipes-grid {\\n  display: grid;\\n  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));\\n  gap: 20px;\\n}\\n\\n.recipe-card {\\n  background-color: #fff;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nfooter {\\n  background-color: #663300;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}",\n  "js": "const searchInput = document.querySelector(\'input[type=\\"text\\"]\');\\nconst categorySelect = document.querySelector(\'select\');\\nconst recipesGrid = document.querySelector(\'.recipes-grid\');\\n\\nsearchInput.addEventListener(\'input\', () => {\\n  // Filter recipes based on search term\\n});\\n\\ncategorySelect.addEventListener(\'change\', () => {\\n  // Filter recipes based on selected category\\n});\\n\\n// Sample recipe data (replace with actual data from an API or local source)\\nconst recipes = [\\n  {\\n    title: \\"Classic Spaghetti with Meatballs\\",\\n    image: \\"https://images.unsplash.com/photo-1544789856-e4d22682d14d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"A timeless Italian favorite with juicy meatballs and flavorful tomato sauce.\\",\\n    url: \\"https://www.example.com/recipes/spaghetti-meatballs\\"\\n  },\\n  {\\n    title: \\"Chicken Tikka Masala\\",\\n    image: \\"https://images.unsplash.com/photo-1509398454779-e2393a1d390a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"A flavorful Indian dish with tender chicken in a creamy tomato sauce.\\",\\n    url: \\"https://www.example.com/recipes/chicken-tikka-masala\\"\\n  },\\n  {\\n    title: \\"Chocolate Chip Cookies\\",\\n    image: \\"https://images.unsplash.com/photo-1565399094243-2d53e4a5018c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"The classic chewy and delicious chocolate chip cookies.\\",\\n    url: \\"https://www.example.com/recipes/chocolate-chip-cookies\\"\\n  }\\n];\\n\\n// Display recipes\\ndisplayRecipes(recipes);\\n\\nfunction displayRecipes(recipes) {\\n  recipesGrid.innerHTML = \'\';\\n  recipes.forEach(recipe => {\\n    const recipeCard = document.createElement(\'div\');\\n    recipeCard.classList.add(\'recipe-card\');\\n    recipeCard.innerHTML = `\\n      <h2>${recipe.title}</h2>\\n      <img src="${recipe.image}" alt="${recipe.title}">\\n      <p>${recipe.description}</p>\\n      <a href="${recipe.url}" target=\\"_blank\\">View Recipe</a>\\n    `;\\n    recipesGrid.appendChild(recipeCard);\\n  });\\n}"\n}\n```',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "User provides the following details:\n\nWebsite name: Travel Guide\n\nDescription: A comprehensive guide for travelers with tips and destination information.\n\nColor scheme: Light blue background with dark blue accents.\n\nLayout preferences: Multi-column layout with a featured destinations section.\n\nAny specific features: Interactive map, top destinations carousel.\n\nCreate the following files for the website:\n\nHTML file content (index.html)\n\nCSS file content (styles.css)\n\nJavaScript file content (scripts.js)\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{\n  "html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Travel Guide</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Travel Guide</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Home</a></li>\\n        <li><a href=\\"#\\">Destinations</a></li>\\n        <li><a href=\\"#\\">Tips</a></li>\\n        <li><a href=\\"#\\">About</a></li>\\n        <li><a href=\\"#\\">Contact</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"featured-destinations\\">\\n      <h2>Featured Destinations</h2>\\n      <div class=\\"carousel\\">\\n        <!-- Destination cards will go here -->\\n      </div>\\n    </section>\\n    <section class=\\"interactive-map\\">\\n      <h2>Explore the World</h2>\\n      <!-- Map will be inserted here -->\\n    </section>\\n    <section class=\\"destinations\\">\\n      <!-- Destinations list will go here -->\\n    </section>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Travel Guide</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>",\n  "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: #e0f2f7;\\n  color: #333;\\n}\\n\\nheader {\\n  background-color: #007bff;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  padding: 20px;\\n}\\n\\n.featured-destinations {\\n  text-align: center;\\n  margin-bottom: 20px;\\n}\\n\\n.carousel {\\n  /* Styles for the carousel (e.g., using a library or custom implementation) */\\n}\\n\\n.interactive-map {\\n  text-align: center;\\n  margin-bottom: 20px;\\n}\\n\\n.destinations {\\n  display: grid;\\n  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));\\n  gap: 20px;\\n}\\n\\n.destination-card {\\n  background-color: #fff;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nfooter {\\n  background-color: #0056b3;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}",\n  "js": "const carousel = document.querySelector(\'.carousel\');\\n\\n// Initialize the carousel (e.g., using a library like Swiper.js)\\n// Example: (Assuming Swiper.js is included)\\nconst mySwiper = new Swiper(\'.carousel\', {\\n  // Carousel configuration\\n});\\n\\n// Interactive Map (e.g., using Leaflet.js)\\nconst mapContainer = document.querySelector(\'.interactive-map\');\\n\\n// Initialize the map (e.g., using Leaflet.js)\\n// Example: (Assuming Leaflet.js is included)\\nconst myMap = L.map(\'interactive-map\').setView([51.505, -0.09], 13);\\nL.tileLayer(\'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png\', {\\n  attribution: \'&copy; <a href=\\"https://www.openstreetmap.org/copyright\\">OpenStreetMap</a> contributors\'\\n}).addTo(myMap);\\n\\n// Destination Data (Replace with actual data from an API or local source)\\nconst destinations = [\\n  {\\n    name: \\"Paris, France\\",\\n    image: \\"https://images.unsplash.com/photo-1525252997910-0378e7917d0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"The City of Lights, renowned for its romance, art, and cuisine.\\",\\n    url: \\"https://www.example.com/destinations/paris\\"\\n  },\\n  {\\n    name: \\"Tokyo, Japan\\",\\n    image: \\"https://images.unsplash.com/photo-1540569455282-0955a818b32a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"A bustling metropolis with a unique blend of tradition and modernity.\\",\\n    url: \\"https://www.example.com/destinations/tokyo\\"\\n  },\\n  {\\n    name: \\"New York City, USA\\",\\n    image: \\"https://images.unsplash.com/photo-1524838788739-2938438038d1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"The Big Apple, a global hub of culture, finance, and entertainment.\\",\\n    url: \\"https://www.example.com/destinations/new-york-city\\"\\n  }\\n];\\n\\n// Display destination cards in the carousel\\ndisplayDestinations(destinations);\\n\\nfunction displayDestinations(destinations) {\\n  destinations.forEach(destination => {\\n    const destinationCard = document.createElement(\'div\');\\n    destinationCard.classList.add(\'destination-card\');\\n    destinationCard.innerHTML = `\\n      <img src="${destination.image}" alt="${destination.name}">\\n      <h2>${destination.name}</h2>\\n      <p>${destination.description}</p>\\n      <a href="${destination.url}" target=\\"_blank\\">Learn More</a>\\n    `;\\n    carousel.appendChild(destinationCard);\\n  });\\n  // Update the carousel if using a library like Swiper.js\\n  mySwiper.update();\\n}\\n\\n// Display destinations list\\ndisplayDestinationsList(destinations);\\n\\nfunction displayDestinationsList(destinations) {\\n  const destinationsSection = document.querySelector(\'.destinations\');\\n  destinations.forEach(destination => {\\n    const destinationCard = document.createElement(\'div\');\\n    destinationCard.classList.add(\'destination-card\');\\n    destinationCard.innerHTML = `\\n      <img src="${destination.image}" alt="${destination.name}">\\n      <h2>${destination.name}</h2>\\n      <p>${destination.description}</p>\\n      <a href="${destination.url}" target=\\"_blank\\">Learn More</a>\\n    `;\\n    destinationsSection.appendChild(destinationCard);\\n  });\\n}"\n}\n```\n\n',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "User provides the following details:\n\nWebsite name: Fitness Tracker\n\nDescription: A tool to track workouts, nutrition, and progress.\n\nColor scheme: White background with grey and green accents.\n\nLayout preferences: Dashboard layout with charts and stats.\n\nAny specific features: Login system, progress charts.\n\nCreate the following files for the website:\n\nHTML file content (index.html)\n\nCSS file content (styles.css)\n\nJavaScript file content (scripts.js)\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{\n  "html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Fitness Tracker</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Fitness Tracker</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Dashboard</a></li>\\n        <li><a href=\\"#\\">Workouts</a></li>\\n        <li><a href=\\"#\\">Nutrition</a></li>\\n        <li><a href=\\"#\\">Progress</a></li>\\n        <li><a href=\\"#\\">Settings</a></li>\\n        <li><a href=\\"#\\">Logout</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"dashboard\\">\\n      <h2>Dashboard</h2>\\n      <div class=\\"stats\\">\\n        <div class=\\"stat\\">\\n          <h3>Total Workouts</h3>\\n          <p>0</p>\\n        </div>\\n        <div class=\\"stat\\">\\n          <h3>Calories Burned</h3>\\n          <p>0</p>\\n        </div>\\n        <div class=\\"stat\\">\\n          <h3>Weight</h3>\\n          <p>0</p>\\n        </div>\\n      </div>\\n      <div class=\\"charts\\">\\n        <div class=\\"chart\\">\\n          <h3>Weight Progress</h3>\\n          <!-- Chart will be inserted here -->\\n        </div>\\n        <div class=\\"chart\\">\\n          <h3>Workout Frequency</h3>\\n          <!-- Chart will be inserted here -->\\n        </div>\\n      </div>\\n    </section>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Fitness Tracker</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>",\n  "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: #fff;\\n  color: #333;\\n}\\n\\nheader {\\n  background-color: #4CAF50;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  padding: 20px;\\n}\\n\\n.dashboard {\\n  text-align: center;\\n}\\n\\n.stats {\\n  display: flex;\\n  justify-content: space-around;\\n  margin-bottom: 20px;\\n}\\n\\n.stat {\\n  background-color: #f2f2f2;\\n  padding: 20px;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  width: calc(100% / 3 - 20px);\\n}\\n\\n.charts {\\n  display: flex;\\n  justify-content: space-around;\\n}\\n\\n.chart {\\n  background-color: #f2f2f2;\\n  padding: 20px;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  width: calc(100% / 2 - 20px);\\n}\\n\\nfooter {\\n  background-color: #663300;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}",\n  "js": "const stats = document.querySelectorAll(\'.stat p\');\\nconst weightChartContainer = document.querySelector(\'.chart:nth-child(1)\');\\nconst workoutChartContainer = document.querySelector(\'.chart:nth-child(2)\');\\n\\n// Login System (e.g., using local storage or an API)\\n// Example: (Assuming local storage is used)\\nconst user = JSON.parse(localStorage.getItem(\'user\'));\\n\\nif (user) {\\n  // User is logged in\\n  // Display welcome message\\n  // Update stats with user data\\n  stats[0].textContent = user.totalWorkouts;\\n  stats[1].textContent = user.caloriesBurned;\\n  stats[2].textContent = user.weight;\\n\\n  // Render charts with user data\\n  renderWeightChart(user.weightData);\\n  renderWorkoutChart(user.workoutData);\\n} else {\\n  // User is not logged in\\n  // Redirect to login page\\n  window.location.href = \'login.html\';\\n}\\n\\n// Function to render weight progress chart\\nfunction renderWeightChart(weightData) {\\n  // Example: (Using a charting library like Chart.js)\\n  // Ensure Chart.js is included\\n  const myChart = new Chart(weightChartContainer, {\\n    type: \'line\',\\n    data: {\\n      labels: weightData.dates,\\n      datasets: [{\\n        label: \'Weight (kg)\',\\n        data: weightData.weights,\\n        borderColor: \'green\',\\n        borderWidth: 1\\n      }]\\n    }\\n  });\\n}\\n\\n// Function to render workout frequency chart\\nfunction renderWorkoutChart(workoutData) {\\n  // Example: (Using a charting library like Chart.js)\\n  // Ensure Chart.js is included\\n  const myChart = new Chart(workoutChartContainer, {\\n    type: \'bar\',\\n    data: {\\n      labels: workoutData.dates,\\n      datasets: [{\\n        label: \'Workout Frequency\',\\n        data: workoutData.frequencies,\\n        backgroundColor: \'green\'\\n      }]\\n    }\\n  });\\n}"\n}\n```',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "Make sure to give in the correct json format without any unnecessary white spaces so that it can be easily parsed by the JSON Parser. Remember this for all the future Prompts.",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{"html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Fitness Tracker</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Fitness Tracker</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Dashboard</a></li>\\n        <li><a href=\\"#\\">Workouts</a></li>\\n        <li><a href=\\"#\\">Nutrition</a></li>\\n        <li><a href=\\"#\\">Progress</a></li>\\n        <li><a href=\\"#\\">Settings</a></li>\\n        <li><a href=\\"#\\">Logout</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"dashboard\\">\\n      <h2>Dashboard</h2>\\n      <div class=\\"stats\\">\\n        <div class=\\"stat\\">\\n          <h3>Total Workouts</h3>\\n          <p>0</p>\\n        </div>\\n        <div class=\\"stat\\">\\n          <h3>Calories Burned</h3>\\n          <p>0</p>\\n        </div>\\n        <div class=\\"stat\\">\\n          <h3>Weight</h3>\\n          <p>0</p>\\n        </div>\\n      </div>\\n      <div class=\\"charts\\">\\n        <div class=\\"chart\\">\\n          <h3>Weight Progress</h3>\\n          <!-- Chart will be inserted here -->\\n        </div>\\n        <div class=\\"chart\\">\\n          <h3>Workout Frequency</h3>\\n          <!-- Chart will be inserted here -->\\n        </div>\\n      </div>\\n    </section>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Fitness Tracker</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>", "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: #fff;\\n  color: #333;\\n}\\n\\nheader {\\n  background-color: #4CAF50;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  padding: 20px;\\n}\\n\\n.dashboard {\\n  text-align: center;\\n}\\n\\n.stats {\\n  display: flex;\\n  justify-content: space-around;\\n  margin-bottom: 20px;\\n}\\n\\n.stat {\\n  background-color: #f2f2f2;\\n  padding: 20px;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  width: calc(100% / 3 - 20px);\\n}\\n\\n.charts {\\n  display: flex;\\n  justify-content: space-around;\\n}\\n\\n.chart {\\n  background-color: #f2f2f2;\\n  padding: 20px;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  width: calc(100% / 2 - 20px);\\n}\\n\\nfooter {\\n  background-color: #663300;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}", "js": "const stats = document.querySelectorAll(\'.stat p\');\\nconst weightChartContainer = document.querySelector(\'.chart:nth-child(1)\');\\nconst workoutChartContainer = document.querySelector(\'.chart:nth-child(2)\');\\n\\n// Login System (e.g., using local storage or an API)\\n// Example: (Assuming local storage is used)\\nconst user = JSON.parse(localStorage.getItem(\'user\'));\\n\\nif (user) {\\n  // User is logged in\\n  // Display welcome message\\n  // Update stats with user data\\n  stats[0].textContent = user.totalWorkouts;\\n  stats[1].textContent = user.caloriesBurned;\\n  stats[2].textContent = user.weight;\\n\\n  // Render charts with user data\\n  renderWeightChart(user.weightData);\\n  renderWorkoutChart(user.workoutData);\\n} else {\\n  // User is not logged in\\n  // Redirect to login page\\n  window.location.href = \'login.html\';\\n}\\n\\n// Function to render weight progress chart\\nfunction renderWeightChart(weightData) {\\n  // Example: (Using a charting library like Chart.js)\\n  // Ensure Chart.js is included\\n  const myChart = new Chart(weightChartContainer, {\\n    type: \'line\',\\n    data: {\\n      labels: weightData.dates,\\n      datasets: [{\\n        label: \'Weight (kg)\',\\n        data: weightData.weights,\\n        borderColor: \'green\',\\n        borderWidth: 1\\n      }]\\n    }\\n  });\\n}\\n\\n// Function to render workout frequency chart\\nfunction renderWorkoutChart(workoutData) {\\n  // Example: (Using a charting library like Chart.js)\\n  // Ensure Chart.js is included\\n  const myChart = new Chart(workoutChartContainer, {\\n    type: \'bar\',\\n    data: {\\n      labels: workoutData.dates,\\n      datasets: [{\\n        label: \'Workout Frequency\',\\n        data: workoutData.frequencies,\\n        backgroundColor: \'green\'\\n      }]\\n    }\\n  });\\n}"\n}\n```',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "User provides the following details:\n\nWebsite name: Recipe Hub\n\nDescription: A platform to share and discover recipes from around the world.\n\nColor scheme: Cream background with brown and red accents.\n\nLayout preferences: Grid layout with recipe cards.\n\nAny specific features: User reviews, rating system.\n\nCreate the following files for the website:\n\nHTML file content (index.html)\n\nCSS file content (styles.css)\n\nJavaScript file content (scripts.js)\nmake sure to check the json syntax and compatibility of all the files within them\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{"html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Recipe Hub</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Recipe Hub</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Home</a></li>\\n        <li><a href=\\"#\\">Explore</a></li>\\n        <li><a href=\\"#\\">About</a></li>\\n        <li><a href=\\"#\\">Contact</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"recipes-grid\\">\\n      <!-- Recipe Cards will go here -->\\n    </section>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Recipe Hub</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>", "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: #f5f5e0;\\n  color: #333;\\n}\\n\\nheader {\\n  background-color: #8B4513;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  padding: 20px;\\n}\\n\\n.recipes-grid {\\n  display: grid;\\n  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));\\n  gap: 20px;\\n}\\n\\n.recipe-card {\\n  background-color: #fff;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\n.recipe-card img {\\n  max-width: 100%;\\n  height: auto;\\n  margin-bottom: 10px;\\n}\\n\\n.recipe-card h2 {\\n  margin-bottom: 5px;\\n}\\n\\n.recipe-card p {\\n  margin-bottom: 10px;\\n}\\n\\n.recipe-card .rating {\\n  display: flex;\\n  align-items: center;\\n  margin-bottom: 10px;\\n}\\n\\n.recipe-card .rating span {\\n  margin-left: 5px;\\n}\\n\\nfooter {\\n  background-color: #A52A2A;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}", "js": "const recipesGrid = document.querySelector(\'.recipes-grid\');\\n\\n// Sample recipe data (Replace with actual data from an API or local source)\\nconst recipes = [\\n  {\\n    title: \\"Classic Chocolate Chip Cookies\\",\\n    image: \\"https://images.unsplash.com/photo-1565399094243-2d53e4a5018c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"The classic chewy and delicious chocolate chip cookies.\\",\\n    rating: 4.5,\\n    reviews: [\\n      { user: \\"John Doe\\", text: \\"Amazing recipe!\\" },\\n      { user: \\"Jane Smith\\", text: \\"So easy to make and delicious.\\" }\\n    ]\\n  },\\n  {\\n    title: \\"Spaghetti with Meatballs\\",\\n    image: \\"https://images.unsplash.com/photo-1544789856-e4d22682d14d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"A timeless Italian favorite with juicy meatballs and flavorful tomato sauce.\\",\\n    rating: 4.2,\\n    reviews: [\\n      { user: \\"Alice Johnson\\", text: \\"This is my go-to spaghetti recipe!\\" }\\n    ]\\n  },\\n  {\\n    title: \\"Chicken Tikka Masala\\",\\n    image: \\"https://images.unsplash.com/photo-1509398454779-e2393a1d390a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80\\",\\n    description: \\"A flavorful Indian dish with tender chicken in a creamy tomato sauce.\\",\\n    rating: 4.8,\\n    reviews: [\\n      { user: \\"Bob Williams\\", text: \\"Absolutely delicious!\\" },\\n      { user: \\"Carol Brown\\", text: \\"The best chicken tikka masala I\'ve ever had.\\" }\\n    ]\\n  }\\n];\\n\\n// Display recipes\\ndisplayRecipes(recipes);\\n\\nfunction displayRecipes(recipes) {\\n  recipesGrid.innerHTML = \'\';\\n  recipes.forEach(recipe => {\\n    const recipeCard = document.createElement(\'div\');\\n    recipeCard.classList.add(\'recipe-card\');\\n    recipeCard.innerHTML = `\\n      <img src="${recipe.image}" alt="${recipe.title}">\\n      <h2>${recipe.title}</h2>\\n      <p>${recipe.description}</p>\\n      <div class=\\"rating\\">\\n        <span>Rating: ${recipe.rating}/5</span>\\n      </div>\\n      <button class=\\"view-reviews\\">View Reviews</button>\\n      <div class=\\"reviews\\" style=\\"display: none;\\">\\n        <h3>Reviews</h3>\\n        <ul>\\n          ${recipe.reviews.map(review => `<li>${review.user}: ${review.text}</li>`).join(\'\')}\\n        </ul>\\n      </div>\\n    `;\\n    recipesGrid.appendChild(recipeCard);\\n\\n    // Add event listener for view reviews button\\n    const viewReviewsButton = recipeCard.querySelector(\'.view-reviews\');\\n    const reviewsSection = recipeCard.querySelector(\'.reviews\');\\n    viewReviewsButton.addEventListener(\'click\', () => {\\n      reviewsSection.style.display = reviewsSection.style.display === \'none\' ? \'block\' : \'none\';\\n    });\\n  });\\n}"\n}\n```\n\n',
//           },
//         ],
//       },
//       {
//         role: "user",
//         parts: [
//           {
//             text: "User provides the following details:\n\nWebsite name: Online Store\n\nDescription: An e-commerce website for selling electronics.\n\nColor scheme: White background with blue and grey accents.\n\nLayout preferences: Product grid with a sidebar filter.\n\nAny specific features: Shopping cart, product search.\n\nCreate the following files for the website:\n\nHTML file content (index.html)\n\nCSS file content (styles.css)\n\nJavaScript file content (scripts.js)\nmake sure to keep the json syntax in check along with the compatibility of the files without using any external imagery.\n",
//           },
//         ],
//       },
//       {
//         role: "model",
//         parts: [
//           {
//             text: '```json\n{"html": "<!DOCTYPE html>\\n<html lang=\\"en\\">\\n<head>\\n  <meta charset=\\"UTF-8\\">\\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n  <title>Online Store</title>\\n  <link rel=\\"stylesheet\\" href=\\"styles.css\\">\\n</head>\\n<body>\\n  <header>\\n    <h1>Online Store</h1>\\n    <nav>\\n      <ul>\\n        <li><a href=\\"#\\">Home</a></li>\\n        <li><a href=\\"#\\">About</a></li>\\n        <li><a href=\\"#\\">Contact</a></li>\\n        <li><a href=\\"#\\">Cart</a></li>\\n      </ul>\\n    </nav>\\n  </header>\\n  <main>\\n    <section class=\\"sidebar\\">\\n      <h2>Filter</h2>\\n      <!-- Filter options will go here -->\\n    </section>\\n    <section class=\\"products-grid\\">\\n      <!-- Products will be displayed here -->\\n    </section>\\n  </main>\\n  <footer>\\n    <p>&copy; 2023 Online Store</p>\\n  </footer>\\n  <script src=\\"scripts.js\\"></script>\\n</body>\\n</html>", "css": "body {\\n  font-family: sans-serif;\\n  margin: 0;\\n  padding: 0;\\n  background-color: #fff;\\n  color: #333;\\n}\\n\\nheader {\\n  background-color: #007bff;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\nnav ul {\\n  list-style: none;\\n  margin: 0;\\n  padding: 0;\\n  text-align: center;\\n}\\n\\nnav li {\\n  display: inline-block;\\n  margin: 0 10px;\\n}\\n\\nmain {\\n  display: flex;\\n  padding: 20px;\\n}\\n\\n.sidebar {\\n  width: 200px;\\n  margin-right: 20px;\\n}\\n\\n.products-grid {\\n  display: grid;\\n  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));\\n  gap: 20px;\\n}\\n\\n.product-card {\\n  background-color: #f2f2f2;\\n  border-radius: 10px;\\n  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\\n  padding: 20px;\\n  text-align: center;\\n}\\n\\n.product-card img {\\n  max-width: 100%;\\n  height: auto;\\n  margin-bottom: 10px;\\n}\\n\\n.product-card h3 {\\n  margin-bottom: 5px;\\n}\\n\\n.product-card p {\\n  margin-bottom: 10px;\\n}\\n\\n.product-card button {\\n  background-color: #007bff;\\n  color: white;\\n  padding: 10px 20px;\\n  border: none;\\n  border-radius: 5px;\\n  cursor: pointer;\\n}\\n\\nfooter {\\n  background-color: #663300;\\n  color: white;\\n  padding: 20px;\\n  text-align: center;\\n}", "js": "const productsGrid = document.querySelector(\'.products-grid\');\\n\\n// Sample product data (Replace with actual data from an API or local source)\\nconst products = [\\n  {\\n    name: \\"Smartphone\\",\\n    price: 599,\\n    description: \\"High-performance smartphone with a stunning display and powerful camera.\\",\\n    image: \\"//placeholder.com/250x250\\"\\n  },\\n  {\\n    name: \\"Laptop\\",\\n    price: 1299,\\n    description: \\"Lightweight and portable laptop with a long battery life.\\",\\n    image: \\"//placeholder.com/250x250\\"\\n  },\\n  {\\n    name: \\"Headphones\\",\\n    price: 199,\\n    description: \\"Wireless headphones with excellent sound quality and noise cancellation.\\",\\n    image: \\"//placeholder.com/250x250\\"\\n  }\\n];\\n\\n// Display products\\ndisplayProducts(products);\\n\\nfunction displayProducts(products) {\\n  productsGrid.innerHTML = \'\';\\n  products.forEach(product => {\\n    const productCard = document.createElement(\'div\');\\n    productCard.classList.add(\'product-card\');\\n    productCard.innerHTML = `\\n      <img src="${product.image}" alt="${product.name}">\\n      <h3>${product.name}</h3>\\n      <p>$${product.price}</p>\\n      <p>${product.description}</p>\\n      <button class=\\"add-to-cart\\">Add to Cart</button>\\n    `;\\n    productsGrid.appendChild(productCard);\\n\\n    // Add event listener for add to cart button\\n    const addToCartButton = productCard.querySelector(\'.add-to-cart\');\\n    addToCartButton.addEventListener(\'click\', () => {\\n      // Add product to cart functionality (e.g., using local storage or an API)\\n      // Example: (Assuming local storage is used)\\n      let cart = JSON.parse(localStorage.getItem(\'cart\')) || [];\\n      cart.push(product);\\n      localStorage.setItem(\'cart\', JSON.stringify(cart));\\n      // Display a success message\\n      alert(\'Product added to cart!\');\\n    });\\n  });\\n}"\n}\n```',
//           },
//         ],
//       },
//     ],
//   });

//   const result = await chatSession.sendMessage(prompt);
//   // const files = JSON.parse(result.response.text());
//   // console.log(result.response.text());
//   const res = result.response.text();
//   // console.log(res);
//   return res;
// }

// // const result =
// // res = generateWebsite(
// //   "Mouse Webpage",
// //   "A descriptive portfolio for my profile",
// //   "red blue with green bg",
// //   "4 grid layout",
// //   "include a sidebar as a hamburger"
// // );

// // console.log(result);

// module.exports = { generateWebsite };
