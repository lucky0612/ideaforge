const express = require("express");
const bodyParser = require("body-parser");
const path = require("path");
const { generateWebsite } = require("./generateWebsite");
const { generateImages } = require("./generateUI");
const app = express();
const fs = require("fs");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static("public"));
const AdmZip = require("adm-zip");
const port = process.env.PORT || 3000;
app.use("/", express.static(path.join(__dirname, "generated")));

app.get("/", (req, res) => {
  res.send("Hello there welcome to WEB GEN :-)");
});

app.post("/generate", async (req, res) => {
  const { description } = req.body;
  try {
    const result = await generateWebsite(description);

    const regexHTML = /(?<=```html)[\s\S]*?(?=```)/g;
    const regexJS = /(?<=```javascript)[\s\S]*?(?=```)/g;
    const regexJS1 = /(?<=```js)[\s\S]*?(?=```)/g;
    const regexCSS = /(?<=```css)[\s\S]*?(?=```)/g;
    const matchHTML = result.match(regexHTML);
    const matchCSS = result.match(regexCSS);
    let matchJS;
    if (result.match(regexJS)) {
      matchJS = result.match(regexJS);
    } else if (result.match(regexJS1)) {
      matchJS = result.match(regexJS1);
    } else {
      matchJS = [
        "Js cannot be extracted at the moment. Please try again later",
      ];
    }
    console.log(matchHTML);

    //page view
    const dir = path.join(__dirname, "generated");
    if (!fs.existsSync(dir)) fs.mkdirSync(dir);

    if (matchHTML && matchHTML[0].trim) {
      fs.writeFileSync(path.join(dir, "index.html"), matchHTML[0]);
    }

    if (matchCSS && matchCSS[0].trim) {
      fs.writeFileSync(path.join(dir, "style.css"), matchCSS[0]);
    }

    if (matchJS && matchJS[0].trim) {
      fs.writeFileSync(path.join(dir, "script.js"), matchJS[0]);
    }
    res.download(path.join(dir, "index.html"));

    // file download
    const zip = new AdmZip();
    const htmlPath = path.join(dir, "index.html");
    const cssPath = path.join(dir, "style.css");
    const jsPath = path.join(dir, "script.js");

    if (fs.existsSync(htmlPath)) {
      zip.addLocalFile(htmlPath);
    }
    if (fs.existsSync(cssPath)) {
      zip.addLocalFile(cssPath);
    }
    if (fs.existsSync(jsPath)) {
      zip.addLocalFile(jsPath);
    }

    const zipPath = path.join(dir, "website.zip");
    zip.writeZip(zipPath);

    res.json({
      message: "Website generated successfully",
      viewUrl: "/view-generated",
      downloadUrl: "/download-zip",
    });
  } catch (error) {
    console.error(error);
    res.status(500).send("Error generating website");
  }
});

// downloading the zip
app.get("/download-zip", (req, res) => {
  const zipPath = path.join(__dirname, "generated", "website.zip");
  res.download(zipPath, "website.zip", (err) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error downloading the zip file");
    }
  });
});

// view the generation
app.get("/view-generated", (req, res) => {
  res.sendFile(path.join(__dirname, "generated", "index.html"));
});

// image gen
app.post("/imagen", generateImages);

app.listen(port, () => {
  console.log("Server is running on http://localhost:3000");
});
