## Wayne 是什么？

Wayne 是一个通用的、基于 Web 的 **[Kubernetes](https://kubernetes.io)  多集群管理平台**。通过可视化 Kubernetes 对象模板编辑的方式，降低业务接入成本，拥有完整的权限管理系统，适应多租户场景，是一款适合企业级集群使用的**发布平台**。

Wayne 已大规模服务于 360 搜索，承载了内部绝大部分业务，稳定管理了近千个业务，上万个容器，运行了两年多时间，经受住了生产的考验。

> 命名的起源：360 搜索私有云团队多数项目命名都来源于 DC 漫画的角色，Wayne 也不例外，[Wayne](https://en.wikipedia.org/wiki/Batman#Bruce_Wayne) 是声名显赫的超级英雄蝙蝠侠 Bruce Wayne 的名字。


![](images/dashboard-ui.png?classes=border,shadow)

## 架构图

整体采用前后端分离的方案，其中前端采用 Angular 框架进行数据交互和展示，使用 Ace 编辑器进行 Kubernetes 资源模版编辑。后端采用 Beego 框架做数据接口处理，使用 Client-go 与 Kubernetes 进行交互，数据使用 MySQL 存储。

![](images/architecture.png?classes=border,shadow)
