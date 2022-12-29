<template>
  <div class="collect">
    <div class="header" v-if="collections.length > 0">
      <span class="collectionCount">收藏集数{{ collections.length }}</span>
      <NeedAuth :id="props.id">
        <div class="addCollectionBtn">
          <svg
            viewBox="64 64 896 896"
            data-icon="plus"
            width="1em"
            height="1em"
            fill="currentColor"
            aria-hidden="true"
            focusable="false"
            class=""
          >
            <path
              d="M482 152h60q8 0 8 8v704q0 8-8 8h-60q-8 0-8-8V160q0-8 8-8z"
            ></path>
            <path
              d="M176 474h672q8 0 8 8v60q0 8-8 8H176q-8 0-8-8v-60q0-8 8-8z"
            ></path>
          </svg>
          <span @click="isVisibleAddCollect = true">新建收藏集</span>
        </div>
      </NeedAuth>
    </div>
    <el-empty v-else description="暂无数据" />

    <div class="content">
      <ul>
        <li class="collect-item" v-for="item in collections" :key="item.id">
          <div class="item-top">
            {{ item.collectionName }}
          </div>
          <div class="item-description" v-if="item.description">
            {{ item.description }}
          </div>
          <div class="item-bottom">
            <span> {{ item.collectCount }}篇文章 </span>
            <NeedAuth :id="props.id">
              <div class="item-bottom-right">
                <span @click="collectionEdit(item)"
                  ><el-icon>
                    <EditPen />
                  </el-icon>
                  编辑</span
                >
                <span>
                  <el-icon>
                    <DeleteFilled />
                  </el-icon>
                  <el-popconfirm
                    width="220"
                    confirm-button-text="是"
                    cancel-button-text="否"
                    icon-color="#626AEF"
                    title="你要删除这个收藏集吗?"
                    @confirm="deleteCollection(item.id)"
                  >
                    <template #reference> 删除 </template>
                  </el-popconfirm>
                </span>
              </div>
            </NeedAuth>
          </div>
        </li>
      </ul>
    </div>

    <Teleport to="#model">
      <AddCollect
        v-if="isVisibleAddCollect"
        @handleClose="closeAddCollection"
      ></AddCollect>
      <UpdateCollect
        v-if="isVisibleUpdateCollect"
        @handle-close="closeUpdateCollection"
        :collection="needUpdateCollection"
      ></UpdateCollect>
    </Teleport>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref, onMounted } from 'vue'
import { collectionListApi, deleteCollectionApi } from '@/api/collection'
import AddCollect from '@/components/collection/AddCollect.vue'
import UpdateCollect from '@/components/collection/UpdateCollect.vue'
import { ElMessage } from 'element-plus'
import NeedAuth from '@/components/common/NeedAuth.vue'

type Props = {
  id: number
}

type Collection = {
  id: number
  collectCount: number
  collectionName: string
  description: string
  isVisible: number
}

const props = defineProps<Props>()
console.log(props.id)

const collections = ref<Collection[]>([])

const isVisibleAddCollect = ref(false)
const isVisibleUpdateCollect = ref(false)

//要传入修改收藏夹的数据
const needUpdateCollection = reactive<Collection>({
  id: null,
  collectCount: null,
  collectionName: null,
  description: null,
  isVisible: 0
})

const getCollectionList = async () => {
  let res = await collectionListApi(props.id)
  collections.value = res.data

  console.log(collections.value)
}

onMounted(() => {
  //获取用户的收藏集
  getCollectionList()
})

const closeAddCollection = () => {
  isVisibleAddCollect.value = false
  getCollectionList()
}

const closeUpdateCollection = () => {
  isVisibleUpdateCollect.value = false
  getCollectionList()
}

//删除收藏集
const deleteCollection = async (id: number) => {
  let res: any = await deleteCollectionApi(id)
  if (res.code === 200) {
    ElMessage({
      type: 'success',
      message: '收藏集删除成功'
    })
    getCollectionList()
  } else {
    ElMessage({
      type: 'warning',
      message: '删除失败请稍后再试'
    })
  }
}

const collectionEdit = (Collection: Collection) => {
  isVisibleUpdateCollect.value = true
  needUpdateCollection.id = Collection.id
  needUpdateCollection.collectionName = Collection.collectionName
  needUpdateCollection.description = Collection.description
  needUpdateCollection.isVisible = Collection.isVisible
  console.log(Collection)
}
</script>

<style scoped lang="scss">
.collect {
  padding: 0px 5px;
}

.header {
  display: flex;
  justify-content: space-between;
  padding: 0 10px;

  span,
  svg {
    color: #1f82ff;
    vertical-align: middle;
  }

  .collectionCount {
    margin-top: 15px;
    padding: 5px 10px;
    background-color: #eaf2ff;
    border-radius: 16px;
  }

  .addCollectionBtn {
    cursor: pointer;
  }
}

.content {
  .collect-item {
    padding: 5px 15px;
    border-bottom: 1px solid var(--theme-border1-color);
    cursor: pointer;

    .item-top {
      font-weight: bold;
      margin: 5px 0px;
      color: #252933;
    }

    .item-bottom {
      display: flex;
      justify-content: space-between;
      font-size: 14px;
      margin: 10px 0px;

      .item-bottom-right {
        span {
          margin-left: 20px;
          vertical-align: middle;
          color: var(--theme-text3-color);
          visibility: hidden;

          &:hover {
            color: #1f82ff;
          }
        }
      }
    }

    &:hover .item-bottom-right span {
      visibility: visible;
    }
  }
}
</style>
