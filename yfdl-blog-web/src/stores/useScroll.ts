import { defineStore } from 'pinia'

export const usescrollStore = defineStore('scrollStore', {
  state: () => {
    return {
      isVisibleLoginForm: false
    }
  },
  getters: {},
  actions: {},
  persist: true
})
