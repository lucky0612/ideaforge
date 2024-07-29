const MonsterApiClient = require("monsterapi").default;
require("dotenv").config();

const apiKey = process.env.monster_ai_key;
const client = new MonsterApiClient(apiKey);

const generateImages = async (req, res) => {
  const { description } = req.body;

  if (!description) {
    return res.status(400).send("Description is required");
  }

  const prompt = `create a figma file for ${description}`;
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

    res.json({ images: generatedImages });
  } catch (error) {
    console.error("Error generating images:", error);
    res.status(500).send("Error generating images");
  }
};

module.exports = generateImages;
