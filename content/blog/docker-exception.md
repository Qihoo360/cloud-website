+++
title = "Docker 异常总结"
date = "2018-12-14T13:07:31+02:00"
tags = ["docker"]
categories = ["docker"]
banner = "img/blog/docker.png"
author = "WilliamGuo"
authorLink = "https://wilhelmguo.cn"
+++

提起容器，大家可能首先想到的是 Docker，Docker 已经当之无愧的成为容器界巨头。如果你使用 Kubernetes 作为私有云的解决方案，Docker 也是首选的容器解决方案。虽然 Docker 很优秀，但 Docker 并不是完美的，甚至存在很多问题。下面介绍我们下在生产环境中遇到的关于 Docker    的一些问题及排查过程。避免大家再踩坑。

![](/img/blog/docker.png?classes=border,shadow)

## 异常一

`docker ps` 无响应， Node 节点表现为 NotReady。

### 运行信息

``` bash
$ docker -v
$ Docker version 17.03.2-ce, build f5ec1e2

$ docker-containerd -v
$ containerd version 0.2.3 commit:4ab9917febca54791c5f071a9d1f404867857fcc

$ docker-runc -v
$ runc version 1.0.0-rc2
$ commit: 54296cf40ad8143b62dbcaa1d90e520a2136ddfe
$ spec: 1.0.0-rc2-dev
```

### 启用 Docker Debug 模式
有两种方法可以启用调试。 建议的方法是在 `daemon.json` 文件中将 `debug` 设置为 `true`。 此方法适用于每个 Docker 平台。

1.编辑 `daemon.json` 文件，该文件通常位于 `/etc/docker/` 中。 如果该文件尚不存在，您可能需要创建该文件。
2.增加以下设置

``` json
{
  "debug": true
}
```
3.向守护程序发送 HUP 信号以使其重新加载其配置。 

```bash
sudo kill -SIGHUP $(pidof dockerd)
```

可以看到 Docker debug 级别的日志：

``` bash
Dec 14 20:04:45 dockerd[7926]: time="2018-12-14T20:04:45.788669544+08:00" level=debug msg="Calling GET /v1.27/containers/json?all=1&filters=%7B%22label%22%3A%7B%22io.kubernetes.docker.type%3Dpodsandbox%22%3Atrue%7D%7D&limit=0"
Dec 14 20:04:45 dockerd[7926]: time="2018-12-14T20:04:45.790628950+08:00" level=debug msg="Calling GET /v1.27/containers/json?all=1&filters=%7B%22label%22%3A%7B%22io.kubernetes.docker.type%3Dcontainer%22%3Atrue%7D%7D&limit=0"
Dec 14 20:04:46 dockerd[7926]: time="2018-12-14T20:04:46.792531056+08:00" level=debug msg="Calling GET /v1.27/containers/json?all=1&filters=%7B%22label%22%3A%7B%22io.kubernetes.docker.type%3Dpodsandbox%22%3Atrue%7D%7D&limit=0"
Dec 14 20:04:46 dockerd[7926]: time="2018-12-14T20:04:46.794433693+08:00" level=debug msg="Calling GET /v1.27/containers/json?all=1&filters=%7B%22label%22%3A%7B%22io.kubernetes.docker.type%3Dcontainer%22%3Atrue%7D%7D&limit=0"
Dec 14 20:04:47 dockerd[7926]: time="2018-12-14T20:04:47.097363259+08:00" level=debug msg="Calling GET /v1.27/containers/json?filters=%7B%22label%22%3A%7B%22io.kubernetes.docker.type%3Dpodsandbox%22%3Atrue%7D%7D&limit=0"
Dec 14 20:04:47 dockerd[7926]: time="2018-12-14T20:04:47.098448324+08:00" level=debug msg="Calling GET /v1.27/containers/json?all=1&filters=%7B%22label%22%3A%7B%22io.kubernetes.docker.type%3Dcontainer%22%3Atrue%7D%2C%22status%22%3A%7B%22running%22%3Atrue%7D%7D&limit=0"
Dec 14 20:04:47 dockerd[7926]: 
```
`dockerd`一直在请求 list containers 接口，但是没有响应。

### 打印堆栈信息
``` bash
$ kill -SIGUSR1 $(pidof dockerd)
```
生成的调试信息可以在以下目录找到：
``` bash
...goroutine stacks written to /var/run/docker/goroutine-stacks-2018-12-02T193336z.log
...daemon datastructure dump written to /var/run/docker/daemon-data-2018-12-02T193336z.log
```
查看 goroutine-stacks-2018-12-02T193336z.log 文件内容，

