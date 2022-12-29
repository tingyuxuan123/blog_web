<template>
  <div class="profile">
    <div class="profile-left">
      <h1>个人资料</h1>

      <el-form
        :inline="true"
        :model="userInfo"
        label-width="100px"
        label-position="left"
        style="min-width: 460px; width: 100%"
      >
        <el-form-item label="账号:" style="width: 100%">
          <el-input v-model="userInfo.userName" :disabled="true" />
        </el-form-item>
        <el-form-item label="用户名:" style="width: 100%">
          <el-input
            v-model="userInfo.nickName"
            placeholder="填写你的用户名"
            :minlength="2"
            maxlength="25"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="公司: " style="width: 100%">
          <el-input
            v-model="userInfo.company"
            placeholder="填写你的公司"
            maxlength="50"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="职位:" style="width: 100%">
          <el-input
            v-model="userInfo.position"
            placeholder="填写你的职位"
            maxlength="50"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="github:" style="width: 100%">
          <el-input
            v-model="userInfo.github"
            placeholder="填写你的github地址"
            maxlength="50"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="个人主页:" style="width: 100%">
          <el-input
            v-model="userInfo.homepage"
            placeholder="填写你的个人主页"
            maxlength="50"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="个人介绍:" style="width: 100%">
          <el-input
            type="textarea"
            :autosize="{ minRows: 4, maxRows: 4 }"
            v-model="userInfo.label"
            placeholder="填写你的个人介绍"
          />
        </el-form-item>
      </el-form>

      <div class="saveline">
        <el-button type="primary" @click="saveUpdate"> 保存修改 </el-button>
      </div>
    </div>

    <div class="profile-right">
      <el-upload
        class="avatar-uploader"
        :show-file-list="false"
        :http-request="handleUpload"
        :auto-upload="true"
      >
        <img v-if="userInfo.avatar" :src="userInfo.avatar" class="avatar" />
        <el-icon v-else class="avatar-uploader-icon">
          <Plus />
        </el-icon>
        <template #tip>
          <div class="el-upload__tip">
            支持 jpg、jpeg、png 格式大小 5M 以内的图片
          </div>
        </template>
      </el-upload>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref, toRaw } from 'vue'
import { uploadImg } from '@/api/upload'
import { useUserStore } from '@/stores/userStore'
import { ElMessage } from 'element-plus'
import { updateUserInfo } from '@/api/user'

type UserInfo = {
  userName: string
  avatar: string
  nickName: string
  company: string
  position: string
  github: string
  homepage: string
  label: string
}

const userInfo = ref<UserInfo>({
  userName: null,
  avatar: null,
  nickName: null,
  company: null,
  position: null,
  github: null,
  homepage: null,
  label: null
})

Object.assign(userInfo.value, toRaw(useUserStore().userInfo)) //从pinia 内拷贝一份数据

console.log(userInfo)

//图片上传
const handleUpload = async (img: any) => {
  const res: Record<string, any> = await uploadImg(img.file)

  if (res.code == 200) {
    userInfo.value.avatar = res.data
  } else {
    ElMessage({
      showClose: true,
      message: '图片选择失败，请重新选择',
      type: 'warning'
    })
  }
}

//保存用户信息的更新
const saveUpdate = async () => {
  const res: any = await updateUserInfo(userInfo.value)
  if (res.code == 200) {
    ElMessage({
      showClose: true,
      message: '信息更新成功！',
      type: 'success'
    })

    Object.assign(useUserStore().userInfo, userInfo.value)
  } else {
    ElMessage({
      showClose: true,
      message: '更新失败，请重试',
      type: 'warning'
    })
  }
}
</script>

<style scoped lang="scss">
.profile {
  width: 100% !important;
  display: flex;
  padding: 20px;
  box-sizing: border-box;

  .profile-left {
    width: 70%;

    h1 {
      border-bottom: 1px solid var(--theme-border3-color);
      padding-bottom: 20px;
      box-sizing: border-box;
      margin-bottom: 20px;
      font-size: 20px;
    }

    .saveline {
      border-top: 1px solid var(--theme-border3-color);
      padding-top: 15px;
      box-sizing: border-box;
    }
  }

  .profile-right {
    width: 30%;
    padding: 10px;
    box-sizing: border-box;
    text-align: center;
    img {
      width: 100px;
      height: 100px;
      border-radius: 999px;
      object-fit: cover; //防止挤压变形
    }
    .el-upload__tip {
      color: var(--theme-text6-color);
      text-align: center;
      font-size: 12px;
    }
  }
}
</style>
