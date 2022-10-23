module.exports = {
  plugins: [
    require("postcss-import"), // @importのサポート
    // require('postcss-nesting'), // CSSセレクタのネスト記法サポート
    require("postcss-nested"), // CSSセレクタのネスト記法サポート ※Saasに近い形
    require("autoprefixer"), // ベンダープレフィックスの自動補完
    require("cssnano"), // CSSのminify処理
  ],
};
