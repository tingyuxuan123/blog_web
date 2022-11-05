<template>
  <div class="myheader">
    <div class="content">
      <div class="myheader-left">
      <div class="logo">
      遥宇
    </div>
    <my-menu :menu-list="menuList" :route="true"></my-menu>
    </div>
    <div class="myheader-right">
      <div class="search">
        <el-input placeholder="搜索" :suffix-icon="Search"></el-input>
      </div>

      <span>管理端</span>
         
    <el-switch
      v-model="theme"
      class="mt-2"
      style="margin-left: 24px"
      inline-prompt
      :active-icon="Check"
      :inactive-icon="Close"
      />
    <el-button type="primary" plain>登录</el-button>

    </div>
    </div>
  

  </div>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import { Check, Close, Search} from '@element-plus/icons-vue'
import MyMenu from '@/components/common/menu.vue'
let theme=ref<string>("light")

type Menu={
  menuname:string,
  path:string;
  active:boolean
}

let menuList=ref<Menu[]>([
  {
    menuname:'首页',
    path:"/",
    active:true,
  },
  {
    menuname:'分类',
    path:"/",
    active:false,
  },
  {
    menuname:'标签',
    path:"/",
    active:false,
  },
  {
    menuname:'课程',
    path:"/",
    active:false,
  }
])




</script>

<style scoped lang='scss'>
.myheader{
  width: 100%;
  display: flex;
  background-color: var(--theme-header-bg-color);
  border-bottom: 1px solid var( --theme-border1-color);
  justify-content: center;
  .content{
    max-width: var(--content-width);
    display: flex;
    justify-content: space-between;
  
    height: 55px;
    color: var(--theme-text3-color);
 
    align-items: center;
  }
  
  .myheader-left{
    display: flex;
    width: 500px;

    .logo{
      margin-right: 15px;
    }

  }

  .myheader-right{
    display: flex;
    width: 500px;
    justify-content: space-evenly;
    align-items: center;
  }


}

  
</style>