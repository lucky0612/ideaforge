const MonsterApiClient = require("monsterapi").default;
// const imageStore = require("./imageStore");
require("dotenv").config();
const imageDownloader = require("image-downloader");
const path = require("path");
const fs = require("fs");
const apiKey = process.env.monster_ai_key;
const client = new MonsterApiClient(apiKey);

const generateImages = async (req, res) => {
  const { description, domain } = req.body;

  let prompt = ``;

  if (domain === "Software Technology") {
    prompt = `Create a Figma Web Design for a modern, futuristic, minimalist tech homepage with a navigation bar, hero section with a background image, and three feature sections for ${description}.`;
  } else if (domain === "Healthcare and Biotech") {
    prompt = `Create a unique image that visually represents ${description}`;
  } else if (domain === "Renewable Energy") {
    prompt = `Create a visually striking image illustrating clean energy solutions, like solar panels, wind turbines, or hydroelectric plants, highlighting sustainable technologies inspired by ${description}.`;
  } else if (domain === "Financial Services") {
    prompt = `Generate a sophisticated, modern image that captures the essence of financial instruments, data visualization, stock market trends, or investment strategies tied to ${description}.`;
  } else if (domain === "Advanced Manufacturing") {
    prompt = `Create a high-tech image showing cutting-edge manufacturing hardware, including robotics, automated assembly lines, or 3D printing, based on ${description}.`;
  } else if (domain === "Artificial Intelligence and Robotics") {
    prompt = `Generate a futuristic image of AI systems, robots, or autonomous machines performing complex tasks, with a focus on innovation and technology related to ${description}.`;
  } else {
    prompt = `Create a unique image that visually represents ${description} in a futuristic and innovative style.`;
  }

  if (!description || !domain) {
    return res
      .status(400)
      .send("Kindly provide both the description and domain");
  }

  const input = {
    prompt: prompt,
    negprompt: "unreal, fake, meme, joke, disfigured, poor quality, bad, ugly",
    samples: 2,
    steps: 50,
    aspect_ratio: "square",
    guidance_scale: 7.5,
    seed: 2414,
    enhance: true,
    optimize: true,
    safe_filter: true,
    style: "photographic",
  };

  try {
    const response = await client.generate("sdxl-base", input);
    const generatedImages = response.output;
    // imageStore.setImages(generateImages);
    console.log(generatedImages[0]);
    const filename = "genImage";
    const options = {
      url: `${generatedImages[0]}`,
      dest: path.join(__dirname, `./${filename}.jpg`),
    };
    imageDownloader
      .image(options)
      .then(({ filename }) => {
        console.log("saved to ", filename);
      })
      .catch((error) => {
        {
          console.log(error);
        }
      });
    res.json({ images: generatedImages });
  } catch (error) {
    console.error("Error generating images:", error);
    res.status(500).send("Error generating images");
  }
};

module.exports = { generateImages };
