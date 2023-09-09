import { defineConfig } from "vite";
import { plugin as elmPlugin } from "vite-plugin-elm";

export default defineConfig({
  plugins: [elmPlugin()],
  build: {
    outDir: "build",
    emptyOutDir: true,
  },
  server: {
    port: 3000,
    host: true,
  },
});
