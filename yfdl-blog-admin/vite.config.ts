import { fileURLToPath, URL } from 'node:url'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'
import { defineConfig } from 'vite'
import path from 'path'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(),
    AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname,'./src')
    }
  },
  // css:{
  //   preprocessorOptions:{
  //     less:{
  //       javascriptEnabled:true,
  //       additionalData:`@import "${path.join(
  //           __dirname,
  //           "./src/assets/styles/mixins.less",
  //         )}";`,
          
     
  //     }
  //   }
  // }

})
