<template>
  <div>
    <el-tabs v-model="activeName" class="tabs" @tab-click="handleClick">
      <el-tab-pane label="动态" name="dynamic">
        <template #label>
          <span class="custom-tabs-label">
            <svg-icon iconClass="dynamic"></svg-icon>
            <span>动态</span>
          </span>
        </template>
        User
      </el-tab-pane>
      <el-tab-pane label="文章" name="article">
        <template #label>
          <span class="custom-tabs-label">
            <i class="iconfont icon-relat-article"></i>
            <span>文章</span>
          </span>
        </template>
        <user-article :id="id"></user-article>
      </el-tab-pane>
      <el-tab-pane label="收藏夹" name="collection">
        <template #label>
          <span class="custom-tabs-label">
            <svg-icon iconClass="collection"></svg-icon>
            <span>收藏夹</span>
          </span>
        </template>

        <collect :id="id"></collect>
      </el-tab-pane>
      <el-tab-pane label="关注" name="follow">
        <template #label>
          <span class="custom-tabs-label">
            <i class="iconfont icon-follow"></i>
            <span>关注</span>
          </span>
        </template>
        <follow :id="id"></follow>
      </el-tab-pane>
      <el-tab-pane label="点赞" name="likes">
        <template #label>
          <span class="custom-tabs-label">
            <i class="iconfont iconfont icon-like"></i>
            <span>点赞</span>
          </span>
        </template>
        <likes :id="id"></likes>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import SvgIcon from '@/components/SvgIcon/index.vue'
import UserArticle from './article/article.vue'
import collect from '@/components/user/collect/collect.vue'
import follow from './follow/follow.vue'
import likes from './likes/likes.vue'

type Props = {
  id: number
}
const props = defineProps<Props>()

let activeName = ref('dynamic')
// const handleClick = () => {}
</script>

<style scoped lang="scss">
.tabs {
  margin-top: 20px;
  background-color: var(--theme-bg4-color);
  min-height: 500px;
  box-shadow: 0 0 10px rgba($color: #000000, $alpha: 0.1);
  border-radius: 5px;

  ::v-deep(.el-tabs__header) {
    margin: auto;
  }

  ::v-deep(.el-tabs__item) {
    margin: 0px 20px;
    padding: 0px 00px;
    font-size: 14px;
  }

  .el-tabs__content {
    padding: 32px;
    color: var(--theme-text-color);
    font-size: 32px;
    font-weight: 600;
  }

  .custom-tabs-label .el-icon {
    vertical-align: middle;
  }

  .custom-tabs-label span {
    vertical-align: middle;
    margin-left: 4px;
  }
}
</style>
