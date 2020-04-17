const ShortUrl = require("../models/shortUrl.model");

exports.redirectToOriginalUrl = async (req, res) => {
  console.log(req.params.shortUrl);
  const shortUrl = await ShortUrl.findOne({ shortUrl: req.params.shortUrl });
  if (shortUrl == null) return res.sendStatus(404);

  shortUrl.clicksNumber++;
  shortUrl.save();

  res.redirect(shortUrl.originalUrl);
};
