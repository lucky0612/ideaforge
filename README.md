# 🌟 Image to Webpage Generation 🌟

🚀 **Transform images into fully functional web pages** using the power of the Geminni API and modern backend tools.

## ✨ Features
- 🎨 **Image Generation**: Generate beautiful images via an API.
- 🛠️ **Geminni API Integration**: Convert generated images into web files (HTML, CSS, JS).
- 💾 **File Download**: Option to download the generated web files.
- 🌐 **Live Deployment**: Instantly deploy the generated web page for user access.

---

## ⚙️ How It Works

1. 🖼️ **Step 1**: Call the API to generate images.
2. 🔁 **Step 2**: Pass the generated images to the Geminni API for web file generation.
3. 📂 **Step 3**: Download the generated HTML, CSS, and JS files.
4. 🌍 **Step 4**: Access the deployed webpage through the provided URL.

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
2. Send a request to generate images and convert them to a webpage:
    ```bash
    # Example using curl
    curl -X POST http://localhost:3000/generate -d "<your-payload-here>"
    ```

3. **Access the Download**: Receive your generated web files (HTML, CSS, JS).
4. **View the Webpage**: Check out the live-deployed version of your generated webpage.

---

## 🚧 API Endpoints

- `POST /imagen`: Generate images and pass it to the Web Gen API.
- `POST /generate`: Generate images and convert to HTML, CSS, JS.
- `GET /view-generated`: View your deployed Web Page.
- `GET /download-zip`: Download the Source Code.

---

## 💡 Technologies Used

- **Backend**: Node.js, Express
- **API**: Image Generation API, Geminni API
