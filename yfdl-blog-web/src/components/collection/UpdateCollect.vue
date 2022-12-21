<template>
  <div class="addCollect">
    <div class="wrapper">
      <div class="addCollectForm">
        <div class="header">
          <h1 class="title">修改收藏夹</h1>

          <div class="close" @click="closeClick">
            <el-icon>
              <Close />
            </el-icon>
          </div>
        </div>
        <div class="content">
          <div class="collect_name">
            <label for="">名称：</label>
            <input
              type="text"
              placeholder="请输入收藏夹名称"
              v-model="collectionForm.collectionName"
            />
          </div>
          <div class="collect_description">
            <label for="">描述：</label>
            <textarea
              type="text"
              placeholder="请输入收藏描述（限100字,选填）"
              rows="10"
              v-model="collectionForm.description"
            >
            </textarea>
          </div>
          <div class="collect_isVisible">
            <!-- <label for="">是否显示：</label> -->
            <el-radio-group v-model="collectionForm.isVisible" class="ml-4">
              <el-radio :label="0" size="large">公开 </el-radio>
              <el-radio :label="1" size="large">隐藏</el-radio>
            </el-radio-group>
          </div>
        </div>
        <div class="footer">
          <el-button plain type="primary" @click="closeClick">取消</el-button>
          <el-button type="primary" @click="submit">确定</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, onMounted, onUnmounted } from 'vue'
import modalHelper from '@/utils/modalHelper'
import { ElMessage } from 'element-plus'
import { updateCollectionApi } from '@/api/collection'

type Collection = {
  id: number
  collectionName: string
  description: string
  isVisible: number
}

type Props = {
  collection: Collection
}

const props = defineProps<Props>()

const collectionForm = reactive<Collection>({ ...props.collection })

onMounted(() => {
  modalHelper.afterOpen()
})

onUnmounted(() => {
  modalHelper.beforeClose()
})

const emits = defineEmits(['handleClose'])

//关闭本界面
const closeClick = () => {
  emits('handleClose')
}

//提交添加
const submit = async () => {
  //判断收藏夹名称为不为空
  if (
    collectionForm.collectionName == undefined ||
    collectionForm.collectionName == ''
  ) {
    ElMessage({
      message: '收藏夹不为空',
      type: 'warning'
    })
    return
  }

  //提交请求
  let res: any = await updateCollectionApi(collectionForm)
  console.log(res)

  if (res.code === 200) {
    ElMessage({
      type: 'success',
      message: '收藏集修改成功！'
    })
  }

  closeClick()
}
</script>

<style scoped lang="scss">
.addCollect {
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

  .addCollectForm {
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
      h1 {
        text-align: center;
        font-size: 18px;
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
      display: flex;
      flex-direction: column;
      padding-top: 20px;

      label {
        font-size: 12px;
        margin-top: 8px;
      }

      .collect_name {
        display: flex;

        input {
          flex: 1;
          background-color: var(--theme-bg1-color);
          outline: none;
          border: none;
          border-radius: 5px;
          height: 35px;
          padding-left: 8px;
          box-sizing: border-box;

          &::placeholder {
            font-size: 12px;
          }
        }
      }

      .collect_description {
        display: flex;
        margin-top: 15px;

        textarea {
          flex: 1;
          background-color: var(--theme-bg1-color);
          outline: none;
          border: none;
          border-radius: 5px;

          padding: 8px;

          box-sizing: border-box;
        }
      }

      .collect_isVisible {
        display: flex;
        justify-content: center;
        margin-top: 10px;
      }
    }

    .footer {
      position: absolute;
      right: 20px;
      bottom: 20px;
    }
  }
}
</style>
