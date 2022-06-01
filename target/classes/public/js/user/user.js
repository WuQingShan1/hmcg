layui.use(['table','layer'],function(){
    var layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        table = layui.table;
    /**
     * 用户列表展示
     */
    var  tableIns = table.render({
        elem: '#userList',
        url : ctx + '/user/list',
        cellMinWidth : 95,
        page : true,
        height : "full-125",
        limits : [10,15,20,25],
        limit : 10,
        toolbar: "#toolbarDemo",
        id : "userListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: "id", title:'编号',fixed:"true", width:80},
            {field: 'userName', title: '用户名', minWidth:50, align:"center"},
            {field: 'email', title: '用户邮箱', minWidth:100, align:'center'},
            {field: 'phone', title: '用户电话', minWidth:100, align:'center'},
            {field: 'trueName', title: '真实姓名', align:'center'},
            {field: 'createDate', title: '创建时间', align:'center',minWidth:150},
            {field: 'updateDate', title: '更新时间', align:'center',minWidth:150},
            {title: '操作', minWidth:150, templet:'#userListBar',fixed:"right",align:"center"}
        ]]
    });

    $(".search_btn").click(function () {
        tableIns.reload({
            where:{
                userName:$("[name='customerName']").val(),
                email:$("[name='createMan']").val(),
                phone:$("#state").val()
            },page:{
                curr:1   //重新从第一页开始
            }
        })
    })
    table.on('toolbar(users)',function(data){
        var checkStatus = table.checkStatus(data.config.id)
        if (data.event=="add"){
            openAddOrUpdateUserDialog()
        }else if(data.event=="del"){
            deleteUser(checkStatus.data)
        }
    })
    function deleteUser(data){
        var ids ="ids="
        if (data==null){
            layer.msg("请选择要删除的记录",{icon:5})
            return
        }else {
            layer.confirm("确定要删除这条记录嘛",{icon:3,title:"用户记录数据"},function (index) {
                layer.close(index)
                if (data.length==null){
                    ids += data
                }
                for (var i=0;i<data.length;i++){
                    if (i<data.length-1){
                        ids+=data[i].id+"&ids="
                    }else{
                        ids+=data[i].id
                    }
                    console.log(ids)
                }
                $.ajax({
                    type:"post",
                    url:ctx + "/user/delete",
                    data:ids,
                    success:function(data){
                        if (data.code==200){
                            layer.msg("删除成功",{icon:6})
                            tableIns.reload()
                        }else{
                            layer.msg(data.msg,{icon:5})
                        }
                    }
                })
            })
        }
    }
    table.on('tool(users)',function(data){
        if (data.event=="edit"){
            openAddOrUpdateUserDialog(data.data.id)
        }if (data.event=="del"){
            deleteUser(data.data.id)
        }
    })
    function  openAddOrUpdateUserDialog(userId) {
        var title="用户管理-添加用户"
        var url =ctx +"/user/toAddOrUpdateUserPage"
        if (userId!=null&&userId!=""){
            console.log("------------")
            console.log(userId)
            console.log("------------")
            title:"用户管理-更新用户"
            url += "?userId="+userId
        }
        layui.layer.open({
            title:title,
            type:2,
            area:["750px","550px"],
            maxmin:true,
            content:url
        })
    }
});