<template>
  <div class="likes">
    <entry-list
      v-if="articleList.length > 0"
      :article-list="articleList"
    ></entry-list>
    <el-empty v-else description="暂无数据" />
  </div>
</template>

<script lang="ts" setup>
import { onMounted, reactive, ref } from 'vue'
import EntryList from '@/components/entry/EntryList.vue'
import { articleListByUserLikes } from '@/api/article'

type Props = {
  id: number
}

const props = defineProps<Props>()

const articleList = ref([])

const getArticleListByUserLikes = async () => {
  const res = await articleListByUserLikes(props.id)
  articleList.value = res.data
}

onMounted(() => {
  getArticleListByUserLikes()
})
</script>

<style scoped lang="scss">
.likes {
}
</style>
