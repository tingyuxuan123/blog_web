<template>
  <div class="menu">
    <el-form :model="queryParams">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-form-item label="菜单名称">
            <el-input placeholder="请输入菜单名" v-model="queryParams.menuName"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="5">
          <el-form-item label="状态">
            <el-select v-model="queryParams.visible" placeholder="请选择">
              <el-option label="正常" :value="0" />
              <el-option label="禁用" :value="1" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="4">
          <el-button type="primary" :icon="Search">搜索</el-button>
          <el-button :icon="RefreshLeft">重置</el-button>
        </el-col>
      </el-row>

      <el-row :gutter="0">

        <el-button :icon="Plus" type="primary" plain @click="handleAdd">新增</el-button>
        <!-- <el-button :icon="Delete" type="danger" plain>删除</el-button> -->
        <!-- <el-button :icon="Download" type="warning" plain>导出</el-button> -->

      </el-row>

      <el-row style="margin-top: 20px;">
        <el-table :data="menuList" style="width: 100%"  
        v-loading="loading"

        row-key="id"
        :default-expand-all="false" 
        :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
        >
          <el-table-column prop="menuName" label="菜单名称" :show-overflow-tooltip="true" width="160" />
          <el-table-column prop="icon" label="图标" align="center" width="100">
            <template #default="scope">
              <svg-icon :icon-class="scope.row.icon" />
            </template>
          </el-table-column>
          <el-table-column prop="orderNum" label="排序" width="60" />
          <el-table-column prop="perms" label="权限标识" :show-overflow-tooltip="true" />
          <el-table-column prop="component" label="组件路径" :show-overflow-tooltip="true" />
          <el-table-column prop="status" label="状态" width="80">
            <template #default="scope">
              <el-tag v-if="scope.row.status==0" type="success">正常</el-tag>
              <el-tag v-if="scope.row.status==1" type="danger">停用</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="创建时间" align="center" prop="createTime">
            <template #default="scope">
              <span>{{ scope.row.createTime }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                  <template #default="scope">
                    <el-button
                      size="mini"
                      type="text"
                      icon="Edit"
                      @click="handleUpdate(scope.row)"
                    >修改</el-button>
                    <el-button
                      size="mini"
                      type="text"
                      icon="Plus"
                      @click="handleAdd(scope.row)"
                    >新增</el-button>
                    <el-button
                      size="mini"
                      type="text"
                      icon="Delete"
                      @click="handleDelete(scope.row)"
                    >删除</el-button>
                  </template>
                </el-table-column>
        </el-table>
      </el-row>
    </el-form>

        <!-- 添加或修改菜单对话框 -->
    <el-dialog :title="title" v-model="open" width="680px" append-to-body>
      <el-form  :model="form" label-width="100px" :rules="rules">
        <el-row>
          <el-col :span="24">
            <el-form-item label="上级菜单">
              <!-- <treeselect
                v-model="form.parentId"
                :options="menuOptions"
                :normalizer="normalizer"
                :show-count="true"
                placeholder="选择上级菜单"
              /> -->
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="菜单类型" prop="menuType">
              <el-radio-group v-model="form.menuType">
                <el-radio label="M">目录</el-radio>
                <el-radio label="C">菜单</el-radio>
                <el-radio label="F">按钮</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item v-if="form.menuType != 'F'" label="菜单图标">
              <!-- <IconSelect ref="iconSelect" @selected="selected" /> -->
              <el-select
                v-model="form.icon"
                placeholder="图标"
                clearable
                size="small"
                style="width: 240px"
              >
                <!-- <el-option v-for="(item, index) in icons" :key="index" :value="item">
                  <svg-icon :icon-class="item" />
                  <span>{{ item }}</span>
                </el-option> -->

              </el-select>

            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="菜单名称" prop="menuName">
              <el-input v-model="form.menuName" placeholder="请输入菜单名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="orderNum">
              <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item v-if="form.menuType != 'F'" prop="path" label="路由地址">
              <el-input v-model="form.path" placeholder="请输入路由地址" />
            </el-form-item>
          </el-col>
          <el-col v-if="form.menuType == 'C'" :span="12" >
            <el-form-item prop="component" label="组件路径">
              <el-input v-model="form.component" placeholder="请输入组件路径" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item v-if="form.menuType != 'M'" label="权限字符">
              <el-input v-model="form.perms" placeholder="请输入权限标识" maxlength="100" />
         
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item v-if="form.menuType != 'F'" label="显示状态">
              <el-radio-group v-model="form.visible">
                <el-radio :key="'0'" :label="'0'">显示</el-radio>
                <el-radio :key="'1'" :label="'1'">隐藏</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item v-if="form.menuType != 'F'" label="菜单状态">
              <el-radio-group v-model="form.status">
                <el-radio :key="'0'" :label="'0'">正常</el-radio>
                <el-radio :key="'1'" :label="'1'">停用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="">确 定</el-button>
        <el-button @click="">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import { Plus, Delete, Search, Download ,RefreshLeft} from '@element-plus/icons-vue'
import {getRouters} from "@/api/user"

let a=ref("M")

let queryParams=ref<Record<string,any>>({})  //查询条件

let form =reactive<Record<string,any>>({
        id: undefined,
        parentId: 0,
        menuName: undefined,
        icon: undefined,
        menuType: 'M',
        orderNum: undefined,
        isCache: '0',
        visible: '0',
        status: '0'
})  //添加表单


let menuList=ref<Array<Record<string,any>>>([]); //表格数据
let open=ref(false);  //是否显示弹出层
let loading=ref(true)
let title=ref("")
let rules=ref({
        menuName: [
          { required: true, message: '菜单名称不能为空', trigger: 'blur' }
        ],
        orderNum: [
          { required: true, message: '菜单顺序不能为空', trigger: 'blur' }
        ],
        path: [
          { required: true, message: '路由地址不能为空', trigger: 'blur' }
        ]
      })

//编辑
let handleUpdate=(row:any)=>{

}

//删除
let handleDelete=(row:any)=>{

}

const getRouterList=async()=>{
  loading.value=true
  const res:any=await getRouters()
  console.log(res);
  menuList.value=res.data.menus
  loading.value=false
  
}

getRouterList()

  /** 查询菜单下拉树结构 */
const getTreeselect=()=>{
   
}

const handleAdd=(row:any)=>{

  if (row != null && row.id) {
        form.parentId = row.id
      } else {
        form.parentId = 0
      }
      open.value = true
      title.value = '添加菜单'


}


</script>

<style scoped lang='less'>
  .menu{
    background-color:#fff;
    width:100%;
    height:100%;
    padding:10px;
    box-sizing: border-box;
}
</style>