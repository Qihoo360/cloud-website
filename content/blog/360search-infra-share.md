+++
title = "360搜索容器云探索与实践"
date = "2018-11-13T14:07:31+02:00"
tags = ["kubernetes","docker","cloud"]
categories = ["qihoo"]
banner = "img/banners/search-cloud.png"
author = "WilliamGuo"
authorLink = "https://wilhelmguo.cn"
+++

【编者的话】随着容器化进程的加速，容器编排的需求也越来越强烈。而容器编排也经历了从Kubernetes、Mesos和Swarm三足鼎立到今天的Kubernetes一统江湖的局面。现在越来越多的公司选择基于Kubernetes来构建企业内部的私有云。本次分享将为大家介绍360搜索基于Kubernetes打造私有云的整体架构，以及遇到的一些问题和解决方案，希望可以使大家在打造私有云过程中少走一些弯路。

本次主要从以下几个方面介绍360搜索云平台的构建历程：

- 发展历程
- 架构设计
- Wayne平台
- 踩过的一些坑
- 发展方向

## 发展历程

### 发展初衷
- 快速迭代：提升上线效率，开发自助上线并可以快速回滚。
- 提高资源利用率：不用类型业务混布，充分利用机器资源。

### 发展历史
360搜索从2016年开始探索基于Kubernetes打造公司私有云平台，由于当时Kuebrnetes对有状态服务支持力度有限以及历史遗留业务容器化难度较大，因此Kubernetes主要负责部署一些无状态的Web服务。

从2017年开始Kubernetes逐渐在私有云市场占据了绝对优势，已然成为容器编排的标准。同时Kubernetes对有状态的服务支持逐渐完善，我们开始完全基于Kubernetes打造私有云平台。目前已稳定运行上万台容器。


## 架构设计

下图是云平台整体架构

![](/img/blog/search-cloud.png?classes=border,shadow)

### 网络

#### Flannel时代
早期使用的是Flannel VXLAN网络模型，存在转发表项太多的问题。
![](/img/blog/network1.png?classes=border,shadow)
后面flannel优化，降低了转发表项
![](/img/blog/network2.png?classes=border,shadow)

接入方面使用ExternalIP边缘节点的模式，由iptables做nat
![](/img/blog/network3.png?classes=border,shadow)

后面做了dsr优化，回程数据包不走flannel网卡
![](/img/blog/network4.png?classes=border,shadow)

#### Calico时代
由于集群规模扩张，同时公司基础网络也支持了BGP，所有集群都迁移到了Calico。
下图是calico的通讯模式，去掉了vxlan造成的overhead
![](/img/blog/network5.png?classes=border,shadow)

IDC网络模型
![](/img/blog/network6.png?classes=border,shadow)

关于calico的一些改造点

- 服务器相同as号，方便部署
- 使用原有默认路由，ToR不向下宣告路由
- 聚合到27位路由，宣告给ToR
- 通过annotation实现32位路由

