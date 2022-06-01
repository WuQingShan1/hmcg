package com.yjxxt.crm.service;


import com.yjxxt.crm.base.BaseService;
import com.yjxxt.crm.dao.UserMapper;
import com.yjxxt.crm.model.UserModel;
import com.yjxxt.crm.utils.AssertUtil;
import com.yjxxt.crm.utils.Md5Util;
import com.yjxxt.crm.utils.PhoneUtil;
import com.yjxxt.crm.utils.UserIDBase64;
import com.yjxxt.crm.vo.User;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class UserService extends BaseService<User,Integer> {

    @Resource
    private UserMapper userMapper;


    public UserModel loginCheck(String userName ,String userPwd){
        //校验参数是否为空
        checkLoginData(userName,userPwd);
        //调用dao层查询通过用户名查询数据库数据，判断账号是否存在
        User user = userMapper.queryUserByName(userName);
        AssertUtil.isTrue(user == null,"账号不存在");
        //校验前台传来的密码和数据库中的密码是否一致 (前台密码加密后再校验)
        checkLoginPwd(user.getUserPwd(),userPwd);
        //封装ResultInfo对象给前台（根据前台需求：usermodel对象封装后传到前台使用）
        UserModel userModel = buildResultInfo(user);
        return userModel;
    }


    /** 修改密码
     */
    public void userUpdate(Integer userId,String oldPassword,String newPassword,String confirmPassword){
        //确保用户是否是登录状态获取cookie中的id 非空 查询数据库
        AssertUtil.isTrue(userId == null,"用户未登录");
        User user = userMapper.selectByPrimaryKey(userId);
        AssertUtil.isTrue(user == null,"用户状态异常");
        //校验密码数据
        checkUpdateData(oldPassword,newPassword,confirmPassword,user.getUserPwd());
        // 执行修改操作，返回ResultInfo
        user.setUserPwd(Md5Util.encode(newPassword));
        user.setUpdateDate(new Date());
        //判断是否修改成功
        AssertUtil.isTrue(userMapper.updateByPrimaryKey(user.getUserPwd(),userId) < 1,"密码修改失败");
    }


    /**密码校验
     * @param oldPassword
     * @param newPassword
     * @param confirmPassword
     * @param
     */
    private void checkUpdateData(String oldPassword, String newPassword, String confirmPassword, String dbPassword) {
        System.out.println("原始密码"+Md5Util.encode(oldPassword));
        System.out.println("数据库密码"+dbPassword);
        //校验老密码  非空  老密码必须要跟数据库中密码一致
        AssertUtil.isTrue(StringUtils.isBlank(oldPassword),"原始密码不存在");
        AssertUtil.isTrue(!dbPassword.equals(Md5Util.encode(oldPassword)),"原始密码错误");

        //新密码    非空  新密码不能和原密码一致
        AssertUtil.isTrue(StringUtils.isBlank(newPassword),"新密码不能为空");
        AssertUtil.isTrue(oldPassword.equals(newPassword),"新密码不能和原密码一致");

        //确认密码  非空  确认必须和新密码一致
        AssertUtil.isTrue(StringUtils.isBlank(confirmPassword),"确认密码不能为空");
        AssertUtil.isTrue(!confirmPassword.equals(newPassword),"确认密码必须和新密码一致");

    }


    /**
     * 准备前台cookie需要的数  usermodel
     * @param user
     */
    private UserModel buildResultInfo(User user) {
        //封装userMdel  cookie需要的数据
        UserModel userModel = new UserModel();
        //将userid加密
        String id = UserIDBase64.encoderUserID(user.getId());
        userModel.setUserIdStr(id);
        userModel.setUserName(user.getUserName());
        userModel.setTrueName(user.getTrueName());

        return userModel;
    }


    /**
     * 校验前台传来的密码和数据库中的密码是否一致 (前台密码加密后再校验)
     */
    private void checkLoginPwd(String dbPwd, String userPwd) {
        //将传来的密码加密再校验
        String encodePwd = Md5Util.encode(userPwd);
        //校验
        AssertUtil.isTrue(!encodePwd.equals(dbPwd),"用户密码错误");
    }

    /**
     * 用户登录参数非空校验
     * @param userName
     * @param userPwd
     */
    private void checkLoginData(String userName, String userPwd) {
        AssertUtil.isTrue(StringUtils.isBlank(userName),"用户名不能为空");
        AssertUtil.isTrue(StringUtils.isBlank(userPwd),"用户密码不能为空");
    }

    /**
     * 查询销售人员
     * @return
     */
    public List<Map<String,Object>> queryAllSales(){
        return userMapper.queryAllSales();
    }



    private void checkUserParams(User user) {
        AssertUtil.isTrue(StringUtils.isBlank(user.getUserName()),"用户名不能为空");
        User temp = userMapper.queryUserByName(user.getUserName());
       if (user.getId()==null){
           AssertUtil.isTrue(temp!=null,"用户名已存在请重新输入");
       }else{
           AssertUtil.isTrue(temp!=null&&!(user.getId().equals(temp.getId())),"用户名已存在请重新输入");

       }
        AssertUtil.isTrue(StringUtils.isBlank(user.getTrueName()),"真实姓名不能为空");
        AssertUtil.isTrue(StringUtils.isBlank(user.getEmail()),"邮箱不能为空");
        AssertUtil.isTrue(StringUtils.isBlank(user.getPhone()),"手机号不能为空");
        AssertUtil.isTrue(!PhoneUtil.isMobile(user.getPhone()),"手机号格式不正确");

    }


}
