# 🌟 Image to Webpage Generation 🌟

🚀 **Transform images into fully functional web pages** using the power of the Geminni API and modern backend tools, with added geospatial collaboration features.

## ✨ Features
- 🎨 **Image Generation**: Generate beautiful images via an API.
- 🛠️ **Geminni API Integration**: Convert generated images into web files (HTML, CSS, JS).
- 💾 **File Download**: Option to download the generated web files.
- 🌐 **Live Deployment**: Instantly deploy the generated web page for user access.
- 📍 **Geospatial Collaboration**: Find and collaborate on web pages generated nearby based on your location.

---

## ⚙️ How It Works

1. 🖼️ **Step 1**: Call the API to generate images.
2. 🔁 **Step 2**: Pass the generated images to the Geminni API for web file generation.
3. 🌍 **Step 3**: Include geographic location data for web pages.
4. 📂 **Step 4**: Download the generated HTML, CSS, and JS files.
5. 🗺️ **Step 5**: Access nearby web pages based on your current location.
6. 🌐 **Step 6**: Access the deployed webpage through the provided URL.

---

## 📦 Installation

1. Clone this repository:
    ```bash
    git clone <repo-url>
    ```
2. Navigate to the project directory:
    ```bash
    cd <project-directory>
    ```
3. Install dependencies:
    ```bash
    npm install
    ```

---

## 🛠️ Usage

1. Start the backend server:
    ```bash
    npm start
    ```
2. Send a request to generate images and convert them to a webpage, including your location:
    ```bash
    # Example using curl
    curl -X POST http://localhost:3000/generate -d '{"title": "My Webpage", "image": "<image-url>", "files": ["<file1>", "<file2>"], "latitude": <lat>, "longitude": <long>}'
    ```

3. **Access the Download**: Receive your generated web files (HTML, CSS, JS).
4. **View the Webpage**: Check out the live-deployed version of your generated webpage.
5. **Find Nearby Web Pages**: 
    ```bash
    curl -X GET "http://localhost:3000/find-nearby?latitude=<lat>&longitude=<long>"
    ```

---

## 🚧 API Endpoints

- `POST /generate`: Generate images and convert them to HTML, CSS, JS, including location data.
- `GET /find-nearby`: Retrieve web pages generated within a specified radius based on your location.
- `GET /view-generated`: View your deployed web page.
- `GET /download-zip`: Download the source code.

---

## 💡 Technologies Used

- **Backend**: Node.js, Express
- **Database**: MongoDB (for storing generated web pages and location data)
- **API**: Image Generation API, Geminni API
