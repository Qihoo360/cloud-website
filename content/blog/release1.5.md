+++
title = "Kubernetes 多集群管理平台 Wayne v1.5.0 版本正式发布(完全代替官方dashbord)"
date = "2019-03-01T13:07:31+02:00"
tags = ["kubernetes"]
categories = ["wayne"]
banner = "img/banners/release1.5.png"
author = "WilliamGuo"
authorLink = "https://wilhelmguo.cn"
+++

不负众望，1.5.0版本正式发布 https://github.com/Qihoo360/wayne/releases 本次更新基本涵盖了Kubernetes常用资源管理（可以彻底抛弃官方dashbord啦），并且还增加了service和ingress自动注入注解，更好的支持了公有云。

## 更新详情：

## [v1.5.0](https://github.com/Qihoo360/wayne/tree/v1.5.0) (2019-03-01)
[Full Changelog](https://github.com/Qihoo360/wayne/compare/v1.4.3...v1.5.0)

**Implemented enhancements:**

- Model support toggle full screen [\#311](https://github.com/Qihoo360/wayne/issues/311)
- Support command and args  [\#300](https://github.com/Qihoo360/wayne/issues/300)
- Tpl edit add imagepullpolicy [\#326](https://github.com/Qihoo360/wayne/pull/326) ([wilhelmguo](https://github.com/wilhelmguo))
- confirm height 100 screen [\#323](https://github.com/Qihoo360/wayne/pull/323) ([BennieMeng](https://github.com/BennieMeng))
- frontend: remove modal padding [\#320](https://github.com/Qihoo360/wayne/pull/320) ([BennieMeng](https://github.com/BennieMeng))
- create-edit component rebuild [\#319](https://github.com/Qihoo360/wayne/pull/319) ([BennieMeng](https://github.com/BennieMeng))
- Deploy status optimization [\#315](https://github.com/Qihoo360/wayne/pull/315) ([wilhelmguo](https://github.com/wilhelmguo))
- Container template support add command and args [\#308](https://github.com/Qihoo360/wayne/pull/308) ([wilhelmguo](https://github.com/wilhelmguo))
- admin sidenav url change location [\#305](https://github.com/Qihoo360/wayne/pull/305) ([BennieMeng](https://github.com/BennieMeng))
- Migration Ingress from exist kubernetes clusters [\#135](https://github.com/Qihoo360/wayne/issues/135)
- Secret template support set type [\#114](https://github.com/Qihoo360/wayne/issues/114)
- Add kubernetes daemonset resource [\#285](https://github.com/Qihoo360/wayne/pull/285) ([wilhelmguo](https://github.com/wilhelmguo))
- Add kubernetes statefulset resource [\#282](https://github.com/Qihoo360/wayne/pull/282) ([wilhelmguo](https://github.com/wilhelmguo))
- Kubernetes add ingress resource [\#279](https://github.com/Qihoo360/wayne/pull/279) ([wilhelmguo](https://github.com/wilhelmguo))
- 增加集群和命名空间级别自定义注解 [\#274](https://github.com/Qihoo360/wayne/pull/274) ([iyacontrol](https://github.com/iyacontrol))
- Add Kubernetes pod enter container action [\#298](https://github.com/Qihoo360/wayne/pull/298) ([wilhelmguo](https://github.com/wilhelmguo))
- Add annotations to namespace in backend page [\#295](https://github.com/Qihoo360/wayne/pull/295) ([chengyumeng](https://github.com/chengyumeng))
- Add kubernetes rbac resources [\#294](https://github.com/Qihoo360/wayne/pull/294) ([wilhelmguo](https://github.com/wilhelmguo))
- Add kubernetes hpa support [\#293](https://github.com/Qihoo360/wayne/pull/293) ([wilhelmguo](https://github.com/wilhelmguo))
- Add kubernetes pvc and storageclass support [\#291](https://github.com/Qihoo360/wayne/pull/291) ([wilhelmguo](https://github.com/wilhelmguo))
- Add kubernetes replicaset resource [\#289](https://github.com/Qihoo360/wayne/pull/289) ([wilhelmguo](https://github.com/wilhelmguo))
- Kubernetes cronjob and job support [\#287](https://github.com/Qihoo360/wayne/pull/287) ([wilhelmguo](https://github.com/wilhelmguo))

**Fixed bugs:**

- 通过后台迁移configmap和ingress，在前台页面进行编辑时无法分配机房 [\#313](https://github.com/Qihoo360/wayne/issues/313)
- 一级菜单栏会被白色样式覆盖 [\#303](https://github.com/Qihoo360/wayne/issues/303)
- wayne worker run into Infinite loop if rabbitmq is down [\#245](https://github.com/Qihoo360/wayne/issues/245)
- Fix worker lost connection will fall into an infinite loop [\#322](https://github.com/Qihoo360/wayne/pull/322) ([wilhelmguo](https://github.com/wilhelmguo))
- 创建配置集模板提示404错误 [\#281](https://github.com/Qihoo360/wayne/issues/281)
- Fix list pvs status error [\#306](https://github.com/Qihoo360/wayne/pull/306) ([wilhelmguo](https://github.com/wilhelmguo))
- fix when exchange from table to json can not add updated data [\#301](https://github.com/Qihoo360/wayne/pull/301) ([chengyumeng](https://github.com/chengyumeng))
- fix edit template metadata miss adjust [\#297](https://github.com/Qihoo360/wayne/pull/297) ([BennieMeng](https://github.com/BennieMeng))
- fix pagechange invalid [\#292](https://github.com/Qihoo360/wayne/pull/292) ([BennieMeng](https://github.com/BennieMeng))
- fix paginate page change [\#286](https://github.com/Qihoo360/wayne/pull/286) ([BennieMeng](https://github.com/BennieMeng))
- Fix create or clone configtpl url redirect error [\#283](https://github.com/Qihoo360/wayne/pull/283) ([wilhelmguo](https://github.com/wilhelmguo))
