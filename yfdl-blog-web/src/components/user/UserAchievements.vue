<template>
  <div>
    <aside-item>
              <template #header>
                <span class="achievement"><i class="iconfont icon-achievement"></i> 个人成就</span>
              </template>
              <template #content> 
                <ul>
                    <li> <span> <i class="iconfont icon-like"></i> 获赞点击</span> <span>{{userinfo.likesCount}}</span></li>
                    <li> <span> <i class="iconfont icon-eye"></i> 文章被阅读</span> <span>{{userinfo.readCount}}</span></li>
                </ul>
                
              </template>
    </aside-item>
  </div>
</template>

<script lang='ts' setup >
import {reactive, ref,inject} from 'vue'
import AsideItem from "@/components/aside/asideItem.vue"
type Props={
    id:number
}
const props= defineProps<Props>()
    type UserInfoByHomePage={
  id:number,
  avatar:string,
  nickName:string,
  email:string,
  phonenumber:string,
  sex:string,
  github:string,
  homepage:string,
  position:string,
  company:string,
  label:string,
  isFollow:boolean,
  likesCount:number,
  readCount:number,
  followCount:number,
  beFollowCount:number,
  collectionCount:number,
  createTime:number
}
const userinfo=inject<UserInfoByHomePage>("userinfo")

</script>

<style scoped lang='scss'>

.achievement{

}

  li{
    line-height: 38px;
  }
  span {
      font-size: 14px;
      i {
        display: inline-flex;
        width: 25px;
        height: 25px;
        background-color: var(--theme-bg8-color);
        color: var(--theme-text7-color);
        border-radius: 999px;
        justify-content: center;
        align-items: center;


      }
      
    }
</style>