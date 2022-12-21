<template>
  <el-button v-if="isCanSend" @click="getCode">获取证码</el-button>
  <el-button v-else class="awaitbtn" disabled>{{ timer }}后可重发</el-button>
</template>

<script lang="ts" setup>
import { reactive, ref, watch } from 'vue'
import { sendCodeNeedVerify } from '@/api/user'
import { ElMessage } from 'element-plus'
const isCanSend = ref(true)
let timer = ref(60)

type Props = {
  email: string
}

const props = defineProps<Props>()

const matchEmail = (email: string): boolean => {
  const ePattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/
  return ePattern.test(email)
}

const getCode = async () => {
  if (!matchEmail(props.email)) {
    ElMessage({
      message: 'email格式不争取,请重新输入！',
      type: 'warning'
    })
    return
  }

  const res: any = await sendCodeNeedVerify(props.email)

  if (res.code == 200) {
    ElMessage({
      message: '验证码发送成功！',
      type: 'success'
    })
  } else {
    ElMessage({
      message: res.msg,
      type: 'warning'
    })
  }

  isCanSend.value = false
}

watch(isCanSend, (newval) => {
  if (!newval) {
    timer.value = 60
    let t = setInterval(() => {
      timer.value = timer.value - 1
      if (timer.value == 0) {
        clearInterval(t)
        isCanSend.value = true
      }
    }, 1000)
  }
  console.log(newval)
})
</script>

<style scoped lang="scss">
/* button{
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
          } */
</style>
