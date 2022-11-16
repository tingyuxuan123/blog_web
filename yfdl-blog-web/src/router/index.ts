import { createRouter, createWebHistory } from 'vue-router'
import layout from '@/Layout/index.vue'
import home from '@/views/home.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      name:'layout',
      path:'/',
      component:layout,
      children:[
        {
          name:'home',
          path:'/',
          component:home,
        },
        {
          name:"detail",
          path:'detail/:id',
          component:()=>import("@/views/Detail.vue")
        },
        {
          name:'user',
          path:"user/:id",
          component:()=>import("@/views/user.vue")
        }
      ]
    }
  ]
})

export default router
