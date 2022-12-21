<template>
  <div class="collection">
    <div class="wrapper">
      <div class="collectionForm">
        <div class="header">
          <h1 class="title">选择收藏夹</h1>
          <h6 class="subTitle">选择或创建你想添加的收藏夹</h6>
          <div class="close" @click="closeClick(false)">
            <el-icon><Close /></el-icon>
          </div>
        </div>
        <div class="content">
          <el-empty
            v-if="collectionList.length <= 0"
            :image-size="200"
            description="还没创建过收藏夹,先去创建一个吧！"
          />
          <div class="collectionItem" v-else v-for="item in collectionList">
            <div class="item-left">
              <span class="collectionName">{{ item.collectionName }}</span>
              <span class="collectionCount">{{ item.collectCount }}篇文章</span>
            </div>
            <div class="item-right">
              <input
                type="checkbox"
                :value="item.id"
                @click="selectCollection(item.id)"
              />
            </div>
          </div>
        </div>
        <div class="footer">
          <span @click="newCollection"
            ><el-icon><Plus /></el-icon> 新建收藏夹</span
          >

          <el-button type="primary" @click="submit">确定</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref, watchEffect, onMounted, onUnmounted } from 'vue'
import modalHelper from '@/utils/modalHelper'
import { collectionListApi } from '@/api/collection'
import { ElMessage } from 'element-plus'
import { insertCollect } from '@/api/collect'

type CollectionList = {
  collectCount: number
  collectionName: string
  description: string
  id: number
}[]

type Props = {
  articleId: number
}

let props = defineProps<Props>()

let collectionList = ref<CollectionList>([])

onMounted(() => {
  modalHelper.afterOpen()
})

onUnmounted(() => {
  modalHelper.beforeClose()
})

const emits = defineEmits(['handleClose', 'handleAddCollect'])

//关闭本界面
const closeClick = (isCollect: boolean = false) => {
  emits('handleClose', isCollect)
}

//新建收藏夹
const newCollection = () => {
  emits('handleAddCollect')
}

const getCollectionList = async () => {
  let res = await collectionListApi()
  collectionList.value = res.data
  console.log(res.data)
}

getCollectionList()

let selectList = []

const selectCollection = (id: number) => {
  //判断id 是否存在
  let isexist = selectList.every((item) => {
    if (item == id) {
      return false
    } else {
      return true
    }
  })

  if (isexist) {
    //不存在添加
    selectList.push(id)
  } else {
    //存在删除
    selectList = selectList.filter((item) => {
      return item != id
    })
  }
  console.log(selectList)
}

const submit = async () => {
  if (selectList.length <= 0) {
    ElMessage({
      message: '选择不能为空',
      type: 'warning'
    })
    return
  }

  //
  let res: any = await insertCollect(selectList, props.articleId)

  ElMessage({
    message: '收藏成功！',
    type: 'success'
  })
  console.log(res)

  closeClick(true) //关闭界面
}
</script>

<style scoped lang="scss">
.collection {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;

  display: flex;
  justify-content: center;

  .wrapper {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-color: rgba(18, 18, 18, 0.65);
    -webkit-transition: background-color 0.3s ease-out;
    transition: background-color 0.3s ease-out;
    z-index: 100;
  }

  .collectionForm {
    width: 450px;
    height: 450px;
    background-color: #fff;
    position: fixed;

    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);

    padding: 15px;
    box-sizing: border-box;
    z-index: 101;

    .header {
      h1,
      h6 {
        text-align: center;
      }

      h1 {
        font-size: 18px;
      }
      h6 {
        margin-top: 5px;
        font-size: 12px;
        font-weight: 100;
        color: var(--theme-text6-color);
      }
      .close {
        position: absolute;
        top: 15px;
        right: 15px;
        font-size: 16px;
        color: var(--theme-text6-color);
        cursor: pointer;
      }
    }
    .content {
      height: 345px;
      overflow: auto;
      .collectionItem {
        display: flex;
        justify-content: space-between;
        height: 60px;
        align-items: center;
        border-bottom: 1px solid var(--theme-border3-color);

        .item-left {
          height: 100%;
          display: flex;
          flex-direction: column;
          justify-content: space-evenly;

          .collectionCount {
            font-size: 12px;
            color: var(--theme-text4-color);
          }
        }
        .item-right {
          input {
            width: 15px;
            height: 15px;
            cursor: pointer;
            margin-right: 15px;
          }
        }
      }
    }
    .footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: var(--theme-text5-color);
      span {
        display: flex;
        align-items: center;
        color: var(--theme-text5-color);
        cursor: pointer;
      }
    }
  }
}
</style>
