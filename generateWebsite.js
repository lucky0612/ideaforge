// ----->>>>    NOTE    <<<<-----

// This follows a different approach for Web Generation i.e UI + Structured Prompt -> Web Files

const { GoogleAIFileManager } = require("@google/generative-ai/server");
const { GoogleGenerativeAI } = require("@google/generative-ai");
const path = require("path");
require("dotenv").config();

async function generateWebsite(description) {
  try {
    const fileManager = new GoogleAIFileManager(process.env.API_KEY);
    console.log(fileManager);
    const prompt =
      `Based on the given image, Generate the HTML, CSS and JS content of the file using the description given below\n\n` +
      `Description : ${description}\n\n` +
      `The design should include immersive 3D elements and visually stunning animations powered by CSS and JavaScript\n\n` +
      `Incorporate advanced scrolling animations, interactive hover effects, and dynamic transitions between sections. \n\n` +
      `The layout must be responsive, with smooth scaling and fluid transitions across devices using media queries\n\n` +
      `Bring up your best skill as a web dev and generate the most serene pieces of HTML, CSS and JS known to mankind. Make them as futuristic as possible. Avoid using general color schemes and make it more realistic. Try to use colors gradient colors.\n\n` +
      `You can also refer the image for color schemes`;

    console.log(path.join(__dirname));
    const uploadResult = await fileManager.uploadFile(
      path.join(__dirname, "genImage.jpg"),
      {
        mimeType: "image/jpeg",
        displayName: "Figma UI",
      }
    );

    const genAI = new GoogleGenerativeAI(process.env.API_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    const result = await model.generateContent([
      `${prompt}`,
      {
        fileData: {
          fileUri: uploadResult.file.uri,
          mimeType: uploadResult.file.mimeType,
        },
      },
    ]);
    const genRes = result.response.text();
    console.log(genRes);
    return genRes;
  } catch (error) {
    console.error("Error:", error);
  }
}

module.exports = { generateWebsite };
