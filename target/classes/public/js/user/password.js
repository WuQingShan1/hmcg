layui.use(['form','jquery','jquery_cookie'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery,
        $ = layui.jquery_cookie($);

    form.on('submit(saveBtn)',function (data) {

        var field = data.field
        console.log(field)
        console.log(ctx+"/user/updateUserPwd")
        $.ajax({
            type:"post",
            url:ctx+"/user/updateUserPwd",
            data:{
                oldPwd:field.old_password,
                newPwd:field.new_password,
                repeatPwd:field.again_password
            },
            success:function(data){
                console.log("ckkkkkkk")
                if (data.code==200){
                    layer.msg("用户密码修改成功，系统将在三秒后退出",function () {
                        $.removeCookie("userIdStr",{domain:"localhost",path:"/crm"})
                        $.removeCookie("userName",{domain:"localhost",path:"/crm"})
                        $.removeCookie("trueName",{domain:"localhost",path:"/crm"})
                        window.parent.location.href=ctx+"/index";
                    })

                }else{
                    layer.msg(data.msg,{icon:5})
                }
            }
        })
        return false
    })

})