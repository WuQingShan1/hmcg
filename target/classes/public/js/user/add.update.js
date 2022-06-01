layui.use(['form', 'layer','formSelects'], function () {
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;
    var formSelects =layui.formSelects
    form.on('submit(addOrUpdateUser)',function (data) {
        var url = ctx +"/user/add"
        var userId =$("[name='id']").val()
        if(userId!=null&& userId!=""){
            url=ctx +"/user/update"
        }
        $.ajax({
            type:"post",
            url:url,
            data:data.field,
            success:function (result) {
                if (result.code==200){
                    layer.msg("操作成功",{icon:6})
                    layer.closeAll("iframe")
                    parent.location.reload()
                }else{
                    layer.msg(result.msg,{icon:5})
                }
            }
        })
        return false
    })
    form.on('submit(close)',function (data) {
        console.log("关闭")
        layer.msg("操作取消",{icon:5})

        layer.closeAll("iframe")
        parent.location.reload()
        return false
    })
    /**
     * 加载角色下拉框
     */
    formSelects.config("selectId",{
        type:"post",
        searchUrl:ctx + "/role/queryAllRoles?id="+$('[name="id"]').val(),
        keyName:"roleName",
        keyVal:"id"
    },true)
});