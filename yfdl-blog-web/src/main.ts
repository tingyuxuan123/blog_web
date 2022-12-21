import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'
import 'element-plus/dist/index.css'

import SvgIcon from '@/components/SvgIcon/index.vue'
import 'virtual:svg-icons-register'

import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import piniaPluginPersist from 'pinia-plugin-persistedstate'

import '@/assets/icons/icon/iconfont.css'

import './styles/theme.css'
import './styles/index.scss'

const app = createApp(App)

for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

app.component('svg-icon', SvgIcon)

const store = createPinia()
store.use(piniaPluginPersist)

app.use(store)
app.use(router)

app.mount('#app')
