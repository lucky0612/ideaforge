# IdeaForge UI and Prototype Generator

This repository contains the code for the UI generation and website prototype features of IdeaForge, an AI-powered product development platform.

## Features

### UI Generation
- Utilizes MonsterAPI for image generation
- Hosted on Render for scalable performance

### Website Prototype
- Generates HTML, CSS, and JavaScript code using Gemini AI
- Combines generated code using middlewares
- Hosts static websites on a base URL

## Usage

1. UI Generation
- Send a POST request to `/generate-ui` with the product description
- Receive a JSON response with the URL of the generated UI image

2. Website Prototype
- Send a POST request to `/generate-prototype` with the product details
- Receive a JSON response with the URL of the hosted prototype website

## API Endpoints

- `POST /generate-ui`: Generate UI based on product description
- `POST /generate-prototype`: Generate and host website prototype

## Technologies Used

- Node.js
- Express.js
- MonsterAPI
- Gemini AI
- Render

