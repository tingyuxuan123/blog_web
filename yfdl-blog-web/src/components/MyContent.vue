<template>
  <div class="content">
    <div class="content-left">
      <slot name="left"></slot>
    </div>
    <div class="content-right">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<script lang="ts" setup name="home">
import { reactive, ref } from 'vue'
</script>

<style scoped lang="scss">
.content {
  max-width: var(--content-width);
  display: flex;
  justify-content: space-between;
  padding-top: 10px;

  box-sizing: border-box;

  .content-left {
    /* width: 68.5%; */
    /* background-color: var(--theme-bg4-color); */
    width: 780px;
  }

  .content-right {
    /* width: 30%; */
    /* background-color: var(--theme-bg4-color); */
    margin-left: 20px;
    width: 300px;
  }
}

@media screen and (max-width: 780px) {
  .content-left {
    width: 100% !important;
    /* background-color: var(--theme-bg4-color); */
  }

  .content-right {
    display: none;
    /* width: 30%; */
    /* background-color: var(--theme-bg4-color); */
  }
}
</style>
