<template>
  <div class="write">
    <div class="write_top">
      <el-form ref="form" :model="article" label-width="90px">
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="文章标题" prop="title">
            <el-input
              v-model="article.title"
              placeholder="请输入文章标题"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="分类">
            <el-select v-model="article.categoryId" placeholder="请选择">
              <el-option
                v-for="category in categoryList"
                :key="category.id"
                :label="category.name"
                :value="category.id"
              />
   
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="标签">
            <el-select v-model="article.tags" placeholder="请选择" multiple>
              <el-option
                v-for="tag in tagList"
                :key="tag.id"
                :label="tag.name"
                :value="tag.id"
              />
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="文章摘要">
            <el-input v-model="article.summary" type="textarea" />
          </el-form-item>
        </el-col>
         <el-col :span="6">
          <el-form-item label="允许评论">
            <el-radio-group v-model="article.isComment">
              <el-radio :key="'0'" :label="'0'">停用</el-radio>
              <el-radio :key="'1'" :label="'1'">正常</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="是否置顶">
            <el-radio-group v-model="article.isTop">
              <el-radio :key="'0'" :label="'0'">否</el-radio>
              <el-radio :key="'1'" :label="'1'">是</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>

      </el-row>
      <el-row :gutter="20" />

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="缩略图">
            <el-upload
              :file-list="fileList"
              class="upload-demo"
              list-type="picture"
              drag
              name="img"
              action="upload"
              :on-remove="fileRemove"
              :limit="1"
              :http-request="handleUpload"
              :on-exceed="onExceed"
            >
              <i class="el-icon-upload" />
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
              <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
            </el-upload>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item>
            <el-button type="primary" size="medium" @click="handleSubmit">{{ aId?"更新":"发布" }}</el-button>
          </el-form-item>
          <el-form-item>
            <el-button v-if="!aId" type="info" @click="handleSave">保存到草稿箱</el-button>
          </el-form-item>

        </el-col>
      </el-row>
      <el-row>
        <mavon-editor ref="md" v-model="article.content" @imgAdd="addImg" style="width: 100%; height: 480px;"/>
      </el-row>
    </el-form>
  </div>
   

  </div>





</template>

<script lang='ts' setup name="writeView">
import {reactive, ref, watchEffect,shallowRef,onMounted,onBeforeUnmount } from 'vue'
import {useRoute} from 'vue-router'



const route=useRoute();

//上传文章
interface articleInfo {
  title:string,
  content:string,
  summary:string,
  categoryId:string,
  thumbnail:string,
  isTop:'0' | '1', //0否 1是 
  status:'0' |'1',  // 0发布 1 草稿
  isComment:'0' |'1', // 0否 1 是
  tags:[]
}

let article=reactive<articleInfo>({
  title:null,
  content:null,
  summary:null,
  categoryId:null,
  thumbnail:null,
  isTop:'0',
  status:null,
  isComment: '1',
  tags:[]
})


//分类列表
let categoryList = reactive([])

//标签列表
let tagList=reactive([])

//文章id 有说明是更新 ，没有说明是发布
let aId=ref(null)

//存储图片
let fileList=reactive([])

//移除图片
const fileRemove=()=>{
  fileList.pop()
}

//上传图片
const handleUpload=()=>{

}

//提交文章
const handleSubmit=()=>{

}

//保存到草稿箱
const handleSave=()=>{

}

//
const addImg=()=>{

}

watchEffect(()=>{
  
  aId.value=route.query && route.query.id;

 })

//超过限制
const onExceed=()=>{
  ElMessage(route,{
    showClose: true,
    message: '图片个数超过限制！',
    type: 'warning',
  })
}




</script>

<style scoped lang='less'>

  .write{
    width: 100%;
    height: 100%;
    background-color: #fff;
    box-sizing: border-box;
    padding: 12px;

  }

  .el-col .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;

    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
  
</style>