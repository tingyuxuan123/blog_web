import { defineStore } from 'pinia'

export const useUserStore = defineStore('userStore', {
  state: () => {
    return {
      token: null,
      userInfo: {
        avatar: null, //头像
        email: null, //邮箱
        id: null, //id
        nickName: null, //昵称
        userName: null, //用户名
        sex: null, //性别
        label: null, //个人介绍
        github: null, //github主页
        homepage: null, //其他主页
        phonenumber: null, // 手机号
        position: null, //职位
        company: null //公司
      }
    }
  },
  getters: {},
  actions: {},
  persist: true
})
