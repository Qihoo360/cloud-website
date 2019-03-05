## Wayne 是什么？

Wayne 是一个通用的、基于 Web 的 **[Kubernetes](https://kubernetes.io)  多集群管理平台**。通过可视化 Kubernetes 对象模板编辑的方式，降低业务接入成本，
拥有完整的权限管理系统，适应多租户场景，是一款适合企业级集群使用的**发布平台**。

Wayne已大规模服务于360搜索，承载了内部绝大部分业务，稳定管理了近千个业务，上万个容器，运行了两年多时间，经受住了生产的考验。

> 命名的起源：360 搜索私有云团队多数项目命名都来源于 DC 漫画的角色，Wayne 也不例外，[Wayne](https://en.wikipedia.org/wiki/Batman#Bruce_Wayne) 是声名显赫的超级英雄蝙蝠侠 Bruce Wayne 的名字。


![](images/dashboard-ui.png?classes=border,shadow)

## 架构图

整体采用前后端分离的方案，其中前端采用 Angular 框架进行数据交互和展示，使用Ace编辑器进行 Kubernetes 资源模版编辑。后端采用 Beego 框架做数据接口处理，使用 Client-go 与 Kubernetes 进行交互，数据使用 MySQL 存储。

![](images/architecture.png?classes=border,shadow)


## Features

- 基于 RBAC（Role based access control）的权限管理：用户通过角色与部门和项目关联，拥有部门角色允许操作部门资源，拥有项目角色允许操作项目资源，更加适合多租户场景。
- 简化 k8s 对象创建：提供基础 k8s 对象配置文件添加方式，同时支持高级模式直接编辑 Json/Yaml文件创建 k8s 对象。
- LDAP/OAuth 2.0/DB 多种登录模式支持：集成企业级 LDAP 登录及 DB 登录模式，同时还可以实现 OAuth2 登录。
- 支持多集群、多租户：可以同时管理多个 Kubernetes 集群，并针对性添加特定配置，更方便的多集群、多租户管理。
- 提供完整审计模块：每次操作都会有完整的审计功能，追踪用于操作历史，同时支持用户自定义 webhook。
- 提供基于 APIKey 的开放接口调用：用户可自主申请相关 APIKey 并管理自己的部门和项目，运维人员也可以申请全局 APIKey 进行特定资源的全局管理。
- 保留完整的发布历史：用户可以便捷的找到任何一次历史发布，并可轻松进行回滚，以及基于特定历史版本更新 k8s 资源。
- 具备完善的资源报表：用户可以轻松获取各项目的资源使用占比和历史上线频次（天级）以及其他基础数据的报表和图表。
- 提供基于严密权限校验的 web shell：用户可以通过 web shell 的形式进入发布的 Pod 进行操作，自带完整的权限校验。 
- 提供站内通知系统：方便管理员推送集群、业务通知和故障处理报告等。

## 组件

- Web UI: 提供完整的业务开发和平台运维功能体验。
- Worker: 扩展一系列基于消息队列的功能，例如 audit 和 webhook 等审计组件。

> 各组件部署方式请参照 [部署流程](summary/deploy.md)

## 文档

Wayne文档包含以下类型：

- 概述：包含 Wayne 的整体介绍，并包含本项目开发、部署、发版等流程。
- 开发者指南：适合 Wayne 开发者或者想为 Wayne 贡献 PR 的用户阅读。
- 管理员后台指南：指导 kubernetes 集群运维团队将线上集群和 Wayne 集成起来，并介绍相关管理功能。
- 用户界面（开发/运维/测试工程师等）使用指南： 指导上云业务开发者如何使用 Wayne 部署自己开发的业务到 kubernetes 集群中。
