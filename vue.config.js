const path = require("path")

const { defineConfig } = require("@vue/cli-service")
const PreloadWebpackPlugin = require("@vue/preload-webpack-plugin")
const MonacoWebpackPlugin = require("monaco-editor-webpack-plugin")
const TsconfigPathsPlugin = require("tsconfig-paths-webpack-plugin")

process.env.VUE_APP_VERSION = require("./package.json").version

module.exports = defineConfig({
  parallel: false,
  transpileDependencies: true,
  css: {
    loaderOptions: {
      sass: {
        additionalData: `
          @import "@/styles/_variables.scss";
          @import "@/styles/_mixins.scss";
        `,
      },
    },
  },
  configureWebpack: {
    resolve: {
      fallback: { path: false },
      plugins: [new TsconfigPathsPlugin()],
      alias: {
        "@": path.resolve(__dirname, "src/"),
        "@/pages": path.resolve(__dirname, "src/components/pages/"),
        "@/commons": path.resolve(__dirname, "src/components/commons/"),
      },
    },
    optimization: {
      splitChunks: {
        minSize: 10000,
        maxSize: 250000,
      },
    },
    // chainWebpack: (config) => {
    //   config.plugins.delete('preload')
    //   config.plugins.delete('prefetch')
    // },
    plugins: [
      new PreloadWebpackPlugin({
        rel: "preload",
        include: {
          type: "asyncChunks",
          entries: ["monaco"],
        },
      }),
      new MonacoWebpackPlugin({ languages: [] }),
    ],
  },
})
