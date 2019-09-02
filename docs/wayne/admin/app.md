# 项目

## 简介

项目配置主要说明如何在 Wayne 平台上创建和管理项目

## 创建项目

拥有 APP_CREATE 权限的用户可以在前台自助创建项目，管理员用户也可以在后台创建和编辑项目。

![](../images/admin-app.gif?classes=border,shadow)

项目元数据说明：

```
{
  // 访问模式，如果配置了 beta 模式，则点击项目详情自动跳转到 beta 域名
  "mode": "beta",
  // 项目内资源名称拼接规则，此配置会覆盖全局数据库配置 system.api-name-generate-rule
  "system.api-name-generate-rule":"none"
}
```