<template>
  <div class="user">

<el-form :model="queryParams">
  <el-row :gutter="20">
    <el-col :span="6">
      <el-form-item label="用户名称">
        <el-input placeholder="请输入用户名称" v-model="queryParams.roleName"></el-input>
      </el-form-item>
    </el-col>
    <el-col :span="5">
      <el-form-item label="手机号码">
        <el-input placeholder="请输入手机号码" v-model="queryParams.phonenumber"></el-input>
      </el-form-item>
    </el-col>
    <el-col :span="5">
      <el-form-item label="状态">
        <el-select v-model="queryParams.status" placeholder="请选择">
          <el-option label="正常" :value="0" />
          <el-option label="禁用" :value="1" />
        </el-select>
      </el-form-item>
    </el-col>
    <el-col :span="4">
      <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
      <el-button :icon="RefreshLeft" @click="handleReset">重置</el-button>
    </el-col>
  </el-row>

  <el-row :gutter="0">

    <el-button :icon="Plus" type="primary" plain @click="addViewVisible=!addViewVisible">添加</el-button>
    <el-button :icon="Delete" type="danger" plain>删除</el-button>
    <!-- <el-button :icon="Download" type="warning" plain>导出</el-button> -->

  </el-row>

  <el-row style="margin-top: 20px;">
    <el-table :data="roleList" height="250" style="width: 100%"
    
    v-loading="loading"
    row-key="id"
    >
      <el-table-column type="selection" width="100" />
      <el-table-column align="center" prop="id"  label="角色编号" width="100" />
      <el-table-column align="center" prop="userName" label="角色名称" />
      <el-table-column align="center" prop="nickName" label="用户昵称"  />
      <el-table-column align="center" prop="phonenumber" label="手机号码"  />
      <el-table-column align="center" prop="status" label="状态" >
        <template #default="scope">
            <el-switch v-model="scope.row.status" active-value="0" inactive-value="1"/>
        </template>
      </el-table-column>
      <el-table-column align="center" prop="createTime" label="创建时间"  />
      <el-table-column align="center" label="操作"  class-name="small-padding fixed-width">
                  <template #default="scope">
                    <el-button
                      size="small"
                      type="primary"
                      text
                      icon="Edit"
                      @click="handleUpdate(scope.row)"
                    >修改</el-button>
                    <el-button
                      size="small"
                      type="primary"
                      text
                      icon="Delete"
                      @click="handleDelete(scope.row)"
                    >删除</el-button>
                  </template>
                </el-table-column>
    </el-table>
  </el-row>
  
  <el-row>
      <div class="pagination-block">
        <el-pagination
          :currentPage="1"
          :page-size="10"
          :page-sizes="[10, 20, 30, 40]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pageInfo.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
  </el-row>

</el-form>

<el-dialog v-model="addViewVisible" title="添加分类" style="width: 600px;">
<el-form :model="form">
  <el-form-item label="分类名" label-width="60px">
    <el-input v-model="form.name" />
  </el-form-item>
  <el-form-item label="描述" label-width="60px">
    <el-input v-model="form.name"  type="textarea" :rows="5" />
  </el-form-item>
</el-form>
<template #footer>
  <span class="dialog-footer">
    <el-button @click="addViewVisible=false">取消</el-button>
    <el-button type="primary" @click="addRole">添加</el-button>
  </span>
</template>
</el-dialog>

</div>
</template>

<script lang='ts' setup name="role">
import { Plus, Delete, Search, Download ,RefreshLeft} from '@element-plus/icons-vue'
import {reactive, ref} from 'vue'
import {getUserList} from '@/api/user'

let queryParams=ref<Record<string,any>>({
    currentPage:1,
    pageSize:10
})  //查询条件
let addViewVisible=ref(false);
let roleList=ref<{[key:string]:any,}[]>([])
let loading=ref(false)
let pageInfo=reactive({
    total:0
})

//编辑
let handleUpdate=(row:any)=>{

}

//删除
let handleDelete=(row:any)=>{

}

const handleSearch=()=>{
  getuserList();
}

const handleReset=()=>{
queryParams.value.phonenumber=undefined
queryParams.value.roleName=undefined
queryParams.value.status=undefined
getuserList()
}

const getuserList=async()=>{ //获取角色列表
loading.value=true
const res=await getUserList(queryParams.value)
pageInfo.total=res.data.total
roleList.value=res.data.rows


loading.value=false;
}

getuserList();

const addRole=()=>{

}

//一页显示数量改变
const handleSizeChange = (val: number) => {
 // console.log(`${val} items per page`)
}

//当前页改变
const handleCurrentChange = (val: number) => {
 // console.log(`current page: ${val}`)
}






</script>

<style scoped lang='less'>
  .user {
  background: #fff;
  width: 100%;
  height: 100%;
  padding: 15px;
  box-sizing: border-box;
}

</style>