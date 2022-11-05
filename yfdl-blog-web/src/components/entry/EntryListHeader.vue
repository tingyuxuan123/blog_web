<template>
<div class="entry_list_header">
    <my-menu :menu-list="menulist" :interval="true" @handle-click="menuclick"></my-menu>

</div>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import MyMenu from '@/components/common/menu.vue'

type Menu={
    menuname: string;
    active:boolean
}

let menulist=ref<Menu[]>([
    {
        menuname:"推荐",
        active:true,
    },
    {
        menuname:"最新",
        active:false,

    },
    {
        menuname:'热榜',
        active:false
    }
])

const emits=defineEmits(['handleClick'])

const menuclick=(menu:Menu)=>{
    emits('handleClick',menu)
}


</script>

<style scoped lang='scss'>
  .entry_list_header{
    height: 30px;
    display: flex;
    padding: 5px;
    align-items: center;
    border-bottom: 1px solid var(--theme-border2-color);
  }
</style>