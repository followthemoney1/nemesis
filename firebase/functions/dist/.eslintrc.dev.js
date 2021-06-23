"use strict";

var _rules;

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

module.exports = {
  root: true,
  env: {
    es6: true,
    node: true
  },
  "extends": ["eslint:recommended", "plugin:import/errors", "plugin:import/warnings", "plugin:import/typescript", "google", "plugin:@typescript-eslint/recommended"],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module"
  },
  ignorePatterns: ["/lib/**/*", // Ignore built files.
  "/src/dist/*"],
  plugins: ["@typescript-eslint", "import"],
  rules: (_rules = {
    '@typescript-eslint/no-var-requires': 0,
    'object-curly-spacing': 0,
    'spaced-comment': 0,
    'indent': 0,
    'require-jsdoc': 0,
    'jsx-quotes': [2, 'prefer-single'],
    "camelcase": "off",
    "@typescript-eslint/camelcase": ["warn"]
  }, _defineProperty(_rules, "indent", "off"), _defineProperty(_rules, "object-curly-spacing", [2, "never"]), _defineProperty(_rules, 'max-len', 'off'), _rules)
};