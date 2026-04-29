import { readFile } from "node:fs/promises";
import react from "@vitejs/plugin-react";
import { playwright } from "@vitest/browser-playwright";
import { defineConfig } from "vitest/config";

function rescriptSource() {
  return {
    name: "rescript-source",
    enforce: "pre",
    resolveId(id) {
      if (id.endsWith(".res")) return id;
    },
    async load(id) {
      if (!id.endsWith(".res")) return null;
      const code = await readFile(`${id}.mjs`, "utf8");
      const map = JSON.parse(await readFile(`${id}.mjs.map`, "utf8"));
      return { code, map };
    },
  };
}

export default defineConfig({
  plugins: [rescriptSource(), react()],
  test: {
    include: ["__browser_tests__/**/*_test.res"],
    exclude: ["node_modules", "lib"],
    browser: {
      enabled: true,
      provider: playwright(),
      headless: true,
      instances: [{ browser: "chromium" }],
    },
    reporters: process.env.GITHUB_ACTIONS
      ? ["default", "github-actions"]
      : ["default"],
  },
  optimizeDeps: {
    include: [
      "react",
      "react-dom",
      "react-dom/client",
      "react/jsx-runtime",
      "rescript-vitest/src/Vitest.res.mjs",
      "@rescript/runtime/lib/es6/Stdlib_Option.mjs",
      "@rescript/runtime/lib/es6/Primitive_option.mjs",
      "@rescript/runtime/lib/es6/Belt_Array.mjs",
    ],
    exclude: ["@vitest/browser/context", "vitest-browser-react"],
  },
});
