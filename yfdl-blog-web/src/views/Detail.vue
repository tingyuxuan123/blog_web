<template>
  <div class="detail">
    <my-content>
      <template #left>
        <div class="left">
          <h1 class="title">{{detail.title}}</h1>
          <article-user class="article-user" v-if="info?.createBy"  :info="info" ></article-user>
          <img class="article-thumbnail" :src="detail.thumbnail" alt="">
          <md v-if="detail?.content !=undefined " :content="detail.content" @handle-catalogue="getCatalogue"></md>
          <div class="categoryInfo">
              <div class="category">
                  分类：<span>{{detail.categoryName}}</span>
              </div>
              <div class="tags">
                标签: <span v-for="item in detail.tags">{{item.name}}</span>
              </div>
          </div>
        </div>
        <my-comment v-if="detail.id" :article-id="detail.id"></my-comment>
      </template>
      <template #right>
        <myaside>
          <template #default>
            <aside-item>
              <template #header>
                相关文章
              </template>
              <template #content> 
                  <li>12</li>
                  <li>12</li>
                  <li>12</li>
              </template>
            </aside-item>
             <!-- 目录 -->
             <div ref="catalogueDom" :class="{'catalogue_sticky':isFixed}" >
                <aside-item  v-if="cataloguesRef && cataloguesRef.length>0">  
                <template #header>
                  <span>目录</span>
                </template>
                <template #content>
                  <catalogueVue  :catalogues="cataloguesRef" :nextheight="0"></catalogueVue>
                </template>
              </aside-item>
             </div>

          </template>

        </myaside>
      </template>
    </my-content>
    
  </div>
</template>

<script lang='ts' setup >
import {nextTick, reactive, ref,computed,onMounted,onUnmounted} from 'vue'
import {useRoute} from 'vue-router'
import {articleDetail} from '@/api/article'
import type {ArticleDetail} from '@/api/apiType'
import md from '@/components/MD.vue'
import MyContent from '@/components/MyContent.vue'
import myaside from '../components/aside/aside.vue';
import ArticleUser from '../components/Detail/articleUser.vue'
import catalogueVue from '@/components/Detail/catalogue.vue'
import AsideItem from '@/components/aside/asideItem.vue'
import MyComment from '@/components/comment/MyComment.vue'


const route=useRoute();
const id=route.params.id || null;
let detail=ref<ArticleDetail>({
    id: undefined,
    categoryName: undefined,
    commentCount: undefined,
    createTime: undefined,
    status: undefined,
    summary: undefined,
    tags:[],
    thumbnail:undefined,
    title: undefined,
    viewCount: undefined,
    likesCount:undefined,
    createBy: undefined,
    avatar: undefined,
    nickName:undefined,
    content:undefined,
    isComment:undefined
});
let cataloguesRef=ref(null)

  type Info={
        createBy:number,
        avatar:string,
        nickName:string,
        categoryName:string,
        viewCount:number,
        createTime:string
    }

let info=reactive<Info>({        
        createBy:undefined,
        avatar:undefined,
        nickName:undefined,
        categoryName:undefined,
        viewCount:undefined,
        createTime:undefined
      })  


const getarticleDetail=async()=>{
  let res= await articleDetail(id as string);
  detail.value=res.data
  // console.log(detail.value);
  
  info.avatar=detail.value.avatar;
  info.categoryName=detail.value.categoryName;
  info.createBy=detail.value.createBy;
  info.createTime=detail.value.createTime;
  info.nickName=detail.value.nickName;
  info.viewCount=detail.value.viewCount;

}

getarticleDetail();

const getCatalogue=(catalogue:any)=>{
  cataloguesRef.value=catalogue;
  // console.log(cataloguesRef);
  
}



let isFixed=ref(false)

//吸顶实现
let catalogueDom=ref(null)


onMounted(() => {
  window.addEventListener('scroll', handleScroll);
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
});

const handleScroll = () => {
  let scrollTop =
    window.pageYOffset ||
    document.documentElement.scrollTop ||
    document.body.scrollTop;
  
  isFixed.value= scrollTop-15 > catalogueDom.value.getBoundingClientRect().top ? true : false
  //isFixed.value = scrollTop > 133? true : false;
};

</script>

<style scoped lang='scss'>
.detail{
 
  .left{
    padding:35px;
    box-sizing: border-box;
    background-color: var(--theme-bg4-color);

  .article-user{
    margin-bottom: 20px;
  }

  .article-thumbnail{
    width: 100%;
    margin-bottom: 20px;
  }
    .categoryInfo{
      margin-top: 30px;
      display: flex;
      align-items: center;
      height: 40px;

      .category {
        margin-right: 35px;
        color: var(--theme-text3-color);
        span {
          margin-left: 8px;
          display:inline-block;
          padding:6px 10px;
          background-color: var(--theme-bg1-color);
          border-radius: 4px;
        }
      }
      
      .tags {
        span {
          margin-left: 8px;
          margin-right: 12px;
          display:inline-block;
          padding:6px 10px;
          color: var(--theme-text5-color);
          background-color: var(--theme-bg5-color);
          border-radius: 4px;
        }
      }
    }
  
  }
}
.title{
  font-size: 28px;
  margin-bottom: 20px;
}
.catalogue_sticky{
  position: fixed;
  box-sizing: border-box;
  width:330px;
  top: 68px;
  background-color: var(--theme-bg4-color);

}
  
</style>