``` bash
goroutine 248 [running]:
github.com/docker/docker/pkg/signal.DumpStacks(0x18fe090, 0xf, 0x0, 0x0, 0x0, 0x0)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/pkg/signal/trap.go:82 +0xfc
github.com/docker/docker/daemon.(*Daemon).setupDumpStackTrap.func1(0xc421462de0, 0x18fe090, 0xf, 0xc4203c8200)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/daemon/debugtrap_unix.go:19 +0xcb
created by github.com/docker/docker/daemon.(*Daemon).setupDumpStackTrap
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/daemon/debugtrap_unix.go:32 +0x10a

goroutine 1 [chan receive, 91274 minutes]:
main.(*DaemonCli).start(0xc42048a840, 0x0, 0x190f560, 0x17, 0xc420488400, 0xc42046c820, 0xc420257320, 0x0, 0x0)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/cmd/dockerd/daemon.go:326 +0x183e
main.runDaemon(0x0, 0x190f560, 0x17, 0xc420488400, 0xc42046c820, 0xc420257320, 0x10, 0x0)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/cmd/dockerd/docker.go:86 +0xb2
main.newDaemonCommand.func1(0xc42041f200, 0xc42045df00, 0x0, 0x10, 0x0, 0x0)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/cmd/dockerd/docker.go:42 +0x71
github.com/docker/docker/vendor/github.com/spf13/cobra.(*Command).execute(0xc42041f200, 0xc42000c130, 0x10, 0x11, 0xc42041f200, 0xc42000c130)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/vendor/github.com/spf13/cobra/command.go:646 +0x26d
github.com/docker/docker/vendor/github.com/spf13/cobra.(*Command).ExecuteC(0xc42041f200, 0x16fc5e0, 0xc42046c801, 0xc420484810)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/vendor/github.com/spf13/cobra/command.go:742 +0x377
github.com/docker/docker/vendor/github.com/spf13/cobra.(*Command).Execute(0xc42041f200, 0xc420484810, 0xc420084058)
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/vendor/github.com/spf13/cobra/command.go:695 +0x2b
main.main()
        /root/rpmbuild/BUILD/docker-ce/.gopath/src/github.com/docker/docker/cmd/dockerd/docker.go:106 +0xe2

goroutine 17 [syscall, 91275 minutes, locked to thread]:

...
```

至此，我们可以确定，`containerd` 无响应导致的 `docker ps` 无响应，在堆栈中我们也可以看到调用 `containerd` 无响应是因为加了lock.

### 查看dmesg
通过 dmesg 查看系统异常信息,发现 `cgroup` 报 OOM 溢出错误。

``` bash
[7993043.926831] Memory cgroup out of memory: Kill process 20357 (runc:[2:INIT]) score 970 or sacrifice child
```

查看了大部分机器的 dmesg 信息，发现都有 OOM 这个错误，至此我们怀疑是由于某个容器 OOM 导致的 containerd 无响应.

### 模拟OOM

既然怀疑是容器 OOM 异常导致的 containerd 无响应，那我们干脆自己创造现场模拟一下。

首选我们创建一个 OOM 的部署，通过 nodeSelector 让这个部署调度到指定 Node。

``` yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    wayne-app: oomtest
    wayne-ns: test
    app: oomtest
  name: oomtest
spec:
  selector:
    matchLabels:
      app: oomtest
  template:
    metadata:
      labels:
        wayne-app: oomtest
        wayne-ns: test
        app: oomtest
    spec:
      nodeSelector:
        kubernetes.io/hostname: test-001
      containers:
        - resources:
            limits:
              memory: 0.2Gi
              cpu: '0.2'
            requests:
              memory: 0.2Gi
              cpu: '0.1'
          args:
            - '-m'
            - '10'
            - '--vm-bytes'
            - 128M
            - '--timeout'
            - 60s
            - '--vm-keep'
          image: progrium/stress
          name: stress

```
发现过了一会 test-001 这台 Node 出现了 `docker ps` 无响应的情况，查看 `dmesg` 以及 `containerd` 的堆栈信息，发现和之前的 Node 出现的异常一致。至此，基本可以确定是某个容器 OOM
 导致的 containerd hung 住。

### 原因分析

通过查找社区 Issues 及相关 PR，最后发现根本原因是 runc 的bug。