网络改造具体详见团队同事的文章[容器网络——从CNI到Calico](http://dockone.io/article/2578)

### 存储

由于搜索有状态的业务较多，最早有状态的服务无法迁移，自己维护了一套Gluster集群，支持了很长一段时间业务存储。
后来公司存储团队提供了Ceph RBD和Cephfs存储服务，有状态的业务逐渐迁移到了Ceph。存储管理自己开发了Robin（即将开源，敬请期待）组件，用于管理RBD的image对象以及Cephfs的路径。

### 日志

目前我们的日志搜集方式是业务输出日志到std，Docker将std输出存放到日志目录，Kubelet通过软连的方式连接到/var/log/containers目录。
早期日志是Logstash统一到/var/log/containers目录下搜集，经过处理发送到Kafka，之后业务去Kafka消费或者直接进HDFS。但随着业务日志量的增加，Logstash耗费资源越来越多，日志积压也越来越严重，此时Filebeat功能已经逐渐完善，但缺少了一些解析Kubernetes资源的功能，于是我们自己扩展了一下Filebeat，自己实现了一个Kubernetes Processor，用于增加Kubernetes的相关标签，比如Deployment Name、Pod Name等。同时还做了一些性能优化，使得单机处理能力大幅提升。具体可以参见我之前写过的博客[Filebeat优化实践](https://wilhelmguo.tk/blog/post/william/Filebeat%E4%BC%98%E5%8C%96%E5%AE%9E%E8%B7%B5)

## Wayne平台（即将开源，敬请期待）

Kubernetes虽然很强大，但并不是万能的，要打造一个简单易用的云平台仅仅有Kubernetes是远远不够的。比如： 

- Kubernetes配置过于复杂，直接让开发人员配置Kubernetes对象难度太高，而且也比较容易出错

- 由于Kubernetes对权限管理并不完善，不同人员分配不同的权限实现比较困难

- Kubernetes想要快速回滚到历史版本比较困难，虽然Deployment保留了历史的RS对象，但是很难知道每个版本做了什么更改，想要快速回滚也比较困难。

此时，Wayne作为一个私有云平台的统一入口应运而生。

### Wayne简介

**Wayne**是一个通用的、基于Web的[Kubernetes](https://kubernetes.io)多集群一站式可视化管理平台。内置了丰富多样的功能，满足企业的通用需求，同时插件化的方式可以方便集成定制化功能。

Wayne已大规模服务于360搜索，承载了公司绝大部分业务，稳定管理了上万个容器。


### Wayne可以做什么？

- 可视化操作：提供直观、简便的方式操作Kubernetes集群，减小学习成本，快速上线业务。
- 多样的编辑模式：支持图形化编辑，也支持Json、Yaml两种高级定制化编辑模式。
- 微内核架构：采用可扩展的插件化方式开发，定制化选择特性功能，更方便的集成符合企业需求的新功能。
- 多集群管理：可以同时管理多个Kubernetes集群，更方便的管理多个集群。
- 丰富的权限管理：将资源抽象化为部门、项目级别，角色的权限可以更细化的控制，适用于多部门、多项目的统一集中管理。

- 多种登录模式：支持企业级LDAP登录、支持OAuth2登录，支持数据库登录多种模式。

- 完备的审计：所有操作都会有完整的审计功能，方便追踪操作历史。

- 开放平台：支持APIKey开放平台，用户可自主申请相关APIKey并管理自己的项目。

- 多层次监控：提供多级别的监控统计信息，实时关注集群的运行状态。

### 集成WebShell

为了方便用户在线查看日志及进入容器调试，Wayne集成了WebShell功能，用户可以查看Pod列表并且可以进入容器进行调试。


## 踩过的一些坑

- Pod健康检查正常，但通过边缘节点无法访问到这个节点上的Pod。 

原因：由于我们之前试用的是Flannel网络，Flannel挂了无法正常启动，会导致这台机器上的服务无法正常访问。
解决方案：需要监控Falnnel组件的状态，如果异常立即报警。

- Deployment滚动更新过程中流量负载均衡异常,会出现丢失请求的情况

原因：Pod Terminating过程中，有些机器的Iptable还未刷新，导致部分流量仍然请求到Terminating的Pod上，导致请求出错。详情参见： 

https://github.com/kubernetes/kubernetes/issues/47597 
https://github.com/kubernetes/kubernetes/issues/43576

解决方案：利用Kubernetes的preStop特性为每个Pod设置一个退出时间，让每个Pod收到退出信号时时默认等待一段时间再退出。

- Kubernetes1.9之前Apiserver挂掉之后Kubernetes Endpoints不更新，导致部分访问失败。

原因：Kubernetes1.9之前只要Apiserver启动成功Kubernetes Endpoints便不再更新，需手动维护。
解决方案：
升级到Kubernetes 1.10版本后设置 --endpoint-reconciler-type = lease 
Use an endpoint reconciler (master-count, lease, none)

- Iptables莫名丢弃syn包

``` bash
0xffffffff815a6a0b : nf_hook_slow+0xeb/0x110 [kernel]
0xffffffff815b6bee : ip_output+0xce/0xe0 [kernel]
0xffffffff815b2646 : ip_forward_finish+0x66/0x80 [kernel]
0xffffffff815b29c7 : ip_forward+0x367/0x470 [kernel]
0xffffffff815b062a : ip_rcv_finish+0x8a/0x350 [kernel]
0xffffffff815b0fb6 : ip_rcv+0x2b6/0x410 [kernel]
0xffffffff8156f9e2 : __netif_receive_skb_core+0x582/0x800 [kernel]
0xffffffff8156fc78 : __netif_receive_skb+0x18/0x60 [kernel]
0xffffffff8156fd00 : netif_receive_skb_internal+0x40/0xc0 [kernel]
0xffffffff81570e88 : napi_gro_receive+0xd8/0x130 [kernel]
0xffffffffa0164df6 : ixgbe_clean_rx_irq+0x466/0xa70 [ixgbe]
0xffffffffa01661bb : ixgbe_poll+0x38b/0x840 [ixgbe]
0xffffffff81570510 : net_rx_action+0x170/0x380 [kernel]
0xffffffff8108f2cf : __do_softirq+0xef/0x280 [kernel]
0xffffffff8108f498 : run_ksoftirqd+0x38/0x50 [kernel]
0xffffffff810b927f : smpboot_thread_fn+0x12f/0x180 [kernel]
0xffffffff810b06ff : kthread+0xcf/0xe0 [kernel]
0xffffffff81696958 : ret_from_fork+0x58/0x90 [kernel]
```
![](/img/blog/network7.png?classes=border,shadow)

原因:这个是nf_conntrack设计时对性能的权衡，使用rcu锁，导致snat可能获取到重复的local port，然后丢弃报文，上面是内核中一些函数调用链，具体代码不展开了

![](/img/blog/network8.png?classes=border,shadow)

解决方案：
有两种缓解方式

 1. 增加local ip数量，降低冲突概率
 2. snat中local port选择增加随机过程，实际上centos内核模块有这个功能，只是centos7上iptables命令没实现，可以通过修改iptables代码，在netlink调用时加入NF_NAT_RANGE_PROTO_RANDOM_FULLY

## 未来发展方向

- Wayne开源

360搜索私有云平台在搭建过程中从很多CNCF项目中收益，本着取之开源，回馈开源的精神，我们决定将Wayne平台开源，并且会持续开发和长期维护。考虑到目前官方Dashboard并不太好用，而且不支持多集群和多租户管理。相信Wayne的开源会给很多人带来收益。
> 项目地址[https://github.com/Qihoo360/wayne](https://github.com/Qihoo360/wayne) 

- 服务更多业务迁移

目前私有云平台服务容器仅有上万个，还有大量业务没有迁移上云，之后会加大力度协助适合的业务迁移到云平台。
