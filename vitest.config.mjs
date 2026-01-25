import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    include: ["__tests__/**/*.res.mjs"],
    exclude: ["node_modules", "lib"],
    reporters: process.env.GITHUB_ACTIONS
      ? ["default", "github-actions"]
      : ["default"],
    coverage: {
      exclude: ["*.res", "*.resi", "lib/**", "vitest.config.mjs"],
    },
  },
});
