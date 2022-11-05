<template>
  <div class="home">
    <my-content>
      <template #left>
        <entry-list-container></entry-list-container>
      </template>
      <template #right>
        <myaside></myaside>
      </template>
    </my-content>


  </div>
</template>

<script lang='ts' setup name="home">
import {reactive, ref} from 'vue'
import MyContent from '@/components/MyContent.vue'
import EntryListContainer from '@/components/entry/EntryListContainer.vue'
import myaside from '../components/aside/aside.vue';

</script>

<style scoped lang='scss'>

.home{
    width: 100%;

}



  
</style>