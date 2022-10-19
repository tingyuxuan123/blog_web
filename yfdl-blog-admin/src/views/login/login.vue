<template>
  
  <div class="login">
    <el-form :model="loginForm" label-width="120px">
        <el-form-item label="用户名:">
            <el-input  v-model="loginForm.userName"></el-input>
        </el-form-item>
        <el-form-item label="密码:">
            <el-input v-model="loginForm.password"></el-input>
        </el-form-item>

        <el-form-item>
        <el-button type="primary" @click="onSubmit">登录</el-button>
        <el-button>注册</el-button>
        </el-form-item>

    </el-form>
  </div>

</template>

<script lang='ts' setup name="login">
import {reactive, ref} from 'vue'
import {login} from '@/api/login'
import {useUserStore} from '@/stores/userStore'
import {useRouter} from "vue-router"
import { ElMessage } from 'element-plus';

let loginForm=reactive({userName:"",password:""});
const userStore=useUserStore()
const router = useRouter()


const onSubmit=async()=>{
   let data:any= await login(loginForm.userName,loginForm.password)

   if(data.code==200){
    userStore.token=data.data.token;
    userStore.userInfo=data.data.userInfo;

    ElMessage({
        showClose: true,
        message: "登录成功",
        type: 'success',
    })

    router.push("/layout")

   }else{
    ElMessage({
        showClose: true,
        message: data.msg,
        type: 'error',
    })
    
  //  console.log(data.msg);
    
   }

//   console.log(data)
}


</script>

<style scoped lang='less'>
  .login{
    margin-left:50%;
    transform: translate(-50%,0);
    width: 500px;
    height: 400px;
    border: 1px solid;
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>