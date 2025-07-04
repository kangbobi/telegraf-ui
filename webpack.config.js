const path = require('path');

module.exports = {
  entry: {
    'telegraf_ui': './telegraf_ui/public/js/telegraf_editor.js'
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'telegraf_ui/public/dist')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      }
    ]
  },
  resolve: {
    modules: ['node_modules']
  }
};
