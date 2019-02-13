const MonacoWebpackPlugin = require("monaco-editor-webpack-plugin");

process.env.VUE_APP_VERSION = require("./package.json").version;

module.exports = {
  css: {
    loaderOptions: {
      sass: {
        data: `
          @import "@/styles/_variables.scss";
          @import "@/styles/_mixins.scss";
        `
      }
    }
  },
  configureWebpack: {
    optimization: {
      splitChunks: {
        minSize: 10000,
        maxSize: 250000
      }
    },
    plugins: [new MonacoWebpackPlugin({ languages: [] })]
  }
};
