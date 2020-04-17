const redirectTo = require("../../controllers/redirectTo.controller");
const express = require("express");
const router = express.Router();

// middleware that is specific to this router
router.use(function timeLog(req, res, next) {
  console.log("Time: ", Date.now());
  next();
});

router.get("/:shortUrl", redirectTo.redirectToOriginalUrl);

module.exports = router;
