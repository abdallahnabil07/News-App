const axios = require("axios");
const cron = require("node-cron");
const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccount.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const NEWS_API_KEY = "7c3f011ba6bc4b39b472d4e7f60344df";
const NEWS_API_URL = `https://newsapi.org/v2/top-headlines?country=eg&apiKey=${NEWS_API_KEY}`;

let lastArticleTitle = null;

async function checkAndNotify() {
  try {
    console.log("Checking for new news...");
    const response = await axios.get(NEWS_API_URL);
    const articles = response.data.articles;

    if (!articles || articles.length === 0) {
      console.log("No articles found.");
      return;
    }

    const latest = articles[0];

    if (latest.title === lastArticleTitle) {
      console.log("No new news.");
      return;
    }

    lastArticleTitle = latest.title;

    await admin.messaging().send({
      topic: "news",
      notification: {
        title: latest.title,
        body: latest.description ?? "Check out the latest news!",
      },
    });

    console.log("✅ Notification sent:", latest.title);
  } catch (error) {
    console.error("❌ Error:", error.message);
  }
}

cron.schedule("*/30 * * * *", checkAndNotify);

checkAndNotify();

console.log("🚀 Server is running...");