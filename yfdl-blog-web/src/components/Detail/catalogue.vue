<template>
  <div class="catalogue">
    <ul>
        <li v-for="catalogue,index in catalogues" :key="catalogue.title">
            <span @click="handleClick(catalogue.height)" :class="{active:catalogue.active}">{{catalogue.title}}</span>
            <catalogue v-if="catalogue.children.length>0" :catalogues="catalogue.children" :nextheight="index< catalogues.length -1 ? catalogues[index+1].height: 0"></catalogue>
        </li>
    </ul>
  </div>
</template>

<script lang='ts' setup >
import {reactive, ref,onUnmounted, onMounted,watch,computed} from 'vue'
import { useWindowScroll } from '@vueuse/core'
import catalogue from './catalogue.vue'
type catalogue={
      title:string,
      height:number;
      active:boolean,
      children?:catalogue[];
      nextheight:number;
    }
type Props={
    catalogues:catalogue[],
    nextheight:number
}

   const props= defineProps<Props>()

    const handleClick=(height:number)=>{
       
        scrollToTop(height)
    }

    const { x, y } = useWindowScroll()


    watch(()=> y.value,(newVal,oldVal)=>{
  
        props.catalogues.forEach((item,index)=>{
        
            item.active=false;
            newVal = Math.ceil(newVal);
            if(newVal >= item.height && (item.children.length>0 ? (newVal< item.children[0].height) : index <props.catalogues.length-1 ? (newVal < props.catalogues[index+1].height) :props.nextheight ==0 ? true : newVal < props.nextheight)){
                item.active=true;
            }
        })
 
  
       
        
    })
   
    


// 滑动到顶部
const scrollToTop = (position:number) => {

        document.documentElement.scrollTop=position;
    
};
   


</script>

<style scoped lang='scss'>
  .catalogue{
        ul {
            li {
                line-height: 30px;

                span{
                    display: block;
                    &:hover{
                    background-color: var(--theme-block-hover-bg-color);
                    }
                    cursor: pointer;
                }

            }
        }

        .active{
            color: var(--theme-text-active-color);
        }
  }
</style>