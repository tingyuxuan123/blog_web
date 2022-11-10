<template>
  <div class="login" v-if="scrollStore.isVisibleLoginForm" >
    <div class="wrap" @click="scrollStore.isVisibleLoginForm=false"></div>
    <div class="loginForm">
      <el-tabs v-model="activeName" class="demo-tabs" @tab-click="handleClick">
      <el-tab-pane label="验证码登录" name="first">
        <form action="#" >
          <input type="text" placeholder="邮箱" v-model="codeForm.email">
          <div class="pas">
            <input type="text" v-model="codeForm.code" placeholder="请输入邮箱验证码">
            <button v-if="isCanSend" @click.prevent="getCode" >获取邮箱验证码</button>
            <button v-else class="awaitbtn" disabled>{{timer}}后可重发</button>
          </div>
          
          <input class="loginbtn" type="submit" value="登录/注册" @click.prevent="loginClick">

        </form>
      </el-tab-pane>
      <el-tab-pane label="密码登录" name="second">
        <form action="#">
          <input type="text" placeholder="邮箱"  v-model="pwdForm.email">
          <div class="pas">
            <input type="password" placeholder="请输入密码" v-model="pwdForm.pwd">
          </div>
          
          <input class="loginbtn" type="submit" value="登录" @click.prevent="loginClick">

        </form>
      </el-tab-pane>
    </el-tabs>

  <div class="title"> <span></span> 其他登录方式 <span></span></div>    

  <div class="otherLogin">
    <span class="qq">
      <svg width="24" height="24" viewBox="0 0 24 24" fill="#50C8FD" class="ZDI ZDI--Qq24"><path fill-rule="evenodd" d="M12.003 2c-2.265 0-6.29 1.364-6.29 7.325v1.195S3.55 14.96 3.55 17.474c0 .665.17 1.025.281 1.025.114 0 .902-.483 1.748-2.072 0 0-.18 2.197 1.904 3.967 0 0-1.77.495-1.77 1.182 0 .686 4.078.43 6.29 0 2.239.425 6.288.687 6.288 0 0-.688-1.77-1.182-1.77-1.182 2.086-1.77 1.906-3.967 1.906-3.967.845 1.588 1.634 2.072 1.746 2.072.111 0 .283-.36.283-1.025 0-2.514-2.165-6.954-2.165-6.954V9.325C18.29 3.364 14.268 2 12.003 2Z" clip-rule="evenodd"></path></svg>
    </span>
  </div>
  <div class="zhushi">
    未注册邮箱验证后自动注册
  </div>
    </div>


  </div>
</template>

<script lang='ts' setup >
import {reactive, ref,watchEffect,onMounted,onUnmounted, watch} from 'vue'
import { ElMessage, TabsPaneContext } from 'element-plus'
import modalHelper from '@/utils/modalHelper'
import {usescrollStore} from '@/stores/useScroll'
import {sendEmail,loginOrRegisterByCode,login} from "@/api/login"
import {useUserStore} from "@/stores/userStore";
import {copy} from '@/utils/copyObject'

const userStore=useUserStore();

const activeName = ref('first')
const isCanSend=ref(true);
let timer=ref(60);
const handleClick = (tab: TabsPaneContext, event: Event) => {
  console.log(tab, event)
}

const getCode=async ()=>{
 const res:any= await sendEmail(codeForm.email)
 
 if(res.code==200){
    ElMessage({
        message:"验证码发送成功！",
        type:'success'
    })
 }else{
  ElMessage({
    message:"验证码发送失败，请重试",
    type:'warning'
  })
 }

 isCanSend.value=false;

}

watch(isCanSend,(newval)=>{
  
  if(!newval){
    timer.value=60;
     let t= setInterval(()=>{
          timer.value=timer.value-1;
          if(timer.value==0){
              clearInterval(t);
              isCanSend.value=true;
          }
      },1000)
  }
    console.log(newval);
    
})

const loginClick=async()=>{
  let res:any;
  if(activeName.value=="first"){ //验证码登录
   res=  await loginOrRegisterByCode(codeForm);
    
  }else { 
    //密码登录
  res= await login(pwdForm.email,pwdForm.pwd)
  }

  if(res.code == 200){
    copy(res.data.userInfo,userStore.userInfo)
    userStore.token=res.data.token

    ElMessage({
      message:"登录成功",
      type:'success'
    })
    scrollStore.isVisibleLoginForm=false;
  }

}


let codeForm=reactive({
  email:"",
  code:""
})

let pwdForm=reactive({
  email:"",
  pwd:""
})



const scrollStore=usescrollStore()

watchEffect(()=>{

  if(scrollStore.isVisibleLoginForm){
    modalHelper.afterOpen();
  }else{
    modalHelper.beforeClose();
  }
 
})


</script>

<style scoped lang='scss'>
.login{
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
    
  display: flex;
  justify-content: center;
  

    .wrap{

      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      background-color: rgba(18,18,18,.65);
      -webkit-transition: background-color .3s ease-out;
      transition: background-color .3s ease-out;
      z-index: 100;
    }

    .loginForm{
      width: 400px;
      height: 500px;
      background-color: #fff;
      position: fixed;

      top: 50%;
      left: 50%;
      transform: translate(-50%,-50%);

      padding: 15px;
      box-sizing: border-box;
      z-index:101;
      form{
        display: flex;
        flex-direction: column;
        

        input{
        outline: none;
        border: 0px;
        border-bottom: 1px solid #ebebeb;
        height: 50px;
      }

      
      .pas{
          position: relative;
          input{
            width: 100%;
          }
          button{
            position:absolute;
            cursor: pointer;
            right: 0px;
            top: 15px;
            border: 0px;
            background-color: inherit;
            color: #056de8;
            &:hover{
              color: #7c889f;
            }
          }

          .awaitbtn{
            color: #7c889f;
          }
        }

      .loginbtn{
        margin-top: 20px;
        height: 35px;
        border-radius: 5px;
        color: #fff;
        background-color: #056de8;
        cursor: pointer;
        &:hover{
          background-color: #0461cf;
        }
      }

      }

    }
    .title{
      display: flex;
      margin-top: 30px;
      color: #999;
      font-size: 12px;
      span {
        flex: 1;
        border-top: 1px solid #ebebeb;
        margin-top: 9px;
      }
    }

    .otherLogin{
      display: flex;
      justify-content: center;
      margin: 15px 0px;
      .qq{
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 999px;
        width: 36px;
        height: 36px;
        line-height: 30px;
        text-align: center;
        background-color: #f6f6f6;
        cursor: pointer;
      }

    }
    
  .zhushi{
    color: #999999;
    font-size: 12px;
  }
}
  
</style>