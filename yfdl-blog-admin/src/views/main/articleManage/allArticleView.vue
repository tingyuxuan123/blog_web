<template>
  <div class="allArticle">
    <el-form :model="form">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-form-item label="关键词">
            <el-input placeholder="请输入分类名" v-model="form.name"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="4">
          <el-form-item label="文章状态">
            <el-select v-model="form.status" placeholder="请选择文章状态">
              <el-option label="正常" :value="0" />
              <el-option label="禁用" :value="1" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="5">
          <el-form-item label="分类目录">
            <el-select v-model="form.categoryId" placeholder="请选择">
              <el-option label="正常" value="0" />
              <el-option label="禁用" value="1" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="5">
          <el-form-item label="标签目录">
            <el-select v-model="form.spanId" placeholder="请选择">
              <el-option label="正常" value="0" />
              <el-option label="禁用" value="1" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="4">
          <el-button type="primary" :icon="Search">查询</el-button>
          <el-button :icon="RefreshLeft">重置</el-button>
        </el-col>
      </el-row>

      <el-row :gutter="0">

        <el-button :icon="Plus" type="primary" plain @click="">添加</el-button>
        <el-button :icon="Delete" type="danger" plain>回收站</el-button>


      </el-row>

      <el-row style="margin-top: 20px;">
        <el-table :data="articleList" height="250" style="width: 100%">
          <el-table-column type="selection" width="50" />
          <el-table-column prop="title" label="标题" />
          <el-table-column prop="name" label="状态" />
          <el-table-column prop="categoryName" label="分类" />
          <el-table-column prop="address" label="标签" />
          <el-table-column prop="address" label="分类" />
          <el-table-column prop="commentCount" label="评论" width="100px" />
          <el-table-column prop="viewCount" label="访问"  width="100px"  />
          <el-table-column prop="createTime" label="发布时间" />
          <el-table-column label="操作">
            <template #default="scope">
              <el-button size="small" @click="handleEdit(scope.$index,scope.row)">
                编辑
              </el-button>
              <el-button size="small" type="danger" @click="handleDelete(scope.$index, scope.row)">Delete
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-row>

      <el-row>
        <div class="pagination-block">
          <el-pagination :currentPage="pageinfo.currentPage" :page-size="pageinfo.pageSize" :page-sizes="[10, 20, 30, 40]"
            layout="total, sizes, prev, pager, next, jumper" :total="total" @size-change="handleSizeChange"
            @current-change="handleCurrentChange" />
        </div>
      </el-row>

    </el-form>

  </div>
</template>

<script lang='ts' setup name="allArticleView">
import { reactive, ref } from 'vue'
import { Plus, Delete, Search, Download, RefreshLeft } from '@element-plus/icons-vue'
import {queryArticleList} from '@/api/article'

let articleList = ref([]);

let pageinfo=reactive({
  currentPage:1,
  pageSize:10
})

let total=ref(0)

const form = reactive<{
  title: string,
  status: '0' | '1' | '',
  categoryId: number,
  spanId: number
}>({
  title: "",
  status: "",
  categoryId: null,
  spanId: null
})

const queryAll=async ()=>{

 const res= await queryArticleList(form,pageinfo);
 articleList.value=res.data.rows;
 total.value=res.data.total
 console.log(articleList);
  
}
//开始执行一次获取全部文章
queryAll()

//编辑
let handleEdit = (index: any, row: any) => {

}

//删除
let handleDelete = (index: any, row: any) => {

}

//一页显示数量改变
const handleSizeChange = (val: number) => {
  console.log(`${val} items per page`)
}

//当前页改变
const handleCurrentChange = (val: number) => {
  console.log(`current page: ${val}`)
}

</script>

<style scoped lang='less'>

.allArticle{
  width: 100%;
  height: 100%;
  background-color: #fff;
  padding: 20px;
  box-sizing: border-box;
}

.pagination-block{
  margin-top: 15px;
}

</style>