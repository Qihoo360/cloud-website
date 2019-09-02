# 负载均衡（Service）

## 简介

Pods 是有生命周期的。创建、运行、销毁。虽然 Deployment（部署）等保证了系统会达到我们所要求的实例数量。
但是每个 Pod 都有自己的 IP 地址，他们重新创建后 IP 会发生变化。
这导致了一个问题：如果某些 Pod 为 Kubernetes 集群内的其他 Pod 提供功能，那么应该通过什么方式来访问？

## 定义

Service 是一组 Pod 对象的抽象，通过 label 标签可以关联到相应的实例。

## 最佳实践

在 wayne 中，存在一组默认 label：wayne-ns、wayne-app、app，分别代表 Pod 所属的部门、项目和资源（部署、状态副本集等）名。因此强烈建议用户在创建 Service 的时候和对应的默认 label 耦合。

> 注意：上线了一个 service 后，如果需要修改 service 类型，需要把当前 service 下线，新的模板才能生效！

![示例](../images/portal-service.png?classes=border,shadow)
