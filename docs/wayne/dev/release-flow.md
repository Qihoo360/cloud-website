# 发版流程

## 环境准备

推荐在 Linux（CentOS 7.0）环境进行发版操作，同时支持 macOS 下发版，需要注意的是，在 macOS 下 sed 命令的表现和 linux 下存在差异，需要安装 gnu-sed：

```bash
brew install gnu-sed
export PATH="/usr/local/opt/gnu-sed/bin/$PATH"
```

发版流程使用了 git extras([github 地址](https://github.com/tj/git-extras)), 请一并确保安装。

## 正常流程

版本号概念：

对于版本号 x.y.z-c 中， x 为主版本号，y 为次版本号，z 为修订版本号，c 为先行版本号，如非必要，请不要使用先行版本号。

Wayne 包含四类分支：

- master 分支
- release 分支
- hotfix 分支
- feature 分支

除了 master 分支以外，分支命名的格式为 release/*、hotfix/*、feature/*。master 分支上保留的是最新的可用代码，所有的发版都应该是紧靠 master 分支的，release 分支上保留的是特定版本或者版本组的代码，在 wayne 中会使用 release/x.y 格式的分支，这种分支用于明确主版本号和次版本号，在该分支上，可以创建对应的修订版和先行版本号。

例如，在 release/1.2 分支上，可能存在 1.2.0、1.2.1-alpha 和 1.2.1 三个版本，且版本顺序依次递增。

通常情况下，master 分支的代码和 release 分支的代码都是可靠的。

feature 分支应当从 master 分支上 checkout （事实上也可以从最新的 release 分支上 checkout，因为该分支是紧靠 master 分支的），合并 feature 的代码，要同时合并到 master 分支和 最新的 release 分支。

hotfix 分支用于修复 bug，如非 bug，禁止使用 hotfix 分支。hotfix 分支应当从存在 bug 的分支上 checkout，并最终合并到所有存在 bug 的分支上。

以下介绍发布版本的流程。

发布修订版和先行版需要在对应的 release 分支上进行，如果升级主版本号和此版本号，则需要从 master 分支上重新 checkout 对应的 release 分支（因为对应的 release 分支并不存在）。


-  切换到 release 分支，保持当前代码最新。

```bash
git checkout release/x.y # 非修订版和先行版 需要 git checkout -b release/x.y 
git pull
```

- 更改前后端代码中的版本号与 release 分支的目标版本号一致
- 更新 CHANGELOG.md
- 提交更改
- 创建里程碑（git tag x.y.z-c）
- release 分支代码 merge 回 master 分支
- 把 master 分支、release 分支和 tag 推送到远程仓库

#### 上述 6 个步骤可以通过 bump.sh 脚本实现，只需按照提示执行即可，例如，如果发布版本 1.2.3，只需执行 ./bump.sh 1.2.3

## bump.sh 和版本

Wayne 的版本格式是 x.y.z 的形式，只允许通过 bump.sh 来创建版本。

Wayne 可以传递一个参数，如果不传递，默认进行修订版更新，即 z=z+1。 用户可以传递一个 x.y.z 格式的版本，也可以传递 major、minor 或者 patch，分别对应着主版本号、次版本号和修订版本号更新。

假定当前版本是 1.2.3：

```bash
./bump.sh 2.0.0 # 新版本号 2.0.0
./bump.sh major # 新版本号 2.0.0
./bump.sh minor # 新版本号 1.3.0
./bump.sh patch # 新版本号 1.2.4
```
