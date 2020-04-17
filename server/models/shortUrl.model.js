const mongoose = require("mongoose");
const shortId = require("shortid");

const short = shortId.generate;

const ShortUrlSchema = new mongoose.Schema(
  {
    originalUrl: {
      type: String,
      required: true,
    },
    shortUrl: {
      type: String,
      required: true,
      default: short,
      unique: true,
      dropDups: true,
    },
    clicksNumber: {
      type: Number,
      default: 0,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("ShortUrl", ShortUrlSchema);
