package com.yjxxt.crm.model;/*     
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/26
  Time: 15:29
  To change this template use File | Settings | File Templates.
*/

public class TreeModule {
    private Integer id;
    private Integer pId;
    private String name;
    private boolean checked =false;

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
