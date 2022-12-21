<template>
  <div class="entry_list_container">
    <entry-list-header @handle-click="menuClick"></entry-list-header>
    <entry-list :articleList="articles" v-if="articles"></entry-list>
    <el-skeleton v-else :rows="5" animated />
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import EntryListHeader from './EntryListHeader.vue'
import EntryList from '@/components/entry/EntryList.vue'
import { articleList } from '@/api/article'
import type { ArticleListInfo } from '@/api/apiType'
let pageinfo = {
  currentPage: 1,
  pageSize: 10
}

let articles = ref<ArticleListInfo[]>(null)

const getarticleList = async () => {
  const res: any = await articleList({}, pageinfo)

  articles.value = res.data.rows
  console.log(articles.value)
}

getarticleList()

let menuClick = (menu) => {
  console.log(menu)
}
</script>

<style scoped lang="scss">
.entry_list_container {
  width: 100%;

  /* padding: 10px; */
  box-sizing: border-box;
  background-color: var(--theme-bg4-color);
  .entry-list-header {
  }
}
</style>
