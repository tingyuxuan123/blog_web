<template>
  <div class="entry-item" @click="handleClick">
      <div class="entry-item-top">
          <div class="item-left">
            <img :src="article.avatar" alt="">
            <span class="username">{{article.nickName}}</span>
            <span class="createTime">{{formatting(article.createTime)}}</span>
          </div>
          <div class="item-right">
              <span>分类: {{article.categoryName}}</span>
          </div>
      </div>
      <div class="entry-item-center">
         <div class="item-left">
          <p>{{article.title}}</p>
          <p>{{article.summary}}</p>
         </div>
         <div class="item-right">
            <img :src="article.thumbnail" alt="">
         </div>
      </div>
      <div class="entry-item-bottom">
          <div class="item-left">
              <span><el-icon><View /></el-icon> {{article.viewCount}}</span>
              <span> <svg-icon iconClass="likes"></svg-icon> {{article.likesCount}}</span>
              <span> <el-icon><ChatDotSquare /></el-icon> {{article.commentCount}}</span>
          </div>
          <div class="item-right">
              <span v-for="tag in article.tags">
                {{tag.name}}
              </span>
          </div>
      </div>
  </div>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import type {ArticleListInfo} from '@/api/apiType'
import {formatting} from '@/utils/time'

import {useRouter} from 'vue-router'

const router=useRouter();



type Props={
        article:ArticleListInfo
    }

  const props=defineProps<Props>()




const handleClick=()=>{

  
  router.push({
    name:'detail',
    params:{
      id:props.article.id
    }
  })
}


</script>

<style scoped lang='scss'>
  .entry-item{
    width: 100%;
    height: 180px;
    padding: 15px;
    box-sizing: border-box;
    border: 1px solid var(--theme-border1-color);
    &:hover{
      background-color: var(--theme-block-hover-color);
    }
    cursor:pointer;

    .entry-item-top{
      height: 35px;
      display: flex;
      justify-content: space-between;
      align-items: center;

      .item-left{
        display: flex;
        justify-content: space-between;
        align-items: center;
        img{
          width: 30px;
          height: 30px;
          border-radius: 999px;
          margin-right: 15px;
        }
        span{
          margin-right: 10px;
         
        }
        .createTime{
          font-size: 4px;
          color: var(--theme-text4-color);
        }

      }

      .item-right{
        color: var(--theme-text3-color);
      }
      

    }
    .entry-item-center{
      height: 80px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      .item-left{
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;

        p:nth-child(1){
          margin-left:45px;
          font-weight: bolder;
        }

        p:nth-child(2){
          color: var(--theme-text3-color);
        }
        
      }

      .item-right{
        img{
          max-height: 80px;
          max-width: 150x;
        }
      }

    }
    .entry-item-bottom{
      display: flex;
      justify-content: space-between;
      align-items:flex-end;
      height:calc(100% - 80px - 35px);

      .item-left{
        display: flex;
        align-items: center;

        span {
          font-size: 12px;
          color: var(--theme-text3-color);
          margin-right: 12px;
          

        }
      }

      .item-right{
        span{
          padding:0px 5px;
          box-sizing: border-box;
          font-size: 8px;
          color: var(--theme-text3-color);
          &:hover{
            color: var( --theme-text-hover-color);
          }
          &:nth-child(1) ~ span{
            border-left: 1px solid var(--theme-border1-color);
          }
        }
      }

    }



  }
</style>