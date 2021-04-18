const webpack = require("webpack");
const path = require('path');

module.exports = {
  context: path.resolve(__dirname, '../../app/javascript/packs'),

  resolve: {
    alias: {
      jquery: 'jquery/src/jquery'
    }
  },

  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [{
          loader: 'style-loader', // inject CSS to page
        }, {
          loader: 'css-loader', // translates CSS into CommonJS modules
        }, {
          loader: 'sass-loader' // compiles Sass to CSS
        }]
      },
      {
        test: /\.(jpg|jpeg|png|woff|woff2|eot|ttf|svg)$/,
        use: 'url-loader'
      },
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: 'asset/resource',
      },
    ]
  },

  entry: {
    application: ["./application.js"],
  },

  output: {
    path: path.resolve(__dirname, '../../public/packs'),
  },
};