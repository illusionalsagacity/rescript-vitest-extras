import { readFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { defineConfig } from "vitest/config";
import { playwright } from "@vitest/browser-playwright";

// Coverage globs are matched against absolute module paths before source-map remapping.
const rescriptSources = `${fileURLToPath(new URL("./src", import.meta.url))}/**/*.res`.replaceAll(
  "\\",
  "/",
);

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
      include: [rescriptSources],
      excludeAfterRemap: true,
      // Fail if coverage no longer remaps into the included ReScript sources.
      thresholds: { statements: 1 },
    },
    browser: {
      provider: playwright(),
      enabled: true,
      // at least one instance is required
      instances: [{ browser: "chromium" }],
    },
  },
});
