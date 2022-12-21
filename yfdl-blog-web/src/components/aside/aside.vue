<template>
  <div class="aside">
    <slot></slot>
  </div>
</template>

<script lang="ts" setup name="aside">
import { reactive, ref } from 'vue'
</script>

<style scoped lang="scss">
.aside {
  width: 100%;
}
</style>
