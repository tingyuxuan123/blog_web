<template>
  <div class="enrty-list">
    <template v-for="article in articleList" :key="article.id">
      <EntryItem :article="article"></EntryItem>
    </template>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import type { ArticleListInfo } from '@/api/apiType'
import EntryItem from './EntryItem.vue'

type Props = {
  articleList: ArticleListInfo[]
}
let props = defineProps<Props>()
</script>

<style scoped lang="scss"></style>
