const PreloadWebpackPlugin = require('@vue/preload-webpack-plugin')
const MonacoWebpackPlugin = require('monaco-editor-webpack-plugin')

process.env.VUE_APP_VERSION = require('./package.json').version

module.exports = {
  productionSourceMap: false,
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
    plugins: [
      new PreloadWebpackPlugin({
        rel: 'preload',
        include: {
          type: 'asyncChunks',
          entries: ['monaco']
        }
      }),
      new MonacoWebpackPlugin({ languages: [] })
    ]
  }
}
