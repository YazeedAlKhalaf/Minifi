<template>
  <b-overlay :show="showEdit" rounded="sm" class="editOverlay">
    <div class="container">
      <h1>
        <strong>MINIFI</strong>
      </h1>
      <label for="originalUrl" class="sr-only">Url</label>
      <input
        required
        placeholder="Url"
        type="url"
        name="originalUrl"
        id="originalUrl"
        v-model="originalUrl"
        class="form-control col mr-2"
      />
      <br />
      <b-button pill variant="outline-success" @click="createShortUrl()">Shrink</b-button>
      <br />

      <hr />

      <br />
      <br />

      <table class="table table-striped table-fluid">
        <thead>
          <th>Original Url</th>
          <th>Short Url</th>
          <th>Clicks Number</th>
          <th>Edit</th>
          <th>Delete</th>
        </thead>
        <tbody>
          <template v-for="shortUrl in shortUrls">
            <tr v-bind:key="shortUrl.shortUrl">
              <td>
                <b-link :href="shortUrl.originalUrl" target="_blank">{{ shortUrl.originalUrl }}</b-link>
              </td>
              <td>
                <b-link :href="shortUrl.shortUrl" target="_blank">{{ shortUrl.shortUrl }}</b-link>
              </td>
              <td>{{ shortUrl.clicksNumber }}</td>
              <td>
                <b-button
                  pill
                  size="sm"
                  class="mr-2"
                  variant="outline-primary"
                  @click="showEdit = true"
                >Edit</b-button>
              </td>
              <td>
                <b-button
                  pill
                  size="sm"
                  class="mr-2"
                  variant="outline-danger"
                  @click="deleteShortUrl(shortUrl)"
                >Delete</b-button>
              </td>
            </tr>
          </template>
        </tbody>
      </table>
    </div>
    <template v-slot:overlay>
      <div class="text-center">
        <h1>
          <strong>Update Original URL</strong>
        </h1>
        <label for="originalUrl" class="sr-only">Url</label>
        <input
          required
          placeholder="URL"
          type="url"
          name="originalUrl"
          id="originalUrl"
          v-model="originalUrl"
          class="form-control col mr-2"
        />
        <br />

        <hr />

        <br />
        <br />

        <div class="row">
          <b-button
            pill
            ref="cancel"
            variant="outline-danger"
            size="sm"
            aria-describedby="cancel-label"
            @click="showEdit = false"
          >Cancel</b-button>
          <b-button
            pill
            ref="update"
            variant="outline-success"
            size="sm"
            aria-describedby="update-label"
            @click="updateShortUrl(shorturl, false)"
          >Update</b-button>
        </div>
      </div>
    </template>
  </b-overlay>
</template>

<script>
import ShortUrlService from "../services/ShortUrlService";

export default {
  name: "ShortUrlComponent",
  data() {
    return {
      shortUrls: [],
      error: "",
      originalUrl: "",
      showEdit: false
    };
  },
  async created() {
    try {
      this.shortUrls = await ShortUrlService.getShortUrls();
      this.items = [
        ...this.shortUrls.map(shortUrl => {
          return {
            originalUrl: shortUrl.originalUrl,
            shortUrl: shortUrl.shortUrl,
            clicksNumber: shortUrl.clicksNumber
          };
        })
      ];
    } catch (error) {
      this.error = error.message;
    }
  },
  methods: {
    async createShortUrl() {
      try {
        await ShortUrlService.createShortUrl(this.originalUrl);
        this.originalUrl = "";
        this.shortUrls = await ShortUrlService.getShortUrls();

        this.items = [
          ...this.shortUrls.map(shortUrl => {
            return {
              originalUrl: shortUrl.originalUrl,
              shortUrl: shortUrl.shortUrl,
              clicksNumber: shortUrl.clicksNumber
            };
          })
        ];
      } catch (error) {
        this.error = error.message;
      }
    },
    async updateShortUrl(shortUrl, showEdit) {
      try {
        await ShortUrlService.updateShortUrl(shortUrl, this.originalUrl);

        this.originalUrl = "";

        this.showEdit = showEdit;
      } catch (error) {
        this.error = error.message;
      }
    },
    async deleteShortUrl(shortUrl) {
      try {
        await ShortUrlService.deleteShortUrl(shortUrl);
        this.shortUrls = await ShortUrlService.getShortUrls();

        this.items = [
          ...this.shortUrls.map(shortUrl => {
            return {
              originalUrl: shortUrl.originalUrl,
              shortUrl: shortUrl.shortUrl,
              clicksNumber: shortUrl.clicksNumber
            };
          })
        ];
      } catch (error) {
        this.error = error.message;
      }
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
