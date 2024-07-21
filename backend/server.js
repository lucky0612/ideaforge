const express = require("express");
const bodyParser = require("body-parser");
const path = require("path");
const { generateWebsite } = require("./generateWebsite");

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

app.get("/", (req, res) => {
  // res.sendFile(path.join(__dirname, "public", "index.html"));
  res.send("Hello World !!!");
});

app.post("/generate", async (req, res) => {
  //   const details = {
  //     title,
  //     description,
  //     colorScheme,
  //     layoutPreferences,
  //     features
  // };
  try {
    const files = await generateWebsite(
      "Mouse Webpage",
      "A descriptive portfolio for my profile",
      "red blue with green bg",
      "4 grid layout",
      "include a sidebar as a hamburger"
    );

    const dir = path.join(__dirname, "generated");
    if (!fs.existsSync(dir)) fs.mkdirSync(dir);

    fs.writeFileSync(path.join(dir, "index.html"), files.html);
    fs.writeFileSync(path.join(dir, "style.css"), files.css);
    fs.writeFileSync(path.join(dir, "script.js"), files.js);

    res.download(path.join(dir, "index.html"));
  } catch (error) {
    console.error(error);
    res.status(500).send("Error generating website");
  }
});

app.get("/view-generated", (req, res) => {
  res.sendFile(path.join(__dirname, "generated", "index.html"));
});

app.listen(3000, () => {
  console.log("Server is running on http://localhost:3000");
});
