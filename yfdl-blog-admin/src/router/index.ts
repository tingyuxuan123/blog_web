import { createRouter, createWebHistory } from 'vue-router'
import login from '../views/login/login.vue'
import {useUserStore} from '@/stores/userStore'
import Layout from '@/views/Layout.vue';
import userInfo from "../views/main/userManage/userInfo.vue"
import panel from "../views/main/panel/index.vue"

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path:'/',
      redirect:"/layout/userInfo"
    },
    {
      name:"login",
      path:"/login",
      component:login
    },
    {
      name:"layout",
      path:"/layout",
      component:Layout,
      children:[
        {
          name:"userInfo",
          path:"userInfo",
          component:userInfo
        },
        {
          name:"panel",
          path:"panel",
          component:panel
        },
        {
          name:"allArticle",
          path:"allArticle",
          component:import("@/views/main/articleManage/allArticleView.vue")
        },
        {
          name:"write",
          path:"write",
          component:import("@/views/main/articleManage/writeView.vue")
        },
        {
          name:"category",
          path:"category",
          component:import("@/views/main/articleManage/category.vue")
        },
        {
          name:"span",
          path:"span",
          component:import("@/views/main/articleManage/span.vue")
        },
        {
          name:"comment",
          path:"comment",
          component:import("@/views/main/comment/index.vue")
        },
        {
          name:"imageManage",
          path:"imageManage",
          component:import("@/views/main/imageManage/index.vue")
        },
      ]
    }
  ]
})

//全局守卫
router.beforeEach((to,from,next)=>{
  const userStore=useUserStore()

  

  if(userStore.token ||to.name=="login"){
     next() 
  }else{
    const fullPath:string=encodeURIComponent(router.currentRoute.value.fullPath);
    console.log(fullPath);
    
    //encodeURIComponent 转换url编码，防止解析时出现问题
    router.push("/login?redirectUrl="+fullPath)       
    // next() 
  }

 

})

router.afterEach((to,from)=>{
  document.title=to.name.toString();
  
})



export default router
