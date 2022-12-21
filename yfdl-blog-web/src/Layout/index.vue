<template>
  <div class="layout">
    <header>
      <my-header class="myheader"></my-header>
    </header>
    <main>
      <router-view></router-view>
    </main>
    <footer></footer>

    <login></login>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import MyHeader from '@/components/MyHeader.vue'
import MyFooter from '@/components/MyFooter.vue'
import login from '@/views/login.vue'
</script>

<style scoped lang="scss">
.layout {
  width: 100vw;
  height: 100%;
  min-height: 100vw;
  background-color: var(--theme-bg1-color);

  header {
    position: sticky;
    top: 0px;
    z-index: 99;
  }

  main {
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    display: flex;
    justify-content: center;

    .home {
      width: var(--content-width);
    }
  }
}
</style>
