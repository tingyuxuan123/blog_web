<template>
    <div class="userinfo">
        <div class="img">
            <img :src="userinfo.avatar" alt="">
        </div>
        <div class="info">
            <div class="nickname">{{userinfo.nickName}}</div>

            <div class="job">
                <span v-if="userinfo.company || userinfo.position"></span>
                <span class="tip" v-else><svg viewBox="64 64 896 896" data-icon="plus" width="1em" height="1em" fill="currentColor" aria-hidden="true" focusable="false" class=""><path d="M482 152h60q8 0 8 8v704q0 8-8 8h-60q-8 0-8-8V160q0-8 8-8z"></path><path d="M176 474h672q8 0 8 8v60q0 8-8 8H176q-8 0-8-8v-60q0-8 8-8z"></path></svg> 你从事什么职业</span>
            </div>
            
            <div class="label">
                <span v-if="userinfo.label"></span>
                <span class="tip" v-else><svg viewBox="64 64 896 896" data-icon="plus" width="1em" height="1em" fill="currentColor" aria-hidden="true" focusable="false" class=""><path d="M482 152h60q8 0 8 8v704q0 8-8 8h-60q-8 0-8-8V160q0-8 8-8z"></path><path d="M176 474h672q8 0 8 8v60q0 8-8 8H176q-8 0-8-8v-60q0-8 8-8z"></path></svg>你有哪些爱好</span>
            </div>

        </div>

        <div class="other">
            <div class="url">
                <i class="iconfont icon-GitHub"></i>
                <i class="iconfont icon-personal-center"></i>
            </div>
            <div class="following">
                <div v-if="!isOww">
                    <el-button v-if="!userinfo.isFollow" @click="follow">关注</el-button>  <el-button @click="follow" class="hasFollow" v-else>已关注</el-button> 
                    <el-button>私信</el-button>
                </div>
                <div v-else>
                    <el-button >编辑个人资料</el-button>
                </div>
                
        
            </div>
        </div>
    </div>


</template>

<script lang='ts' setup >
import {reactive,ref,inject,computed} from 'vue'
import {useUserStore} from '@/stores/userStore'

const userStore= useUserStore()

type Props={
    id:number
}

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

const props=defineProps<Props>()

let userinfo = inject<UserInfoByHomePage>("userinfo")

console.log(userinfo);

const follow=()=>{

}

const isOww =computed(()=>{
   return userStore.userInfo.id==userinfo.id
})

</script>

<style scoped lang='scss'>
  .userinfo{
    display: flex;
    width: 100%;
    height: 150px;
    padding: 20px;
    box-sizing: border-box;
    background-color: var(--theme-bg4-color);
    .img{
        width: 120px;
        img{
            width: 88px;
            height: 88px;
            border-radius: 999px;
        }
    }
    .info{
        flex: 1;
        display: flex;
        flex-direction: column;
        
        .nickname{
            font-weight: bolder;
            font-size: 18px;
        }

        .job{
            display: flex;  
            font-size: 12px;
            margin-top: 15px;
            color: var(--theme-text5-color);
            span{
                display: flex;
                align-items: center;
            }
        }

        .label{
            font-size: 12px;
            margin-top: 10px;
            color: var(--theme-text5-color);
            span{
                display: flex;
                align-items: center;
            }
        }

        .tip{
            cursor: pointer;
        }
        
    }
    .other{
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        justify-content: space-between;
        
        .url{
            i{
                color: rgba(0, 0, 0, 0.22);
                padding-right: 15px;
                cursor: pointer;
            }
        }

        .following{
            button{
            width: 100px;

            &:first-child{
                background-color:var(--theme-bg9-color);
                color: var(--theme-bg1-color);
            }
            &:last-child{
                background-color:var(--theme-bg5-color);
                color: var(--theme-text5-color);
            }
        }
        }
    }
  }
</style>