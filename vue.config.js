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
    module: {
      rules: [
        {
          test: /worker\.js$/,
          use: {
            loader: 'worker-loader',
            options: {
              inline: true,
              fallback: false
              // inline: process.env.NODE_ENV !== 'production',
              // name: '[name].[hash].js',
              // publicPath: '/workers/'
            }
          }
        }
      ]
    },
    optimization: {
      splitChunks: {
        minSize: 10000,
        maxSize: 250000
      }
    },
    // chainWebpack: (config) => {
    //   config.plugins.delete('preload')
    //   config.plugins.delete('prefetch')
    // },
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
