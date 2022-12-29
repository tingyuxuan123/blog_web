import { followApi } from '@/api/follow'
import { useUserStore } from '@/stores/userStore'
import { usescrollStore } from '@/stores/useScroll'
import { ElMessage } from 'element-plus'

const userStore = useUserStore()
const scrollStore = usescrollStore()

/**
 * 判断是否登录，没登录跳出登录框
 * @returns
 */
export const isLogin = () => {
  if (userStore.token) {
    //如果token 不存在，说明没登录
    return true
  } else {
    ElMessage({
      message: '还未登录,请登录后操作！',
      type: 'warning'
    })
    scrollStore.isVisibleLoginForm = true

    return false
  }
}

export const follow = async (id: number) => {
  if (!isLogin()) {
    return
  }

  const index = userStore.followIds.indexOf(id)

  if (index !== -1) {
    //取消关注
    userStore.followIds.splice(index, 1)
  } else {
    userStore.followIds.push(id)
  }
  const res = await followApi(id)
}

/**
 * 跳转到指定位置
 */
export const scrollToTop = (position: number) => {
  document.documentElement.scrollTop = position
}
