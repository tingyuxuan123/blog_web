<template>
  <template v-for="parent,index in routerStore.routes">
    <el-sub-menu v-if="parent.children && parent.children.length>0" :index="parent.id.toString()">
        <template #title>
            <svg-icon  :icon-class="parent.meta.icon"/>
            <span class="title">{{parent.meta.title}}</span>
        </template>

        <el-menu-item :index="item.name" v-for="item in parent.children" @click="onClick">
            <svg-icon :icon-class="item.meta.icon"/>
            <template #title><span class="title">{{item.meta.title}}</span></template>
        </el-menu-item>
       
    </el-sub-menu>
    <el-menu-item v-else :index="parent.name" @click="onClick">
        <svg-icon :icon-class="parent.meta.icon"/>
        <template #title><span class="title">{{parent.meta.title}}</span></template>
    </el-menu-item>
  </template>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import {useRoutesStore} from '@/stores/routesStore'
import {useRouter} from 'vue-router'
let routerStore=useRoutesStore()
let router=useRouter()

let menuList=ref<Array<Record<string,any>>>([]); //表格数据

        

    // routerStore.GenerateRoutes().then((result) => {
      
    // menuList.value=result.filter(item=>{ //
    //     if(item.meta && item.meta.menuType && (item.meta.menuType=="M" || item.meta.menuType=="C")){
    //         return true
    //     }else{
    //         return false
    //     }

    // })

    // }).catch((err) => {
        
    // });

    let onClick=({index})=>{
        // console.log(index);
        if(index){
            router.push({
            name:index,
            params:{}
        })
        }

        
    }

    

</script>

<style scoped lang='less'>
    .title{
        margin-left: 10px;
    }
</style>