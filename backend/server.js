const express = require("express");
const bodyParser = require("body-parser");
const path = require("path");
const { generateWebsite } = require("./generateWebsite");

const app = express();
const fs = require("fs");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static("public"));
app.use("/", express.static(path.join(__dirname, "generated")));
app.get("/", (req, res) => {
  // res.sendFile(path.join(__dirname, "public", "index.html"));
  res.send("Hello World ...");
});

app.post("/generate", async (req, res) => {
  //   const details = {
  //     title,
  //     description,
  //     colorScheme,
  //     layoutPreferences,
  //     features
  // };
  const { title, description, colorScheme, layoutPreferences, features } =
    req.body;
  try {
    const files = await generateWebsite(
      title,
      description,
      colorScheme,
      layoutPreferences,
      features
    );

    jsonResponseString = files.replace(/^```json\n/, "").replace(/\n```$/, "");
    const result = JSON.parse(jsonResponseString);
    console.log(result);
    // console.log(result.html);
    // console.log(result.css);
    // console.log(result.js);
    // console.log(files["index.html"]);

    const dir = path.join(__dirname, "generated");
    if (!fs.existsSync(dir)) fs.mkdirSync(dir);

    if (result.html && result.html.trim()) {
      fs.writeFileSync(path.join(dir, "index.html"), result.html);
    }

    if (result.css && result.css.trim()) {
      fs.writeFileSync(path.join(dir, "styles.css"), result.css);
    }

    if (result.js && result.js.trim()) {
      fs.writeFileSync(path.join(dir, "scripts.js"), result.js);
    }

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
