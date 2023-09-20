module.exports = {
  env: {
    node: true,
  },
  extends: [
    "@vue/typescript/recommended",
    "eslint:recommended",
    "plugin:vue/vue3-essential",
    "plugin:import/recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
  ],
  parser: "vue-eslint-parser",
  parserOptions: {
    ecmaVersion: "latest",
    tsconfigRootDir: ".",
    project: ["./tsconfig.json"],
    sourceType: "module",
  },
  plugins: ["@typescript-eslint", "import"],
  settings: {
    "import/resolver": {
      typescript: {},
    },
    "import/extensions": [".ts"],
  },
  rules: {
    "no-console": [process.env.NODE_ENV === "production" ? "error" : "warn", { allow: ["info", "warn", "error"] }],
    "no-debugger": process.env.NODE_ENV === "production" ? "error" : "warn",
    "no-unused-vars": [
      process.env.NODE_ENV === "production" ? "error" : "warn",
      {
        argsIgnorePattern: "^_",
        varsIgnorePattern: "^_",
        caughtErrorsIgnorePattern: "^_",
        destructuredArrayIgnorePattern: "^_",
      },
    ],
    "@typescript-eslint/no-unused-vars": [
      process.env.NODE_ENV === "production" ? "error" : "warn",
      {
        argsIgnorePattern: "^_",
        varsIgnorePattern: "^_",
        caughtErrorsIgnorePattern: "^_",
        destructuredArrayIgnorePattern: "^_",
      },
    ],
    "import/no-unresolved": "error",
    "import/extensions": [
      "error",
      {
        ignorePackages: true,
        pattern: {
          js: "never",
          ts: "never",
          json: "always",
        },
      },
    ],
    "import/order": [
      "error",
      {
        "groups": ["builtin", "external", "internal", "parent", "sibling", "index", "object", "type"],
        "pathGroupsExcludedImportTypes": ["builtin"],
        "alphabetize": { order: "asc" },
        "newlines-between": "always",
      },
    ],
    "vue/multi-word-component-names": "off",
  },
}
