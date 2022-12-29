<template>
  <div class="article">
    <entry-list
      v-if="articleList.length > 0"
      :article-list="articleList"
    ></entry-list>
    <el-empty v-else description="暂无数据" />
  </div>
</template>

<script lang="ts" setup>
import { onMounted, ref } from 'vue'
import { articleListByUserId } from '@/api/article'
import type { ArticleListInfo } from '@/api/apiType'
import EntryList from '@/components/entry/EntryList.vue'

type Props = {
  id: number
}
const props = defineProps<Props>()

let articleList = ref<ArticleListInfo[]>([])

const getArticleListByUserId = async () => {
  const res = await articleListByUserId(props.id, 10, 1)

  articleList.value = res.data.rows

  // console.log(articleList)
}

onMounted(() => {
  getArticleListByUserId()
})
</script>

<style scoped lang="scss">
.article {
}
</style>
