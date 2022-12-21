<template>
  <div></div>
</template>

<script lang="ts" setup>
import { onMounted, reactive, ref } from 'vue'
import { followListApi } from '@/api/follow'

type Props = {
  id: number
}

const props = defineProps<Props>()
console.log(props.id)

const followList = async () => {
  const res: any = await followListApi(props.id)
  console.log(res)
}

onMounted(() => {
  followList()
})
</script>

<style scoped lang="scss"></style>
