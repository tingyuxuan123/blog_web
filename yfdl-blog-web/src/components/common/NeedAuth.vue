<template>
  <div class="NeedAuth" v-if="isVisible">
    <slot></slot>
  </div>
</template>

<script lang="ts" setup>
import { useUserStore } from '@/stores/userStore'
import { computed } from 'vue'

const userStore = useUserStore()
const userId = userStore.userInfo.id //当前用户登录，如果没哟就为空

type Props = {
  id: number
}

const props = defineProps<Props>()

const isVisible = computed(() => {
  if (userId == null) {
    return false
  }
  return userId === props.id
})
</script>

<style scoped lang="scss"></style>
