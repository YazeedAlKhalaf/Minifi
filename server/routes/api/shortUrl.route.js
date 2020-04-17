const shortUrl = require("../../controllers/shortUrl.controller");
const express = require("express");
const router = express.Router();

// middleware that is specific to this router
router.use(function timeLog(req, res, next) {
  console.log("Time: ", Date.now());
  next();
});

/**
 * Create a new ShortUrl
 */
router.post("/shortUrl", shortUrl.create);

/**
 * Retreive all shortUrl
 */
router.get("/shortUrl", shortUrl.findAll);

/**
 * Retreive a single ShortUrl
 */
router.get("/shortUrl/:shortUrl", shortUrl.findOne);

/**
 * Update a ShortUrl
 */
router.put("/shortUrl/:shortUrl", shortUrl.update);

/**
 * Delete a ShortUrl
 */
router.delete("/shortUrl/:shortUrl", shortUrl.delete);

module.exports = router;
