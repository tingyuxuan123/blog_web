import { createRouter, createWebHistory } from 'vue-router'
import layout from '@/Layout/index.vue'
import home from '@/views/home.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      name: 'layout',
      path: '/',
      component: layout,
      children: [
        {
          name: 'home',
          path: '/',
          component: home
        },
        {
          name: 'detail',
          path: 'detail/:id',
          component: () => import('@/views/Detail.vue')
        },
        {
          name: 'user',
          path: 'user/:id',
          component: () => import('@/views/user.vue')
        },
        {
          name: 'settings',
          path: '/settings',
          redirect: '/settings/profile',
          component: () => import('@/views/settings.vue'),
          children: [
            {
              name: 'profile',
              path: 'profile',
              component: () => import('@/components/settings/profile.vue')
            },
            {
              name: 'account',
              path: 'account',
              component: () => import('@/components/settings/account.vue')
            }
          ]
        }
      ]
    }
  ]
})

export default router
