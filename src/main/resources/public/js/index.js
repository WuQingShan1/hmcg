layui.use(['form','jquery','jquery_cookie'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery,
        $ = layui.jquery_cookie($);



    /**
     * 监听表单的提交
     *     on监听 submit事件
     */
        form.on('submit(login)',function (data) {
            console.log(data.field);
            var userName = data.field.username;
            var password = data.field.password;
            if (istrue(userName)){
                layer.msg("用户名不能为空",{icon:5});
                return false;
            }
            if (istrue(password)){
                layer.msg("密码不能为空",{icon:5});
                return false;
            }
            $.ajax({
                type:"post",
                url:ctx+"/user/login",
                data:{
                    userName:userName,
                    userPwd:password
                },
                success:function (data) {
                   console.log(data)
                    if (data.code==200){
                        layer.msg("登录成功",{icon:6})
                        $.cookie("userIdStr",data.result.userIdStr)
                        $.cookie("userName",data.result.userName)
                        $.cookie("trueName",data.result.trueName)

                       if ($("#rememberMe").prop("checked")) {
                           $.cookie("userIdStr",data.result.userIdStr,{expires:7})
                           $.cookie("userName",data.result.userName,{expires:7})
                           $.cookie("trueName",data.result.trueName,{expires:7})
                       }

                        window.setTimeout(function () {
                            console.log(ctx)
                            window.location.href=ctx+"/main"
                        },3000)
                    }else {
                         layer.msg(data.msg,{icon:5})
                    }
                }
            })
                return false;
        })

function istrue(str) {
    if (str == null || str.trim() == "") {
        return true;
    }
    return false;
}
})