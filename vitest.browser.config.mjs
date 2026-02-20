import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    include: ['__browser_tests__/**/*.res.mjs'],
    exclude: ['node_modules', 'lib'],
    browser: {
      enabled: true,
      provider: 'playwright',
      headless: true,
      instances: [{ browser: 'chromium' }],
    },
    reporters: process.env.GITHUB_ACTIONS ? ['default', 'github-actions'] : ['default'],
  },
})
