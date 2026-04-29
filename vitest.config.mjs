import { readFile } from "node:fs/promises";
import { defineConfig } from "vitest/config";
import { playwright } from "@vitest/browser-playwright";

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
  plugins: [rescriptSource()],
  optimizeDeps: {
    include: [
      "rescript-vitest/src/Vitest.res.mjs",
      "@rescript/runtime/lib/es6/Stdlib_Option.mjs",
      "@rescript/runtime/lib/es6/Primitive_option.mjs",
      "@rescript/runtime/lib/es6/Stdlib_JsError.mjs",
      "@rescript/runtime/lib/es6/Belt_Array.mjs",
    ],
  },
  test: {
    include: ["__tests__/**/*_test.res"],
    exclude: ["node_modules", "lib"],
    reporters: process.env.GITHUB_ACTIONS
      ? ["default", "github-actions"]
      : ["default"],
    coverage: {
      exclude: ["*.res", "*.resi", "lib/**", "vitest.config.mjs"],
    },
    browser: {
      provider: playwright(),
      enabled: true,
      // at least one instance is required
      instances: [{ browser: "chromium" }],
    },
  },
});
