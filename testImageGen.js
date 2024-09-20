// ----->>>>    NOTE    <<<<-----

// This file was created for testing purposes. This follows a different approach for Web Generation i.e Image -> Prompt -> Web Files
// Feel free to use this as per your convenience :-)

// const {GoogleGenerativeAI, HarmCategory, HarmBlockThreshold} = require("@google/generative-ai");
// require("dotenv").config();
// // const { GoogleAIFileManager } = require("@google/generative-ai/server");
// const path = require("path");
// const { GoogleAIFileManager } = require("@google/generative-ai/server");
// // const { generateWebsite } = require("./testGeminiImageWebGeneration");
// // const { Console } = require("console");
// // const { Module } = require("module");

// // async function getinfo() {
// //   const description = await generateWebsite();
// //   return description;
// // }

// const apiKey = process.env.api_key;
// const genAI = new GoogleGenerativeAI(apiKey);
// const fileManager = new GoogleAIFileManager(apiKey);

// const model = genAI.getGenerativeModel({
//   model: "gemini-1.5-flash",
// });

// const generationConfig = {
//   temperature: 1,
//   topP: 0.95,
//   topK: 64,
//   maxOutputTokens: 8192,
//   responseMimeType: "application/json",
// };

// // const description = `
// // Generate a complete HTML and CSS code for a futuristic and flashy website design that has a traditional layout.
// // The website should:
// // - Use vibrant yellow, blue, and red color schemes.
// // - Feature bold typography that stands out.
// // - Incorporate playful shapes and textures in the design.
// // - Include an animated background with subtle particle effects.
// // - Be visually appealing and engaging for a young audience interested in technology, health, and fitness.
// // - Provide detailed HTML structure and CSS styles to achieve this look.
// // - Focus on modern web design principles and interactivity.
// // Output only the HTML and CSS code.
// // `;

// async function generateImageWebsite(description) {
//   const prompt =
//     description +
//     `Make it completely and dynamic. Generate only the html and css files Kindly. Try to write less lines of css code but with beautiful and futuristic styling. Follow the naming convention as index.html and styles.css`;

//   const chatSession = model.startChat({
//     generationConfig,
//   });

//   const result = await chatSession.sendMessage(prompt);
//   genRes = result.response.text();
//   //   chatSession.console.log(result.response.text());
//   jsonResponseString = genRes
//     .replace(/^```json\n/, "")
//     .replace(/\n```$/, "")
//     .replace(/\n/g, " ") // Replace newlines with space
//     .replace(/\t/g, " ") // Replace tabs with space
//     .replace(/[\x00-\x1F\x7F-\x9F]/g, "");
//   const result1 = JSON.parse(jsonResponseString);
//   return result1;
//   //   console.log(result1);
//   //   //   console.log(result1.html);
//   //   //   console.log(result1.css);
//   //   console.log(result1.html);
//   //   console.log(result1.css);
// }

// // generateWebsite()
// //   .then((description) => generateImageWebsite(description))
// //   .catch((error) => console.log(error));

// // run(getinfo());

// module.exports = { generateImageWebsite };
