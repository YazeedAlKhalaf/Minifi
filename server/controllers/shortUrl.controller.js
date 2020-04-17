const ShortUrl = require("../models/shortUrl.model");
const shortId = require("shortid");

/**
 * Create and Save a new shortUrl
 */
exports.create = (req, res) => {
  // Validate request
  if (!req.body.originalUrl) {
    return res.status(400).send({
      message: "shortUrl originalUrl can not be empty!",
    });
  }

  // Create a shortUrl
  const shortUrl = new ShortUrl({
    originalUrl: req.body.originalUrl,
  });

  // Save shortUrl in the Database
  shortUrl
    .save()
    .then((data) => {
      res.status(201).send(data);
    })
    .catch((err) => {
      res.status(500).send({
        message:
          err.message || "Some error occured while creationg the shortUrl!",
        errorCode: res.status,
      });
    });
};

/**
 * Retreive and return all shortUrls from the database
 */
exports.findAll = (req, res) => {
  ShortUrl.find()
    .then((shortUrls) => {
      console.log(shortUrls.data);
      if (shortUrls != null) {
        res.json(shortUrls);
      } else {
        res.status(404).json({
          message: "No Short URLs found!",
          statusCode: res.statusCode,
        });
      }
    })
    .catch((err) => {
      res.status(500).send({
        message:
          err.message || "Some error occured while retreiving the shortUrl!",
        statusCode: res.statusCode,
      });
    });
};

/**
 * Find a single shortUrl
 */
exports.findOne = (req, res) => {
  ShortUrl.findOne({ shortUrl: req.params.shortUrl }, (err, doc) => {
    if (doc == null) {
      console.log("doc is null");
      res.status(404).json({
        message: `No url was found with this id: ${req.params.shortUrl}`,
        statusCode: res.statusCode,
      });
    } else {
      console.log(doc.originalUrl);
      const shortUrl = new shortUrl({
        originalUrl: doc.originalUrl,
        shortUrl: doc.shortUrl,
        clicksNumber: doc.clicksNumber,
      });

      res.status(200).json(shortUrl);
    }
  });
};

/**
 * Update a shortUrl
 */
exports.update = (req, res, next) => {
  // Validate Request
  console.log(req.body.originalUrl);
  if (req.body.originalUrl == null) {
    res.status(400).send({
      message: "Original url can not be empty",
      statusCode: res.statusCode,
    });
  }
  ShortUrl.findOne({ shortUrl: req.params.shortUrl }, (err, doc) => {
    if (doc == null) {
      console.log(err);
      res.status(404).send({
        message: `The short url ${req.params.shortUrl} you enetred is not found so it can't be updated!`,
        statusCode: res.statusCode,
      });
      res.redirect("/");
    } else {
      doc.originalUrl = req.body.originalUrl;
      doc.save();

      res.status(200).json({
        message: `Updated orginial url of ${req.params.shortUrl} successfully!`,
        statusCode: res.statusCode,
      });
    }
  });
};

/**
 * Delete a shortUrl
 */
exports.delete = (req, res) => {
  ShortUrl.deleteOne({ shortUrl: req.params.shortUrl }, (err) => {
    if (err == null) {
      console.log("Already deleted or not found");
      res.status(404).send({
        message: `The short url ${req.params.shortUrl} you entered is not found so it can't be deleted!`,
        statusCode: res.statusCode,
      });
    } else {
      res.status(200).json({
        message: `The short url ${req.params.shortUrl} has been deleted successfully!`,
        statusCode: res.statusCode,
      });
    }
  });
};
