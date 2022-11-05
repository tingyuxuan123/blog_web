<template>
      <div class="menu">
      <ul>
        <li v-for="menu,index in menuList" :key="menu.menuname" :class="{menu_active: menu.active}" @click="menuClick(index,menu)">{{menu.menuname}}</li>
      </ul>
    </div>
</template>

<script lang='ts' setup  name="menu">
import {reactive, ref,watch,computed} from 'vue'
import {useRouter} from 'vue-router'

const router=useRouter();

    type Menu={
    menuname:string,
    path?:string;
    active:boolean
    }

    type Props={
        menuList:Menu[], //传送菜单列表
        route?:boolean, //使用使用路由
        interval?:boolean,
    }
   
  let props=withDefaults(defineProps<Props>(),{
        route:false,  //默认没有路由
        interval:false
    })

 const emits= defineEmits(['handleClick'])



    
    let charater=  computed(()=>{//间隔变量 在菜单之间添加 |
        if(props.interval){
            return "1px solid var(--theme-border2-color)"
        }else{
            return ""
        }
    })
    

    const menuClick=(index:number,menu:Menu)=>{
        props.menuList.forEach((item ,idnez)=>{
      if(index==idnez){
        item.active=true;
      }else{
        item.active=false;
      }
    })
    //若果route 为ture 开启路由
    if(props.route){
        console.log('跳转');
        
        router.push(menu.path);
    }

    emits('handleClick',menu)
}

</script>

<style scoped lang='scss'>
    .menu> ul{
    display: flex;
      li{
        padding: 0px 10px;
        cursor: pointer;    
        
        &:hover{
          color: var( --theme-text-hover-color);
        }

        &:nth-child(1) ~ li  {
            border-left: v-bind(charater);
        
        }
      }

 
      .menu_active{
        color: var(--theme-text-active-color);
      }

    

    }
</style>