使用 `runc start` 或 `runc run` 启动容器时，stub process（runc [2：INIT]）打开一个 `fifo` 进行写入。 它的父 runc 进程
将打开相同的 fifo 阅读。 通过这种方式，它们可以同步。

如果 stub process 在错误的时间退出，那么父 `runc` 进程
会永远被阻塞。

当两个 `runc` 操作相互竞争时会发生这种情况：`runc run / start` 和 `runc delete`。 它也可能由于其他原因而发生，
例如 内核的 OOM killer 可以选择杀死 stub process。

### 解决方案：

通过解决 exec fifo 竞争来解决这个问题。 如果
在我们打开 fifo 之前 stub process 退出，那么返回一个错误。

### 小结

`containerd` 官方已经在 v1.0.2 版本合并了这个修改。因此这个问题可以通过升级 Docker 版本解决。我们目前已经将部分机器升级到 Docker 18.06。 已升级的机器暂时未发现类似问题。

相关issues：
[https://github.com/containerd/containerd/issues/1882](https://github.com/containerd/containerd/issues/1882)
[https://github.com/containerd/containerd/pull/2048](https://github.com/containerd/containerd/pull/2048)
[https://github.com/opencontainers/runc/pull/1698](https://github.com/opencontainers/runc/pull/1698)

## 异常二
Docker 在 Centos 系统下以 direct-lvm 模式运行, 无法启动

``` bash
Error starting daemon: error initializing graphdriver: devicemapper: Non existing device docker-thinpool
Dec 14 03:21:03 two-slave-41-135 systemd: docker.service: main process exited, code=exited, status=1/FAILURE
Dec 14 03:21:03 two-slave-41-135 systemd: Failed to start Docker Application Container Engine.
Dec 14 03:21:03 two-slave-41-135 systemd: Dependency failed for kubernetes Kubelet.
Dec 14 03:21:03 two-slave-41-135 systemd: Job kubelet.service/start failed with result 'dependency'.
```

### 根本原因
这个问题发生在使用 devicemapper 存储驱动时Docker试图重用之前使用 LVM thin pool。例如，尝试更改节点上的 Docker 的数据目录时会发生此问题。由于安全措施旨在防止 Docker 因配置问题而意外使用和覆盖 LVM thin pool 中的数据，因此会发生此错误。

### 解决方案
要解决阻止Docker启动的问题，必须删除并重新创建逻辑卷，以便Docker将它们视为新的thin pool。

> 警告：这些命令将清除Docker数据目录中的所有现有镜像和卷。 请在执行这些步骤之前备份所有重要数据。

1.停止 Docker

```bash
sudo systemctl stop docker.service
```
2.删除 Dodcker 目录

```bash
sudo rm -rf /var/lib/docker
```
3.删除已经创建的 thin pool 逻辑卷

``` bash
$ sudo lvremove docker/thinpool
Do you really want to remove active logical volume docker/thinpool? [y/n]: y
  Logical volume "thinpool" successfully removed
```
4.创建新的逻辑卷

``` bash
lvcreate -L 500g --thin docker/thinpool --poolmetadatasize 256m
```
> 根据实际磁盘大小调整 thinpool 和 metadata 大小

### Docker自动direct-lvm模式配置

如果您想要让Docker自动为您配置direct-lvm模式，请继续执行以下步骤。

1.编辑`/etc/docker/daemon.json`文件以将`dm.directlvm_device_force = value`从`false`更改为`true`。 例如：

``` bash
{
  "storage-driver": "devicemapper",
  "storage-opts": [
    "dm.directlvm_device_force=true"
  ]
}
```
2.除了删除逻辑卷之外，还要删除docker卷组：

``` bash
$ sudo vgremove docker
```
3.启动Dokcer

``` bash
sudo systemctl start docker.service
```

## 总结

Docker 虽然是目前最常用的容器解决方案，但它仍旧有很多不足。

- Docker 的隔离性比较弱，混布容易导致业务互相影响，可能因为一个服务有问题就会影响其他服务甚至影响整个集群。
- Docker 自己存在一些 bug， 由于历史原因，很多 bug 无法完全归因于内核或者 Docker，需要 Docker 和内核配合修复。

所以如果你使用 Docker 作为容器的解决方案，推荐使用较新稳定版，毕竟新版已经修复了很多 bug，没必要自己再踩一遍坑。较新版 Kubernetes 也已经完整支持新版 Docker，具体可以参考[https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#external-dependencies](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#external-dependencies)


