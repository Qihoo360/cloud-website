## Wayne 是什么？

Wayne 是一个通用的、基于 Web 的 **[Kubernetes](https://kubernetes.io)  多集群管理平台**。通过可视化 Kubernetes 对象模板编辑的方式，降低业务接入成本，
拥有完整的权限管理系统，适应多租户场景，是一款适合企业级集群使用的**发布平台**。

Wayne 已大规模服务于 360 搜索，承载了内部绝大部分业务，稳定管理了近千个业务，上万个容器，运行了两年多时间，经受住了生产的考验。

> 命名的起源：360 搜索私有云团队多数项目命名都来源于 DC 漫画的角色，Wayne 也不例外，[Wayne](https://en.wikipedia.org/wiki/Batman#Bruce_Wayne) 是声名显赫的超级英雄蝙蝠侠 Bruce Wayne 的名字。


![](images/dashboard-ui.png?classes=border,shadow)

## 架构图

整体采用前后端分离的方案，其中前端采用 Angular 框架进行数据交互和展示，使用 Ace 编辑器进行 Kubernetes 资源模版编辑。后端采用 Beego 框架做数据接口处理，使用 Client-go 与 Kubernetes 进行交互，数据使用 MySQL 存储。

![](images/architecture.png?classes=border,shadow)

## 组件

- Web UI: 提供完整的业务开发和平台运维功能体验。
- Worker: 扩展一系列基于消息队列的功能，例如 audit 和 webhook 等审计组件。

> 各组件部署方式请参照 [部署流程](summary/deploy.md)

## 文档

Wayne文档包含以下类型：

- 概述：包含 Wayne 的整体介绍，并包含本项目开发、部署、发版等流程。
- 开发者指南：适合 Wayne 开发者或者想为 Wayne 贡献 PR 的用户阅读。
- 管理员后台指南：指导 Kubernetes 集群运维团队将线上集群和 Wayne 集成起来，并介绍相关管理功能。
- 用户界面（开发/运维/测试工程师等）使用指南： 指导上云业务开发者如何使用 Wayne 部署自己开发的业务到 Kubernetes 集群中。
