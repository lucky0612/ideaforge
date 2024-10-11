const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const dotenv = require("dotenv");

dotenv.config();

const app = express();
const port = 3000;

app.use(bodyParser.json());

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    console.log("Database connected successfully!");
  })
  .catch((error) => {
    console.error("Database connection error:", error);
  });

const ideaSchema = new mongoose.Schema({
  title: String,
  description: String,
  requirements: String,
  duration: String,
  domain: String,
  location: {
    type: { type: String, default: "Point" },
    coordinates: [Number],
  },
});

ideaSchema.index({ location: "2dsphere" });

const Idea = mongoose.model("Idea", ideaSchema);

app.get("/", (req, res) => {
  res.send("hello");
});

app.post("/ideas", async (req, res) => {
  const {
    title,
    description,
    requirements,
    duration,
    latitude,
    longitude,
    domain,
  } = req.body;

  const newIdea = new Idea({
    title,
    description,
    requirements,
    duration,
    domain,
    location: {
      type: "Point",
      coordinates: [longitude, latitude],
    },
  });

  try {
    await newIdea.save();
    res.status(201).json({ message: "Idea posted successfully!" });
  } catch (error) {
    res.status(500).json({ error: "Failed to post idea" });
  }
});

app.get("/ideas-nearby", async (req, res) => {
  const { latitude, longitude, domain } = req.query;
  console.log("Received query parameters:");
  console.log("Latitude:", latitude);
  console.log("Longitude:", longitude);
  try {
    const nearbyIdeas = await Idea.find({
      location: {
        $geoWithin: {
          $centerSphere: [[longitude, latitude], 100 / 6371],
        },
      },
      domain: domain,
    });

    res.status(200).json(nearbyIdeas);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch ideas" });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
