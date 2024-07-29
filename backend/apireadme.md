## API Endpoints

Base URL: https://product-vision-api.onrender.com

1. Submit User Idea
   Endpoint: POST /api/user-input
   Body: { "idea": "User's product idea" }
   Response: { "message": "User input saved", "id": "user_input_id" }

2. Generate Requirements Document
   Endpoint: GET /api/generate-requirements/:id
   Parameters: id - The user input ID received from the submit endpoint
   Response: { "document": "Generated requirements document content" }

3. Generate Technical Aspects Document
   Endpoint: GET /api/generate-technical/:id
   Parameters: id - The user input ID received from the submit endpoint
   Response: { "document": "Generated technical aspects document content" }

4. Generate Product Lifecycle Document
   Endpoint: GET /api/generate-lifecycle/:id
   Parameters: id - The user input ID received from the submit endpoint
   Response: { "document": "Generated product lifecycle document content" }
