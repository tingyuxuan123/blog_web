<template>
  <div class="aside-item">
        <div class="item-header">
            <slot name="header"></slot>
        </div>
        <div class="item-content">
            <slot name="content"></slot>
        </div>
  </div>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'

</script>

<style scoped lang='scss'>
  .aside-item{
    width: 100%;
    background-color: var(--theme-bg4-color);
    margin-bottom: 15px;
    /* position: relative; */

    .item-header{
        width: 100%;
        padding: 12px;
        box-sizing: border-box;
        border-bottom: 1px solid var(--theme-border2-color);
    }

    .item-content{
        width: 100%;
        padding: 12px;
        box-sizing: border-box;
    }
  }
</style>