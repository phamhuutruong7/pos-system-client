import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import * as dotenv from 'dotenv'

// Load environment variables from .env file
dotenv.config()

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  base: process.env.VITE_BASE_PATH || '/'
})
