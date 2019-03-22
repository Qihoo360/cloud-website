# 开放 API

## 简介
本文档主要讲解开放 API 的设计和使用方法。

开放 API 是 wayne 提供的一组通过具有特定访问权限的 APIKey 调用的 Web API，可以绕过浏览器的登录状态访问资源。开放 API 的接口文档使用 swagger 2.0 格式，通过     [go-swagger](https://github.com/go-swagger/go-swagger)  生成。

## APIKey 的权限

OpenAPI 使用的 APIKey 需要具备对应的权限，目前支持如下图所示的权限，分别用于对应的 action。 

![权限列表](../images/openapi-permission.png?classes=border,shadow)

APIKey 的类型分为全局、部门和项目，使用范围依次收缩。创建 APIKey 的时候需要把 APIKey 绑定到具有所需权限的角色之上。

![创建 APIKey](../images/create-apikey.png?classes=border,shadow)

## 使用

> 开放 API 的文档使用 swagger 编排，请参照 [Wayne OpenAPI Swagger](https://github.com/Qihoo360/wayne/blob/master/src/backend/swagger/openapi.swagger.json)

