import axios from "axios";

const url = "api/v1/shortUrl/";

class ShortUrlService {
  // Create ShortUrl
  static createShortUrl(originalUrl) {
    return axios.post(url, {
      originalUrl: originalUrl,
    });
  }
  // Get ShortUrls
  static getShortUrls() {
    return new Promise((resolve, reject) => {
      axios
        .get(url)
        .then((res) => {
          const data = res.data;
          resolve(
            data.map((shortUrl) => ({
              ...shortUrl,
            }))
          );
        })
        .catch((err) => {
          reject(err);
        });
    });
  }

  // Update ShortUrl
  static updateShortUrl(shortUrl, originalUrl) {
    return axios.put(`${url}${shortUrl.shortUrl}`, {
      originalUrl: originalUrl,
    });
  }

  // Delete ShortUrl
  static deleteShortUrl(shortUrl) {
    return axios.delete(`${url}${shortUrl.shortUrl}`);
  }
}

export default ShortUrlService;
