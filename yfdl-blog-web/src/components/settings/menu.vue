<template>
  <div class="menu">
    <ul>
      <li
        @click="menuClick(index, item.path)"
        :class="{ menuActive: activeIndex == index }"
        v-for="(item, index) in menuList"
      >
        <svg-icon :iconClass="item.icon"></svg-icon>
        <span>{{ item.name }}</span>
      </li>
    </ul>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'

let activeIndex = ref(0)

let menuList = [
  {
    icon: 'user',
    name: '个人资料',
    path: 'profile'
  },
  {
    icon: 'setting',
    name: '账号设置',
    path: 'account'
  }
]

const router = useRouter()

const menuClick = (index: number, path) => {
  activeIndex.value = index
  router.replace({
    name: path
  })
}
</script>

<style scoped lang="scss">
.menu {
  width: 100%;
  box-sizing: border-box;

  ul {
    display: flex;
    flex-direction: column;

    li {
      display: flex;
      align-items: center;
      height: 40px;
      padding-left: 20px;
      border-right: 2px solid var(--theme-bg4-color);
      cursor: pointer;

      span {
        margin-left: 8px;
      }

      &:hover {
        color: var(--theme-text-active-color);
      }
    }

    .menuActive {
      background-color: var(--theme-bg-active-color);
      color: var(--theme-text-active-color);
      border-right: 2px solid var(--theme-text-active-color);
    }
  }
}
</style>
